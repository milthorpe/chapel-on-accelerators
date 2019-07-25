# example build commands to generate SPIR-V from an OpenCL kernel
#
CXX = clang-9
SPIRV_LLVM = SPIRV-LLVM-Translator/build/tools/llvm-spirv/llvm-spirv
CXXFLAGS = -c -x cl -emit-llvm -target spir64-unknown-unknown -cl-std=CL2.0 -Xclang -finclude-default-header

%.ll: %.cl
	$(CXX) $(CXXFLAGS) -S $< -o $@

%.bc: %.cl
	$(CXX) $(CXXFLAGS) $< -o $@

%.spv: %.bc
	$(SPIRV_LLVM) $<

.PHONY: clean

clean:
	rm -f *.ll *.bc *.spv

