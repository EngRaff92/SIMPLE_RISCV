###############################################################################
#
# REGISTER FILE GENERATOR
# 
# USE THE FOLLOWING COMMANDS WITH THIS MAKEFILE
#       "make compile"          - compiles your rdl file
#       "make gen"              - compiles and generate the register file
#       "make gen_opts"         - compiles and generate additional components
#       "make clean"            - clean out the main directory
###############################################################################

#TOOL INPUT
SRC_RDL         ?= $(wildcard *.rdl)
OUT_JSON        ?= $(OUT_DIR)/out.josn
OUT_DIR         ?= Reg_Gen_Out
SV_FILE         ?= $(OUT_DIR)/registerfile.sv
LIST_FILE       ?= $(OUT_DIR)/reglist.txt
BENCH_FILE      ?= $(OUT_DIR)/registerfile_tb.sv
XML_FILE        ?= $(OUT_DIR)/registerfile.xml

###############################################################################
# COMPILER AND GENERATOR SWITCHES
###############################################################################
#TOOLS
COMPILER        = python3.9 /opt/homebrew/bin/compiler_rdl.py
GENERATOR       = java -jar ~/Ordt.jar

#TOOL OPTIONS
SV_GEN          = -systemverilog
LIST_TXT        = -reglist
VBENCH          = -vbench
XML_OUT         = -xml

###############################################################################
#MAKE DIRECTIVES
reg_compile: 
	@mkdir -p $(OUT_DIR)
	@touch $(OUT_JSON)
	@$(COMPILER) $(SRC_RDL) $(OUT_JSON)
	@touch $(OUT_DIR)/Makefile
	@echo "include ../../Makefile" > $(OUT_DIR)/Makefile

clean:
	@rm -rf $(OUT_DIR)

gen:
	@$(MAKE) reg_compile
	@touch $(SV_FILE) $(LIST_FILE)
	@$(GENERATOR) $(SV_GEN) $(SV_FILE) $(LIST_TXT) $(LIST_FILE) $(SRC_RDL)

gen_opts:
	@$(MAKE) reg_compile
	@touch $(SV_FILE) $(LIST_FILE) $(BENCH_FILE) $(XML_FILE)
	@$(GENERATOR) $(SV_GEN) $(SV_FILE) $(LIST_TXT) $(LIST_FILE) $(VBENCH) $(BENCH_FILE) $(XML_OUT) $(XML_FILE) $(SRC_RDL)

## Include the previous Makefile
include ../Makefile
