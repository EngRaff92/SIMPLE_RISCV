# instruction_memory_tb.py
import cocotb
from cocotb.triggers import Timer
from cocotb.triggers import FallingEdge
from cocotb.triggers import RisingEdge

# Local Params
NINTR = 1024

def read_array():
    global array_el 
    array_el = []
    f = open("mem_instr.hex","r")
    el = f.read().splitlines()
    for elemnt in el:
        array_el.append(elemnt)
    f.close()

## Clock Generator
async def generate_clock(dut):
    """Generate clock"""
    for cycle in range(NINTR):
        dut.clk <= 0
        await Timer(1, units="ns")
        dut.clk <= 1
        await Timer(1, units="ns")

## Main Test
@cocotb.test()
async def mem_instr_test(dut):
    """Try accessing the design."""
    dut._log.info("Running test...")

    # run the clock "in the background"
    cocotb.fork(generate_clock(dut)) 

    ## Read the data array
    read_array()

    # Wait and then wait for the clock
    clkedge = RisingEdge(dut.clk)
    for i in range(NINTR):
        ## Assign addres
        dut.i_addr <= i
        await clkedge
        a = dut.i_data_out.value
        a = str(hex(a))
        b = a.strip("0x")
        if b != array_el[i]:
            dut._log.info(f"at address: {i} data {a} is not equal to: {'0x'+array_el[i]}")
    
    # END
    dut._log.info("Running test...done")