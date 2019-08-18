#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/time.h>

#define CL_HPP_TARGET_OPENCL_VERSION 120
#define CL_HPP_MINIMUM_OPENCL_VERSION 120
#define CL_USE_DEPRECATED_OPENCL_1_2_APIS
#include <CL/cl.h>

#include "err_code.h"

#define TOL (0.001)      // tolerance used in floating point comparisons
#define LENGTH (2 << 24) // length of vectors a, b, and c
#define MAX_SOURCE_SIZE (0x100000)

/** Get CPU time in microseconds */
static int64_t timeInMicros() {
  struct timeval tv;
  gettimeofday(&tv, NULL);
  return tv.tv_sec * 1000000 + tv.tv_usec;
}

int main(int argc, char *argv[]) {
  float *h_a = malloc(LENGTH * sizeof(float));
  float *h_b = malloc(LENGTH * sizeof(float));
  float *h_c = malloc(LENGTH * sizeof(float));
  memset(h_c, 0xdead, LENGTH * sizeof(float));

  // Fill vectors a and b with random float values
  int count = LENGTH;
  for (int i = 0; i < count; i++) {
    h_a[i] = rand() / (float)RAND_MAX;
    h_b[i] = rand() / (float)RAND_MAX;
  }

  /*Step1: Getting platforms and choose an available one.*/
  cl_uint numPlatforms;           // the NO. of platforms
  cl_platform_id platform = NULL; // the chosen platform
  cl_int status = clGetPlatformIDs(0, NULL, &numPlatforms);
  if (status != CL_SUCCESS) {
    fprintf(stderr, "Error: Getting platforms!\n");
    return -1;
  }

  /*For clarity, choose the first available platform. */
  if (numPlatforms > 0) {
    cl_platform_id *platforms = (cl_platform_id *)malloc(
        numPlatforms * sizeof(cl_platform_id));
    status = clGetPlatformIDs(numPlatforms, platforms, NULL);
    platform = platforms[0];
    free(platforms);
  }

  /*Step 2:Query the platform and choose the first GPU device if has
	 * one.Otherwise use the CPU as device.*/
  cl_uint numDevices = 0;
  cl_device_id *devices;
  status =
      clGetDeviceIDs(platform, CL_DEVICE_TYPE_GPU, 0, NULL, &numDevices);
  if (numDevices == 0) // no GPU available.
  {
    fprintf(stdout, "No GPU device available.\n");
    fprintf(stdout, "Choose CPU as default device.\n");
    status = clGetDeviceIDs(platform, CL_DEVICE_TYPE_CPU, 0, NULL,
                            &numDevices);
    devices =
        (cl_device_id *)malloc(numDevices * sizeof(cl_device_id));
    status = clGetDeviceIDs(platform, CL_DEVICE_TYPE_CPU,
                            numDevices, devices, NULL);
  } else {
    devices =
        (cl_device_id *)malloc(numDevices * sizeof(cl_device_id));
    status = clGetDeviceIDs(platform, CL_DEVICE_TYPE_GPU,
                            numDevices, devices, NULL);
  }

  size_t valueSize;
  char *value;
  clGetDeviceInfo(devices[0], CL_DEVICE_NAME, 0, NULL, &valueSize);

  value = (char *)malloc(valueSize);

  clGetDeviceInfo(devices[0], CL_DEVICE_NAME, valueSize, value, NULL);
  printf("Using OpenCL device: %s\n", value);

  /*Step 3: Create context.*/
  cl_context context =
      clCreateContext(NULL, 1, devices, NULL, NULL, NULL);

  /*Step 4: Creating command queue associate with the
	 * context.*/
  cl_command_queue commandQueue =
      clCreateCommandQueue(context, devices[0], 0, NULL);

  char *sourcepath = "my_kernel.cl";
  FILE *fp = fopen(sourcepath, "r");

  if (!fp) {

    fprintf(stderr, "Failed to open kernel file '%s': %s\n", sourcepath,

            strerror(errno));

    exit(2);
  }

  char *source_str = malloc(MAX_SOURCE_SIZE * sizeof(char));

  size_t source_size = fread(source_str, 1, MAX_SOURCE_SIZE, fp);

  cl_program program = clCreateProgramWithSource(context, 1, (const char **)&source_str, &source_size, NULL);

  status = clBuildProgram(program, 1, devices, NULL, NULL, NULL);

  cl_kernel kernel = clCreateKernel(program, "vadd", NULL);

  cl_mem d_a = clCreateBuffer(context, CL_MEM_READ_ONLY | CL_MEM_COPY_HOST_PTR,
                              LENGTH * sizeof(float), (void *)h_a, NULL);
  cl_mem d_b = clCreateBuffer(context, CL_MEM_READ_ONLY | CL_MEM_COPY_HOST_PTR,
                              LENGTH * sizeof(float), (void *)h_b, NULL);
  cl_mem d_c = clCreateBuffer(context, CL_MEM_WRITE_ONLY,
                              LENGTH * sizeof(float), NULL, NULL);

  int64_t start = timeInMicros();

  status = clSetKernelArg(kernel, 0, sizeof(cl_mem), (void *)&d_a);
  status = clSetKernelArg(kernel, 1, sizeof(cl_mem), (void *)&d_b);
  status = clSetKernelArg(kernel, 2, sizeof(cl_mem), (void *)&d_c);

  size_t global_work_size[1] = {LENGTH};
  status = clEnqueueNDRangeKernel(commandQueue, kernel, 1, NULL,
                                  global_work_size, NULL, 0, NULL, NULL);

  clFinish(commandQueue);
  int64_t stop = timeInMicros();
  printf("\nThe kernel ran in %8.2f milliseconds\n", (stop - start) / 1000.0);

  status = clEnqueueReadBuffer(commandQueue, d_c, CL_TRUE, 0,
                               LENGTH * sizeof(float), h_c, 0, NULL, NULL);

  // Test the results
  int correct = 0;
  float tmp;
  for (int i = 0; i < count; i++) {
    tmp = h_a[i] + h_b[i];       // expected value for d_c[i]
    tmp -= h_c[i];               // compute errors
    if (tmp * tmp < TOL * TOL) { // correct if square deviation is less
      correct++;                 //  than tolerance squared
    } else {
      printf(" tmp %f h_a %f h_b %f  h_c %f \n", tmp, h_a[i], h_b[i], h_c[i]);
    }
  }

  // summarize results
  printf("vector add to find C = A+B:  %d out of %d results were correct.\n",
         correct, count);
}
