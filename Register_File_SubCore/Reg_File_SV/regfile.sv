/*
 * this is the Register file for RV32I made in SV and verified using Iverilog
 * Please Refer to the README file for info.
 */

// Import main PKG
// `include "./regfile_pkg.sv"

 module register_file(
    // Input ports
    // clock and reset
    input logic rf_clk,
    input logic rf_ares,
    // decoder addresses
    input logic [ADDR_WIDTH-1:0] rw_dec,
    input logic [ADDR_WIDTH-1:0] ra_dec,
    input logic [ADDR_WIDTH-1:0] rb_dec,
    input logic [REG_DATA_W-1:0] w_data_in,
    // write enable
    input logic wr_en,
    // Output ports
    output logic [REG_DATA_W] qa_out,
    output logic [REG_DATA_W] qb_out
 );
     
    // Sets of registers using the RV32I names usefull for debug
    `ifdef DEBUG
    logic [REG_DATA_W-1:0] zero;
    logic [REG_DATA_W-1:0] ra;
    logic [REG_DATA_W-1:0] sp;
    logic [REG_DATA_W-1:0] gp;
    logic [REG_DATA_W-1:0] tp;
    logic [REG_DATA_W-1:0] t0;
    logic [REG_DATA_W-1:0] t1, t2;
    logic [REG_DATA_W-1:0] s0;
    logic [REG_DATA_W-1:0] s1;
    logic [REG_DATA_W-1:0] a0, a1;
    logic [REG_DATA_W-1:0] a2, a3, a4, a5, a6, a7;
    logic [REG_DATA_W-1:0] s2, s3, s4, s5, s6, s7, s8, s9, s10, s11;
    logic [REG_DATA_W-1:0] t3, t4, t5, t6;    
    `endif 

    // main register file
    logic [REG_DATA_W-1:0] regfile[REG_NUMBER-1:0];

    // Reset Stage Process
    int i;
    always_ff @(posedge rf_clk or posedge rf_ares) begin: reset_stage
        if(rf_ares) begin
            for(i = 0; i <= (REG_NUMBER-1); i++)
                regfile[i] <= '0;
        end
    end

    // Debug assign
    `ifdef DEBUG
    assign zero = regfile['d0];
    assign ra = regfile['d1 ];
    assign sp = regfile['d2 ];
    assign gp = regfile['d3 ];
    assign tp = regfile['d4 ];
    assign t0 = regfile['d5 ];
    assign t1 = regfile['d6 ];
    assign t2 = regfile['d7 ];
    assign s0 = regfile['d8 ];
    assign s1 = regfile['d9 ];
    assign a0 = regfile['d10];
    assign a1 = regfile['d11];
    assign a2 = regfile['d12];
    assign a3 = regfile['d13];
    assign a4 = regfile['d14];
    assign a5 = regfile['d15];
    assign a6 = regfile['d16];
    assign a7 = regfile['d17];
    assign t3 = regfile['d18];
    assign t4 = regfile['d19];
    assign t5 = regfile['d20];
    assign t6 = regfile['d21];
    assign s2 = regfile['d22];
    assign s3 = regfile['d23];
    assign s4 = regfile['d24];
    assign s5 = regfile['d25];
    assign s6 = regfile['d26];
    assign s7 = regfile['d27];
    assign s8 = regfile['d28];
    assign s9 = regfile['d29];
    assign s10= regfile['d30];
    assign s11= regfile['d31];
    `endif 

    // Write Process
    always_ff @(posedge rf_clk or posedge rf_ares) begin: read_stage
        // decoder for write
        if((~rf_ares) & wr_en) begin
            case (rw_dec)
                5'd1:  regfile[5'd1] <= w_data_in;
                5'd2:  regfile[5'd2] <= w_data_in;
                5'd3:  regfile[5'd3] <= w_data_in;
                5'd4:  regfile[5'd4] <= w_data_in;
                5'd5:  regfile[5'd5] <= w_data_in;
                5'd6:  regfile[5'd6] <= w_data_in;
                5'd7:  regfile[5'd7] <= w_data_in;
                5'd8:  regfile[5'd8] <= w_data_in;
                5'd9:  regfile[5'd9] <= w_data_in;
                5'd10:  regfile[5'd10] <= w_data_in;
                5'd11:  regfile[5'd11] <= w_data_in;
                5'd12:  regfile[5'd12] <= w_data_in;
                5'd13:  regfile[5'd13] <= w_data_in;
                5'd14:  regfile[5'd14] <= w_data_in;
                5'd15:  regfile[5'd15] <= w_data_in;
                5'd16:  regfile[5'd16] <= w_data_in;
                5'd17:  regfile[5'd17] <= w_data_in;
                5'd18:  regfile[5'd18] <= w_data_in;
                5'd19:  regfile[5'd19] <= w_data_in;
                5'd20:  regfile[5'd20] <= w_data_in;
                5'd21:  regfile[5'd21] <= w_data_in;
                5'd22:  regfile[5'd22] <= w_data_in;
                5'd23:  regfile[5'd23] <= w_data_in;
                5'd24:  regfile[5'd24] <= w_data_in;
                5'd25:  regfile[5'd25] <= w_data_in;
                5'd26:  regfile[5'd26] <= w_data_in;
                5'd27:  regfile[5'd27] <= w_data_in;
                5'd28:  regfile[5'd28] <= w_data_in;
                5'd29:  regfile[5'd29] <= w_data_in;
                5'd30:  regfile[5'd30] <= w_data_in;
                5'd31:  regfile[5'd31] <= w_data_in;
                default: regfile[5'd0] <= '0;
            endcase
        end
    end

    // Read State should be resolved in the same cycle not under reset
    assign qa_out = regfile[ra_dec];
    assign qb_out = regfile[rb_dec];
 endmodule

