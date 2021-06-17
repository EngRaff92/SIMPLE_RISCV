# Register File #

## Install Environment Tools	 ##

- **Icarus Verilog**: our main simulator please make sure to install latest version V11 master since it supports latest SystemVerilog g2012 (always_ff and always_comb) 
- **Open Register Tool**: this tool i mainly used to generate the Register File for RV32I usgin the Regsiter Descriptio Language (SystemRDL from Accellera) this is kinda of a new apporach to generate a fully functional (BUS-Protocol based) register file. The project has a Specific Directory for that
- **CocoTB**: is python based verification framework easy to be installed and fully working on latest python release
- **Yosys**: our main Synthesis tool with standard linbrary open source cells already built in.

## RV32I Specification ISA ##

According to the RV32I ISA specification: "*RV32I was designed to be sufficient to form a compiler target and to support modern operating system environments. The ISA was also designed to reduce the hardware required in a minimal implementation. RV32I contains 40 unique instructions*". So RV32I is gonna be based on 32 UNPRIVILEGED integer register state which are mainly collected into a what is known as Register File. Each Register is 32bit wide (**XLEN = 32**). The only main excpetion is the first register X0 which will be hardwired to 0. The rest are all general purpose register going to be used by all the instructions supported.

## Directory Structure ##

The following is the directory structure, each element will be descrbed below.

├── Makefile
├── README.md
├── Reg_File_SV
│   ├── Makefile
│   ├── regfile.sv
│   ├── regfile_pkg.sv
│   └── regfile_tb.sv
├── Reg_Gen_Out
│   ├── Makefile
│   ├── out.josn
│   ├── registerfile.sv
│   ├── registerfile.xml
│   ├── registerfile_tb.sv
│   └── reglist.txt
├── out.json
└── regfile_rv32i.rdl

There are mainly 2 key diretcories the first one called **Reg_file_SV** will contains the manually coded Register file with Debug capability. The second main Directry is the one used by the Open Design Register Tool (ODT) gathering the auto generated sets of files.

The Open Register Tool will take **regfile_rv32i.rdl** as main input and will take care of everything staring from the RTL up to the descriptio files such as the XML. Please do not run the test over the Autoghenerated version since too complicated and failing at moment due to some X values coming out the READ, hence refer to the manual version.

Everything is mainly driven by the Makefile so all the commands are listed there, if some ENV variable is missing please set it up.

## Design Requirement ##

The main requiremts are the following:

* The registe file should have 2 Read Ports and 1 Write Port qualified by the Write enable bit.
* The read should be resolved at the same cycle they are issued.
* The write should be instead clock based meaning is going to consume exactly 1 clock cycle before fully write it into the register selected this will avoid operation collision.
* According to the specification we have only 32 registers meaning 5 bits are enough to select one or more registers hence 3 ports will be added in order to decode the registers to be used. Everything is parametrized according to the specifications (**XLEN=32 and NREG=32**).



## How to Run ##

Here are the main directives you might use in the main Makefile

* **compile**: this just compile the design using Icarus with some standards flags
* **sim**: This rule runs the sim directly. It calles the compilation before so no need to run compile again
* **debug**: this compiles and executes the simulation with the debug switch set in order to get some useful debug information from the TB
* **wave**: open up the waves using GTKwave
* **clean**: simply removes the VVP generated file

This RTL has been tested using 5 main Scenarios:

* Scenario_0: Incremenatl Write where we write all the registyers and we read them back through the 2 Read ports available. This is the default scenario so if no scenarios is selected the this will run
* Scenario_1: Back To Back access we Read from Port 1 we write and the we read back from port 2 this scenario is called RWR
* Scenario_2: Reset scenario where we issue the reset and then we read all the regsiters back
* Scenario_3: Parallel access where we test out the priority. The Read is fully combo meaning that is not waiting for clocks so resolved in Active Reagion immediately. The write runs with the clock so it takes longer. This will ensure that Write will never win against the read.

To run a single scenario you can use, the selector uses the "valueplusargs":

* make sim -> vvp +s=0,1,2,3
* make debug -> vvp +s=0,1,2,3

## Block Diagram

![Block Diagram](/Users/raffaelemac/Desktop/Schermata 2021-06-17 alle 20.14.25.png)

## List of Registers And Usage

| Register Name | Usage                   | ABI name |
| ------------- | ----------------------- | -------- |
| x0            | Hard Wired Zero         | zero     |
| x1            | Return Address          | ra       |
| X2            | Stack Pointer           | sp       |
| x3            | Global pointer          | gp       |
| x4            | Thread Pointer          | tp       |
| x5            | Temporary link register | t0       |
| x6-x7         | Temporaries             | t1-t2    |
| x8            | Frame Pointer           | fp       |
| x9            | Saved Register          | s1       |
| x10-x11       | Return Values           | a0-a1    |
| x12-x17       | Function Arguments      | a2-a7    |
| x18-x27       | Saved Registers         | s2-s11   |
| x38-x31       | Temporaries             | t3-t6    |
|               |                         |          |



