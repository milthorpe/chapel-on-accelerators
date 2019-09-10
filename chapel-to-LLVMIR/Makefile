# Convert Chapel code to readable IR
# https://github.com/chapel-lang/chapel/blob/master/CHANGES.md

FILENAME = hello
OUTPUT_FILENAME = hello

SAVE_DIR_NAME = compiled_files

# Funtion name to convert to IR
FUNCTION = main

# Optimisation stage
# https://github.com/chapel-lang/chapel/blob/master/compiler/codegen/symbol.cpp#L81
#
# OPTIONS-
# "", //llvmStageNum::NOPRINT
# "none", //llvmStageNum::NONE
# "basic", //llvmStageNum::BASIC
# "full", //llvmStageNum::FULL
# "every", //llvmStageNum::EVERY
# "early-as-possible",
# "module-optimizer-early",
# "loop-optimizer-end",
# "scalar-optimizer-late",
# "optimizer-last",
# "vectorizer-start",
# "enabled-on-opt-level0",
# "peephole"
STAGE = none

# Which optimisation bitcode file to use
# Options - {nopt, opt1}
BC_OPTIMISATION = nopt

help: 
	@echo "Run 'make bc-to-ir' for compiling entire file to IR  --OR \n    'make func-to-ir' for compiling specific function to IR \n\nYou may want to re-define variables {FILENAME, OUTPUT_FILENAME, SAVE_DIR_NAME, FUNCTION} \n"

# Converts entire *.bc file to IR
bc-to-ir: $(FILENAME).chpl
	mkdir -p $(SAVE_DIR_NAME)
	chpl $(FILENAME).chpl -o $(SAVE_DIR_NAME)/$(FILENAME) --llvm --savec $(SAVE_DIR_NAME)
	llvm-dis-10 $(SAVE_DIR_NAME)/chpl__module-$(BC_OPTIMISATION).bc -o ./$(OUTPUT_FILENAME).ll


func-to-ir: $(FILENAME).chpl
	mkdir -p $(SAVE_DIR_NAME)
	chpl $(FILENAME).chpl -o $(SAVE_DIR_NAME)/$(FILENAME) --llvm --llvm-print-ir=$(FUNCTION) --llvm-print-ir-stage=$(STAGE) > $(OUTPUT_FILENAME).ll

.PHONY: clean

clean:
	@rm -rf $(SAVE_DIR_NAME)
	@rm -f $(OUTPUT_FILENAME).ll
