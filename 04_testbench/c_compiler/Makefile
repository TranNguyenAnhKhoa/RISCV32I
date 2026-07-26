# Bare-metal RV32I compiler flow for the RISCV32I simulation environment.
#
# Default usage on this Windows machine:
#   mingw32-make asm
#
# Configure TOOLCHAIN_BIN/CROSS_COMPILE in toolchain.mk when the compiler is
# not available through PATH. See toolchain.mk.example and README.md.

.DEFAULT_GOAL := all
.DELETE_ON_ERROR:

-include toolchain.mk

C_SOURCE ?= example.c
PROGRAM ?= $(basename $(notdir $(C_SOURCE)))
BUILD_DIR ?= build

ARCH ?= rv32i
ABI ?= ilp32
OPTIMIZATION ?= -O2

SOURCE_TOOLCHAIN_BIN := tools/riscv-gnu-toolchain/install/bin

ifeq ($(OS),Windows_NT)
SOURCE_TOOLCHAIN_GCC := $(wildcard $(SOURCE_TOOLCHAIN_BIN)/riscv64-unknown-elf-gcc.exe)
else
SOURCE_TOOLCHAIN_GCC := $(wildcard $(SOURCE_TOOLCHAIN_BIN)/riscv64-unknown-elf-gcc)
endif

BUILT_SOURCE_TOOLCHAIN_BIN := $(if $(SOURCE_TOOLCHAIN_GCC),$(SOURCE_TOOLCHAIN_BIN))
LOCAL_TOOLCHAIN_BIN := $(firstword $(BUILT_SOURCE_TOOLCHAIN_BIN) $(wildcard toolchain/bin))
TOOLCHAIN_BIN ?= $(LOCAL_TOOLCHAIN_BIN)
CROSS_COMPILE ?= riscv64-unknown-elf-

TOOLCHAIN_BIN_CLEAN := $(patsubst %/,%,$(strip $(TOOLCHAIN_BIN)))

ifneq ($(TOOLCHAIN_BIN_CLEAN),)
TOOL_PREFIX := $(TOOLCHAIN_BIN_CLEAN)/$(CROSS_COMPILE)
else
TOOL_PREFIX := $(CROSS_COMPILE)
endif

CC := $(TOOL_PREFIX)gcc
OBJCOPY := $(TOOL_PREFIX)objcopy
OBJDUMP := $(TOOL_PREFIX)objdump
SIZE := $(TOOL_PREFIX)size

POWERSHELL ?= powershell.exe

STARTUP_SOURCE := startup.S
LINKER_SCRIPT := linker.ld
IMEM_CONVERTER := tools/bin_to_imem.ps1
TOOLCHAIN_CHECKER := tools/check_toolchain.ps1
IMEM_DESTINATION ?= ../../01_data_mem/IMEM.mem

ASM_OUTPUT := $(BUILD_DIR)/$(PROGRAM).s
OBJECT_OUTPUT := $(BUILD_DIR)/$(PROGRAM).o
STARTUP_OBJECT := $(BUILD_DIR)/startup.o
ELF_OUTPUT := $(BUILD_DIR)/$(PROGRAM).elf
MAP_OUTPUT := $(BUILD_DIR)/$(PROGRAM).map
DISASSEMBLY_OUTPUT := $(BUILD_DIR)/$(PROGRAM).dump
BINARY_OUTPUT := $(BUILD_DIR)/$(PROGRAM).bin
IMEM_OUTPUT := $(BUILD_DIR)/$(PROGRAM)_IMEM.mem

