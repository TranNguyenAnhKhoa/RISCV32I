

ifeq ($(MODE), FETCH_STAGE)
FILE_LIST = filelist/fetch_stage
endif

ifeq ($(MODE), DECODE_STAGE)
FILE_LIST = filelist/decode_stage
endif

ifeq ($(MODE), EXE_STAGE)
FILE_LIST = filelist/execute_stage
endif

ifeq ($(MODE), MEM_STAGE)
FILE_LIST = filelist/mem_stage
endif

ifeq ($(MODE), TOP_MODULE)
FILE_LIST = filelist/top_module
endif


#------------------VERILATOR------------------
VERILATOR = verilator

##### LINT FLAGS
LINT_FLAGS += --unroll-stmts 99999999
LINT_FLAGS += --unroll-count 99999999
LINT_FLAGS += -Wall --lint-only -sv
LINT_FLAGS += --Wno-UNUSEDSIGNAL
#______________________________________

##### VERILATOR FLAGS
# Pass HW to Verilator as an overridden parameter
#VERILATOR_FLAGS += -GHISTORY_WIDTH=$(HW)

# Generate C++ in executable form
VERILATOR_FLAGS += -sv -cc

# Optimize
VERILATOR_FLAGS += --x-initial unique
VERILATOR_FLAGS += --x-assign unique
VERILATOR_FLAGS += -O3 -CFLAGS -DCOVERAGE

# Warn abount lint issues; may not want this on less solid designs
VERILATOR_FLAGS += -Wall

# Disable all style warnings
VERILATOR_FLAGS += -Wno-style

# Extend allowed loop body size
VERILATOR_FLAGS += --unroll-stmts 99999
VERILATOR_FLAGS += --unroll-count 99999

# Enable assertion
VERILATOR_FLAGS += --assert

# Make waveforms
VERILATOR_FLAGS += --trace-fst
VERILATOR_FLAGS += --build -j

# Add predictor-specific macro
VERILATOR_FLAGS += -D$(MACRO)

#------------ INPUT FILE ---------------
VERILATOR_INPUT = -f ../00_src/*.sv ../00_src/*.v ../04_testbench/top.sv --top-module top
VERILATOR_INPUT = -f $(FILE_LIST) ../04_testbench/top.sv --top-module top


.PHONY: help
help:
	@echo "make [option]"
	@echo "\tlint run lint checks for syntax and vi"


.PHONY: lint
lint:
	@echo
	@echo "<>-------------------------------------------------------------------------"
	@echo "<>----------------------------------LINT CHECK-----------------------------"
	@echo "<>-------------------------------------------------------------------------"
	@$(VERILATOR) $(LINT_FLAGS) -f $(FILE_LIST)
	@echo "<>----------------------------LINT CHECK COMPLETED-------------------------"

.PHONY: build
build:
	@echo
	@echo "<>-------------------------------------------------------------------------"
	@echo "<>-------------------------------------BUILD-------------------------------"
	@echo "<>-------------------------------------------------------------------------"
	@$(VERILATOR) $(VERILATOR_FLAGS) $(VERILATOR_INPUT) --exe  ../04_testbench/testbench_top.cpp

.PHONY: sim
sim: ./obj_dir/Vtop
	@echo
	@echo "<>---------------- SIMULATING ----------------"
	@./obj_dir/Vtop +verilator+rand+reset+2

.PHONY: wave
wave: wave.fst
	@echo
	@echo "<>---------------- WAVEFORMS ----------------"
	@gtkwave -f wave.fst wave.gtkw

.PHONY: clean
clean:
	@rm -rf obj_dir
	@rm -f *.fst *.csv
	@echo "<>-------------------------------------------------------------------------"
	@echo "<>-------------------------------------CLEAR-------------------------------"
	@echo "<>-------------------------------------------------------------------------"
	
.PHONY: all 
all:
	make lint
	make build
	make sim


.PHONY: FETCH_STAGE
FETCH_STAGE:
	@echo "<>----------------------MODE----------------------"
	@$(MAKE) --no-print-directory MODE=FETCH_STAGE lint build sim
	@echo "<>------------------FETCH_STAGE-------------------"

.PHONY: DECODE_STAGE
DECODE_STAGE:
	@echo "<>----------------------MODE----------------------"
	@$(MAKE) --no-print-directory MODE=DECODE_STAGE lint build sim
	@echo "<>------------------DECODE_STAGE-------------------"

.PHONY: EXE_STAGE
EXE_STAGE:
	@echo "<>----------------------MODE----------------------"
	@$(MAKE) --no-print-directory MODE=EXE_STAGE lint build sim
	@echo "<>------------------EXE_STAGE-------------------"

.PHONY: MEM_STAGE
MEM_STAGE:
	@echo "<>----------------------MODE----------------------"
	@$(MAKE) --no-print-directory MODE=MEM_STAGE lint build sim
	@echo "<>------------------MEM_STAGE-------------------"

.PHONY: TOP_MODULE
TOP_MODULE:
	@echo "<>----------------------MODE----------------------"
	@$(MAKE) --no-print-directory MODE=TOP_MODULE lint build sim
	@echo "<>------------------TOP_MODULE-------------------"



