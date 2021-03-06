module instr_mem (
    input logic [ADDR_W-1:0] i_addr,
    output logic [INSTR_LEN-1:0] i_data_out
);
    
    // Declare the main Array
    logic [INSTR_LEN-1:0] instr_mem_array [N_WORD-1:0];

    // Drive Output assumig the Program Counter is already Cutshorted
    assign i_data_out = instr_mem_array[i_addr];
endmodule