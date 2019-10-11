# example build commands to generate SPIR-V from an OpenCL kernel
#
UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Darwin)
  # Use Apple's OpenCL runtime
  CCLIBS += -framework OpenCL
  # or use the installed POCL runtime
  # CCLIBS += -L/usr/local/lib -lOpenCL #
else
  CCLIBS += -lOpenCL -lm -ldl
  CFLAGS += -std=gnu99
endif
CC = clang-10
CXX = clang-10
SPIRV_LLVM = SPIRV-LLVM-Translator/build/tools/llvm-spirv/llvm-spirv
CLANG_KERNEL_FLAGS = -c -x cl -emit-llvm -target spir64-unknown-unknown -cl-std=CL2.0 -Xclang -finclude-default-header
CFLAGS = -Wall -g -lOpenCL -lrt

all: opencl_device_query.exe my_kernel.spirv my_kernel.bc my_host.exe

opencl_device_query.exe: opencl_device_query.c
	$(CC) opencl_device_query.c $(CFLAGS) -o $@ $(CCLIBS)

%.exe: %.c
	$(CC) $(CFLAGS) $< -o $@

%.ll: %.cl
	$(CXX) $(CLANG_KERNEL_FLAGS) -S $< -o $@

%.bc: %.cl
	$(CXX) $(CLANG_KERNEL_FLAGS) $< -o $@

%.spirv: %.bc
	$(SPIRV_LLVM) $< -o $@

.PHONY: clean

clean:
	rm -f *.ll *.bc *.spirv *.exe

