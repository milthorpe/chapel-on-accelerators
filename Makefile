# example build commands to generate SPIR-V from an OpenCL kernel
#
CC = clang-9
CXX = clang-9
SPIRV_LLVM = SPIRV-LLVM-Translator/build/tools/llvm-spirv/llvm-spirv
CLANG_KERNEL_FLAGS = -c -x cl -emit-llvm -target spir64-unknown-unknown -cl-std=CL2.0 -Xclang -finclude-default-header
CFLAGS = -Wall -g -lOpenCL -lrt

all: my_kernel.spv my_host.exe

%.exe: %.c
	$(CC) $(CFLAGS) $< -o $@

%.ll: %.cl
	$(CXX) $(CLANG_KERNEL_FLAGS) -S $< -o $@

%.bc: %.cl
	$(CXX) $(CLANG_KERNEL_FLAGS) $< -o $@

%.spv: %.bc
	$(SPIRV_LLVM) $<

.PHONY: clean

clean:
	rm -f *.ll *.bc *.spv *.exe