TEST_SOURCE_DIRECTORY := test
TEST_OUTPUT_DIRECTORY := $(BUILD_DIR)/test
TEST_NAMES := $(sort $(basename $(notdir $(wildcard $(TEST_SOURCE_DIRECTORY)/*.S))))
TEST_NAME ?= 01_arithmetic_series
SELECTED_TEST_IMEM := $(TEST_OUTPUT_DIRECTORY)/$(TEST_NAME)/IMEM.mem
SELECTED_TEST_DUMP := $(TEST_OUTPUT_DIRECTORY)/$(TEST_NAME)/program.dump
TEST_IMEM_OUTPUTS := $(foreach TEST_CASE,$(TEST_NAMES),$(TEST_OUTPUT_DIRECTORY)/$(TEST_CASE)/IMEM.mem)
TEST_DUMP_OUTPUTS := $(foreach TEST_CASE,$(TEST_NAMES),$(TEST_OUTPUT_DIRECTORY)/$(TEST_CASE)/program.dump)

ARCH_FLAGS := -march=$(ARCH) -mabi=$(ABI)

CPPFLAGS ?=
CFLAGS ?=
ASFLAGS ?=
LDFLAGS ?=

# Keep architecture and bare-metal safety flags separate from user flags.
# Command-line CFLAGS/ASFLAGS/LDFLAGS therefore cannot accidentally turn this
# into an RV64, PIC or hosted build.
REQUIRED_CFLAGS := -ffreestanding
REQUIRED_CFLAGS += -fno-builtin
REQUIRED_CFLAGS += -fno-pic
REQUIRED_CFLAGS += -fno-pie
REQUIRED_CFLAGS += -fno-asynchronous-unwind-tables
REQUIRED_CFLAGS += -fno-unwind-tables
REQUIRED_CFLAGS += -fdata-sections
REQUIRED_CFLAGS += -ffunction-sections
REQUIRED_CFLAGS += -fno-common
REQUIRED_CFLAGS += -msmall-data-limit=0
REQUIRED_CFLAGS += -mstrict-align
REQUIRED_CFLAGS += $(ARCH_FLAGS)

REQUIRED_ASFLAGS := $(ARCH_FLAGS)

REQUIRED_LDFLAGS := -nostdlib
REQUIRED_LDFLAGS += -nostartfiles
REQUIRED_LDFLAGS += -static
REQUIRED_LDFLAGS += -Wl,--build-id=none
REQUIRED_LDFLAGS += -Wl,--gc-sections
REQUIRED_LDFLAGS += -Wl,--no-relax
REQUIRED_LDFLAGS += -Wl,-T,$(LINKER_SCRIPT)
REQUIRED_LDFLAGS += $(ARCH_FLAGS)

LIBS ?= -lgcc

.PHONY: all asm object elf disasm binary imem program size FORCE
.PHONY: deploy-imem doctor print-config help clean
.PHONY: test test-all test-list test-deploy
.PRECIOUS: $(TEST_OUTPUT_DIRECTORY)/%/program.o
.PRECIOUS: $(TEST_OUTPUT_DIRECTORY)/%/program.elf
.PRECIOUS: $(TEST_OUTPUT_DIRECTORY)/%/program.bin

all: asm

asm: $(ASM_OUTPUT)

object: $(OBJECT_OUTPUT)

elf: $(ELF_OUTPUT)

disasm: $(DISASSEMBLY_OUTPUT)

binary: $(BINARY_OUTPUT)

imem: $(IMEM_OUTPUT)

program: asm elf disasm imem size

test: $(SELECTED_TEST_IMEM) $(SELECTED_TEST_DUMP)

test-all: $(TEST_IMEM_OUTPUTS) $(TEST_DUMP_OUTPUTS)

test-list:
	@echo Available RV32I assembly tests:
	@echo $(TEST_NAMES)

test-deploy: $(SELECTED_TEST_IMEM)
	@$(POWERSHELL) -NoProfile -ExecutionPolicy Bypass -Command "Copy-Item -LiteralPath '$(SELECTED_TEST_IMEM)' -Destination '$(IMEM_DESTINATION)' -Force"
	@echo Installed $(SELECTED_TEST_IMEM) to $(IMEM_DESTINATION)

# Programs are small and configuration variables are command-line driven.
# Rebuild compiler outputs on every invocation so changing ARCH/ABI/flags never
# reuses an object created with a different configuration.
FORCE:

$(BUILD_DIR):
	@$(POWERSHELL) -NoProfile -ExecutionPolicy Bypass -Command "New-Item -ItemType Directory -Force -Path '$(BUILD_DIR)' | Out-Null"

$(ASM_OUTPUT): $(C_SOURCE) FORCE | $(BUILD_DIR)
	@echo [CC-S] $<
	@"$(CC)" $(CPPFLAGS) $(CFLAGS) $(OPTIMIZATION) $(REQUIRED_CFLAGS) -fverbose-asm -S "$<" -o "$@"

$(OBJECT_OUTPUT): $(C_SOURCE) FORCE | $(BUILD_DIR)
	@echo [CC] $<
	@"$(CC)" $(CPPFLAGS) $(CFLAGS) $(OPTIMIZATION) $(REQUIRED_CFLAGS) -c "$<" -o "$@"

$(STARTUP_OBJECT): $(STARTUP_SOURCE) FORCE | $(BUILD_DIR)
	@echo [AS] $<
	@"$(CC)" $(ASFLAGS) $(REQUIRED_ASFLAGS) -c "$<" -o "$@"

$(ELF_OUTPUT): $(STARTUP_OBJECT) $(OBJECT_OUTPUT) $(LINKER_SCRIPT) | $(BUILD_DIR)
	@echo [LD] $@
	@"$(CC)" $(LDFLAGS) $(REQUIRED_LDFLAGS) -Wl,-Map,$(MAP_OUTPUT) $(STARTUP_OBJECT) $(OBJECT_OUTPUT) -Wl,--start-group $(LIBS) -Wl,--end-group -o "$@"

$(DISASSEMBLY_OUTPUT): $(ELF_OUTPUT)
	@echo [OBJDUMP] $@
	@"$(OBJDUMP)" -d -M no-aliases,numeric "$<" > "$@"

$(BINARY_OUTPUT): $(ELF_OUTPUT)
	@echo [OBJCOPY] $@
	@"$(OBJCOPY)" -O binary --only-section=.text "$<" "$@"

$(IMEM_OUTPUT): $(BINARY_OUTPUT) $(IMEM_CONVERTER)
	@echo [IMEM] $@
	@$(POWERSHELL) -NoProfile -ExecutionPolicy Bypass -File "$(IMEM_CONVERTER)" -InputFile "$(BINARY_OUTPUT)" -OutputFile "$@" -MaximumBytes 1024

$(TEST_OUTPUT_DIRECTORY)/%/program.o: $(TEST_SOURCE_DIRECTORY)/%.S FORCE
	@$(POWERSHELL) -NoProfile -ExecutionPolicy Bypass -Command "New-Item -ItemType Directory -Force -Path '$(@D)' | Out-Null"
	@echo [AS-TEST] $<
	@"$(CC)" $(ASFLAGS) $(REQUIRED_ASFLAGS) -x assembler -c "$<" -o "$@"

$(TEST_OUTPUT_DIRECTORY)/%/program.elf: $(TEST_OUTPUT_DIRECTORY)/%/program.o $(LINKER_SCRIPT)
	@echo [LD-TEST] $@
	@"$(CC)" $(LDFLAGS) $(REQUIRED_LDFLAGS) -Wl,-Map,$(@D)/program.map "$<" -o "$@"

$(TEST_OUTPUT_DIRECTORY)/%/program.dump: $(TEST_OUTPUT_DIRECTORY)/%/program.elf
	@echo [OBJDUMP-TEST] $@
	@"$(OBJDUMP)" -d -M no-aliases,numeric "$<" > "$@"

$(TEST_OUTPUT_DIRECTORY)/%/program.bin: $(TEST_OUTPUT_DIRECTORY)/%/program.elf
	@echo [OBJCOPY-TEST] $@
	@"$(OBJCOPY)" -O binary --only-section=.text "$<" "$@"

$(TEST_OUTPUT_DIRECTORY)/%/IMEM.mem: $(TEST_OUTPUT_DIRECTORY)/%/program.bin $(IMEM_CONVERTER)
	@echo [IMEM-TEST] $@
	@$(POWERSHELL) -NoProfile -ExecutionPolicy Bypass -File "$(IMEM_CONVERTER)" -InputFile "$<" -OutputFile "$@" -MaximumBytes 1024

size: $(ELF_OUTPUT)
	@"$(SIZE)" -A "$(ELF_OUTPUT)"

deploy-imem: $(IMEM_OUTPUT)
	@$(POWERSHELL) -NoProfile -ExecutionPolicy Bypass -Command "Copy-Item -LiteralPath '$(IMEM_OUTPUT)' -Destination '$(IMEM_DESTINATION)' -Force"
	@echo Installed $(IMEM_OUTPUT) to $(IMEM_DESTINATION)

doctor: print-config $(TOOLCHAIN_CHECKER)
	@echo.
	@echo Checking RISC-V GNU toolchain commands...
	@$(POWERSHELL) -NoProfile -ExecutionPolicy Bypass -File "$(TOOLCHAIN_CHECKER)" -Compiler "$(CC)" -Objcopy "$(OBJCOPY)" -Objdump "$(OBJDUMP)" -SizeTool "$(SIZE)"

print-config:
	@echo PROGRAM=$(PROGRAM)
	@echo C_SOURCE=$(C_SOURCE)
	@echo ARCH=$(ARCH)
	@echo ABI=$(ABI)
	@echo CC=$(CC)
	@echo TOOLCHAIN_SOURCE=tools/riscv-gnu-toolchain
	@echo BUILD_DIR=$(BUILD_DIR)
	@echo TEST_NAME=$(TEST_NAME)
	@echo IMEM_DESTINATION=$(IMEM_DESTINATION)

help:
	@echo RISCV32I C compiler flow
	@echo.
	@echo   mingw32-make asm       Compile C to compiler-generated assembly
	@echo   mingw32-make program   Build ASM, ELF, disassembly and IMEM.mem
	@echo   mingw32-make disasm    Create linked machine-code disassembly
	@echo   mingw32-make imem      Create IMEM byte file for this core
	@echo   mingw32-make deploy-imem  Overwrite ../../01_data_mem/IMEM.mem
	@echo   mingw32-make test TEST_NAME=01_arithmetic_series
	@echo   mingw32-make test-all  Build all standalone assembly tests
	@echo   mingw32-make test-list List assembly test names
	@echo   mingw32-make test-deploy TEST_NAME=01_arithmetic_series
	@echo   mingw32-make doctor    Print config and check toolchain commands
	@echo   mingw32-make clean     Remove generated build output
	@echo.
	@echo Override example:
	@echo   mingw32-make asm C_SOURCE=my_test.c ARCH=rv32i ABI=ilp32
	@echo   mingw32-make asm CROSS_COMPILE=riscv-none-elf-

clean:
	@$(POWERSHELL) -NoProfile -ExecutionPolicy Bypass -Command "if (Test-Path -LiteralPath '$(BUILD_DIR)') { Remove-Item -LiteralPath '$(BUILD_DIR)' -Recurse -Force }"
