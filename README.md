# Chapel on Accelerators

This repository demonstrates some parts of the build chain that may be needed to compile kernels in Chapel code to run on diverse accelerators devices using OpenCL/SPIR-V.

## Build Requirements

- clang-10
  To install on Ubuntu 18.04 (Bionic Beaver), run the following commands:
  
    wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | sudo apt-key add -
    sudo apt-add-repository "deb http://apt.llvm.org/xenial/ llvm-toolchain-xenial main"
    sudo apt-get update
    sudo apt-get install -y llvm-10-dev llvm-10-tools clang-10 libclang-10-dev

### Build the SPIRV-LLVM Translator

If you didn't clone this repo using `--recurse-submodules`, you'll need to check out the submodule for the SPIRV-LLVM Translator.

    cd SPIRV-LLVM-Translator
    git submodule init
    git submodule update

Then build as normal:

    mkdir build
    cd build && cmake .. && make llvm-spirv
