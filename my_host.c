#include <assert.h>
#include <errno.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/time.h>
#include <unistd.h>

#define CL_HPP_TARGET_OPENCL_VERSION 200
#define CL_HPP_MINIMUM_OPENCL_VERSION 200
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

static char *readBinaryFile(const char *path, size_t *fileSize) {
  FILE *f = fopen(path, "r");
  if (f == NULL) {
    fprintf(stderr, "file %s could not be opened\n", path);
    exit(1);
  }
  fseek(f, 0, SEEK_END);
  long length = ftell(f);
  fseek(f, 0, SEEK_SET);
  char *buffer = malloc(length);
  if (fread(buffer, 1, length, f) < (size_t)length) {
    return NULL;
  }
  fclose(f);
  if (NULL != fileSize) {
    *fileSize = length;
  }
  return buffer;
}

void printUsage() {
  fprintf(stderr, "./my_host.exe -p <platform id> -d <device id> [-i] [-b]\n");
}

int main(int argc, char *argv[]) {
  int platformId = 0;
  int deviceId = 0;
  bool useIR = false;
  bool useBinary = false;
  char c;
  while ((c = getopt(argc, argv, "p:d:bi?")) != -1) {
    switch (c) {
    case 'p':
      platformId = atoi(optarg);
      break;
    case 'd':
      deviceId = atoi(optarg);
      break;
    case 'i':
      if (useBinary) {
        fprintf(stderr, "Options -i and -b are incompatible (choose one of intermediate representation or binary)\n");
        exit(1);
      }
      useIR = true;
      break;
    case 'b':
      if (useIR) {
        fprintf(stderr, "Options -i and -b are incompatible (choose one of intermediate representation or binary)\n");
        exit(1);
      }
      useBinary = true;
      break;
    case '?':
      printUsage();
    default:
      exit(1);
    }
  }
  printf("Using platform %i device %i, building program from ", platformId, deviceId);
  if (useBinary) {
    printf("binary\n");
  } else if (useIR) {
    printf("intermediate-level representation\n");
  } else {
    printf("source\n");
  }

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

  /* Select the chosen platform */
  cl_uint numPlatforms;           // the NO. of platforms
  cl_platform_id platform = NULL; // the chosen platform
  cl_int status = clGetPlatformIDs(0, NULL, &numPlatforms);
  if (status != CL_SUCCESS) {
    fprintf(stderr, "Error: Getting platforms!\n");
    return -1;
  }

  if (platformId < numPlatforms) {
    cl_platform_id *platforms = (cl_platform_id *)malloc(
        numPlatforms * sizeof(cl_platform_id));
    status = clGetPlatformIDs(numPlatforms, platforms, NULL);
    platform = platforms[platformId];
    free(platforms);
  } else {
    fprintf(stderr, "Invalid platform: %d\n", platformId);
    exit(1);
  }

  /* Query the platform and select the chosen device */
  cl_uint numDevices = 0;
  cl_device_id *devices;
  status = clGetDeviceIDs(platform, CL_DEVICE_TYPE_ALL, 0, NULL, &numDevices);
  checkError(status, "clGetDeviceIDs");
  if (deviceId >= numDevices) {
    fprintf(stderr, "Invalid device: %d\n", deviceId);
    exit(1);
  }

  devices =
      (cl_device_id *)malloc(numDevices * sizeof(cl_device_id));
  status = clGetDeviceIDs(platform, CL_DEVICE_TYPE_ALL,
                          -numDevices, devices, NULL);
  checkError(status, "clGetDeviceIDs");

  size_t deviceNameSize;
  char *deviceName;
  status = clGetDeviceInfo(devices[0], CL_DEVICE_NAME, 0, NULL, &deviceNameSize);
  checkError(status, "clGetDeviceInfo");

  deviceName = (char *)malloc(deviceNameSize);

  status = clGetDeviceInfo(devices[0], CL_DEVICE_NAME, deviceNameSize, deviceName, NULL);
  checkError(status, "clGetDeviceInfo");
  printf("Using OpenCL device: %s\n", deviceName);

  /*Step 3: Create context.*/
  cl_context context =
      clCreateContext(NULL, 1, devices, NULL, NULL, &status);
  checkError(status, "clCreateContext");

  /*Step 4: Creating command queue associate with the
	 * context.*/
  cl_command_queue commandQueue =
      clCreateCommandQueue(context, devices[0], 0, &status);
  checkError(status, "clCreateCommandQueue");

  cl_program program;
  size_t binarySize;
  char *binary;

  if (useBinary) {
    char filename[20];
    sprintf(filename, "my_kernel_%d.bc", platformId);
    binary = readBinaryFile(filename, &binarySize);
    cl_int binary_status[1], errcode_ret[1];
    program = clCreateProgramWithBinary(
        context, 1, devices, &binarySize,
        (const unsigned char **)&binary, binary_status, errcode_ret);
    checkError(binary_status[0], "clCreateProgramWithBinary - binary status");
    checkError(errcode_ret[0], "clCreateProgramWithBinary");
    free(binary);
  } else if (useIR) {
    binary = readBinaryFile("my_kernel.spirv", &binarySize);
    program = clCreateProgramWithIL(
        context, (const void *)binary, binarySize, &status);
    checkError(status, "clCreateProgramWithIL");
    free(binary);
  } else {

    char *sourcepath = "my_kernel.cl";
    FILE *fp = fopen(sourcepath, "r");
    if (!fp) {
      fprintf(stderr, "Failed to open kernel file '%s': %s\n", sourcepath, strerror(errno));
      exit(2);
    }

    char *source_str = malloc(MAX_SOURCE_SIZE * sizeof(char));
    size_t source_size = fread(source_str, 1, MAX_SOURCE_SIZE, fp);

    program = clCreateProgramWithSource(context, 1, (const char **)&source_str, &source_size, &status);
    checkError(status, "clCreateProgramWithSource");
  }
  status = clBuildProgram(program, 1, devices, NULL, NULL, NULL);
  checkError(status, "clBuildProgram");

  status = clGetProgramInfo(program, CL_PROGRAM_BINARY_SIZES, sizeof(size_t), &binarySize, NULL);
  checkError(status, "clGetProgramInfo");
  binary = malloc(binarySize);
  status = clGetProgramInfo(program, CL_PROGRAM_BINARIES, binarySize, &binary, NULL);
  checkError(status, "clGetProgramInfo");
  char filename[20];
  sprintf(filename, "my_kernel_%d.bc", platformId);
  FILE *f = fopen(filename, "w");
  fwrite(binary, binarySize, 1, f);
  fclose(f);

  cl_kernel kernel = clCreateKernel(program, "vadd", &status);
  checkError(status, "clCreateKernel");

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
