/* Testbench top with nested program to keep Module separated */


// Top module
module tb_top(
    input logic clk,
    input logic [ADDR_W-1:0] i_addr,
    output logic [INSTR_LEN-1:0] i_data_out
);

// Load memory file
initial begin: loadmem
    $display("Loading memory");
    $readmemh("./mem_instr.hex",uut.instr_mem_array);
end

// Internal signals
logic [ADDR_W-1:0] addr;
logic [INSTR_LEN-1:0] data_out;

// Assign
assign addr = i_addr;
assign i_data_out = data_out;

// DUT instance
instr_mem uut(
                .i_addr(addr),
                .i_data_out(data_out)
            );

initial begin: dump
    $dumpfile("dump.vcd");
    $dumpvars();
end
endmodule