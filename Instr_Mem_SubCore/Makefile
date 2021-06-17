#include ../Makefile

## Run Python Gen Comand
PY := python3.9

# Makefile

# defaults
SIM 			?= icarus
TOPLEVEL_LANG 	?= verilog

# Verilog source file
VERILOG_SOURCES += $(PWD)/$(wildcard *.sv)

# TOPLEVEL is the name of the toplevel module in your Verilog or VHDL file
TOPLEVEL = tb_top

# MODULE is the basename of the Python test file
MODULE = instruction_memory_tb

# include cocotb's make rules to take care of the simulator setup
include $(shell cocotb-config --makefiles)/Makefile.sim

## Rules for HEX generation
genhex: 
		@$(PY) Gen_hex.py 32 1024

