# Define pathes
baseDir      = $(abspath .)
targetDir    = $(baseDir)/target
testRunDir   = $(baseDir)/test_run_dir
generatedDir = $(baseDir)/generated

# Configure tools and tool flags
SBT         = sbt
VERILATOR   = verilator

SBT_FLAGS       =
VERILATOR_FLAGS = --cc --exe --assert -Wno-STMTDLY -O3 --trace --threads

sbt :
	$(SBT) $(SBT_FLAGS)

# Build each module of YuCore and generate verilog
pc :
	$(SBT) $(SBT_FLAGS) "test:runMain frontend.PCTestMain"

# Compile all the test files
test-all :
	$(SBT) $(SBT_FLAGS) test

.PHONY : clean
clean:
	-rm -rf $(targetDir) $(testRunDir) $(generatedDir)
