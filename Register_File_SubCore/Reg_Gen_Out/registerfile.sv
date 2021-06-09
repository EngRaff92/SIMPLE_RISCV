//   Ordt 190617.01 autogenerated file 
//   Input: regfile_rv32i.rdl
//   Date: Wed May 26 19:44:59 IST 2021
//

//
//---------- module RV32I_regfile_jrdl_logic
//
module RV32I_regfile_jrdl_logic
(
  clk,
  reset,
  d2l_X0_w,
  d2l_X0_we,
  d2l_X0_re,
  d2l_XRA_w,
  d2l_XRA_we,
  d2l_XRA_re,
  d2l_XSP_w,
  d2l_XSP_we,
  d2l_XSP_re,
  h2l_XSP_xsp_w,

  l2d_X0_r,
  l2d_XRA_r,
  l2d_XSP_r,
  l2h_X0_x0_zero_r,
  l2h_XRA_xra_r,
  l2h_XSP_xsp_r );

  //------- inputs
  input    clk;
  input    reset;
  input     [31:0] d2l_X0_w;
  input    d2l_X0_we;
  input    d2l_X0_re;
  input     [31:0] d2l_XRA_w;
  input    d2l_XRA_we;
  input    d2l_XRA_re;
  input     [31:0] d2l_XSP_w;
  input    d2l_XSP_we;
  input    d2l_XSP_re;
  input     [31:0] h2l_XSP_xsp_w;

  //------- outputs
  output     [31:0] l2d_X0_r;
  output     [31:0] l2d_XRA_r;
  output     [31:0] l2d_XSP_r;
  output     [31:0] l2h_X0_x0_zero_r;
  output     [31:0] l2h_XRA_xra_r;
  output     [31:0] l2h_XSP_xsp_r;


  //------- wire defines
  logic   [31:0] rg_X0_x0_zero;
  
  //------- reg defines
  logic   [31:0] l2h_X0_x0_zero_r;
  logic   [31:0] l2d_X0_r;
  logic   [31:0] rg_XRA_xra;
  logic   [31:0] reg_XRA_xra_next;
  logic   [31:0] l2h_XRA_xra_r;
  logic   [31:0] l2d_XRA_r;
  logic   [31:0] rg_XSP_xsp;
  logic   [31:0] reg_XSP_xsp_next;
  logic   [31:0] l2h_XSP_xsp_r;
  logic   [31:0] l2d_XSP_r;
  
  
  //------- assigns
  assign  rg_X0_x0_zero = 32'd0;
  
  //------- combinatorial assigns for XSP
  always_comb begin
    reg_XSP_xsp_next = h2l_XSP_xsp_w;
    l2h_XSP_xsp_r = rg_XSP_xsp;
    if (d2l_XSP_we) reg_XSP_xsp_next = d2l_XSP_w;
  end
  
  //------- reg assigns for XSP
  always_ff @ (posedge clk) begin
    if (reset) begin
      rg_XSP_xsp <= #1 32'd0;
    end
    else begin
      rg_XSP_xsp <= #1  reg_XSP_xsp_next;
    end
  end
  
  //------- combinatorial assigns for XSP (pio read data)
  always_comb begin
    l2d_XSP_r = rg_XSP_xsp;
  end
  
  //------- combinatorial assigns for XRA
  always_comb begin
    reg_XRA_xra_next = rg_XRA_xra;
    l2h_XRA_xra_r = rg_XRA_xra;
    if (d2l_XRA_we) reg_XRA_xra_next = d2l_XRA_w;
  end
  
  //------- reg assigns for XRA
  always_ff @ (posedge clk) begin
    if (reset) begin
      rg_XRA_xra <= #1 32'd0;
    end
    else begin
      rg_XRA_xra <= #1  reg_XRA_xra_next;
    end
  end
  
  //------- combinatorial assigns for X0
  always_comb begin
    l2h_X0_x0_zero_r = rg_X0_x0_zero;
  end
  
  //------- combinatorial assigns for X0 (pio read data)
  always_comb begin
    l2d_X0_r = rg_X0_x0_zero;
  end
  
  //------- combinatorial assigns for XRA (pio read data)
  always_comb begin
    l2d_XRA_r = rg_XRA_xra;
  end
  
endmodule

//
//---------- module RV32I_regfile_jrdl_decode
//
module RV32I_regfile_jrdl_decode
(
  clk,
  reset,
  leaf_dec_wr_data,
  leaf_dec_addr,
  leaf_dec_block_sel,
  leaf_dec_valid,
  leaf_dec_wr_dvld,
  leaf_dec_cycle,
  leaf_dec_wr_width,
  l2d_X0_r,
  l2d_XRA_r,
  l2d_XSP_r,

  dec_leaf_rd_data,
  dec_leaf_ack,
  dec_leaf_nack,
  dec_leaf_accept,
  dec_leaf_reject,
  dec_leaf_retry_atomic,
  dec_leaf_data_width,
  d2l_X0_w,
  d2l_X0_we,
  d2l_X0_re,
  d2l_XRA_w,
  d2l_XRA_we,
  d2l_XRA_re,
  d2l_XSP_w,
  d2l_XSP_we,
  d2l_XSP_re );

  //------- inputs
  input    clk;
  input    reset;
  input     [31:0] leaf_dec_wr_data;
  input     [39:0] leaf_dec_addr;
  input    leaf_dec_block_sel;
  input    leaf_dec_valid;
  input    leaf_dec_wr_dvld;
  input     [1:0] leaf_dec_cycle;
  input     [2:0] leaf_dec_wr_width;
  input     [31:0] l2d_X0_r;
  input     [31:0] l2d_XRA_r;
  input     [31:0] l2d_XSP_r;

  //------- outputs
  output     [31:0] dec_leaf_rd_data;
  output    dec_leaf_ack;
  output    dec_leaf_nack;
  output    dec_leaf_accept;
  output    dec_leaf_reject;
  output    dec_leaf_retry_atomic;
  output     [2:0] dec_leaf_data_width;
  output     [31:0] d2l_X0_w;
  output    d2l_X0_we;
  output    d2l_X0_re;
  output     [31:0] d2l_XRA_w;
  output    d2l_XRA_we;
  output    d2l_XRA_re;
  output     [31:0] d2l_XSP_w;
  output    d2l_XSP_we;
  output    d2l_XSP_re;


  //------- wire defines
  logic   [31:0] pio_dec_write_data;
  logic   [3:2] pio_dec_address;
  logic  pio_dec_read;
  logic  pio_dec_write;
  logic   [39:0] block_sel_addr;
  logic  block_sel;
  logic  leaf_dec_valid_active;
  logic  leaf_dec_wr_dvld_active;
  
  //------- reg defines
  logic   [31:0] d2l_X0_w;
  logic  d2l_X0_we;
  logic  d2l_X0_re;
  logic   [31:0] d2l_XRA_w;
  logic  d2l_XRA_we;
  logic  d2l_XRA_re;
  logic   [31:0] d2l_XSP_w;
  logic  d2l_XSP_we;
  logic  d2l_XSP_re;
  logic  leaf_dec_valid_hld1;
  logic  leaf_dec_valid_hld1_next;
  logic  leaf_dec_wr_dvld_hld1;
  logic  leaf_dec_wr_dvld_hld1_next;
  logic  pio_write_active;
  logic  pio_read_active;
  logic   [3:2] pio_dec_address_d1;
  logic   [31:0] pio_dec_write_data_d1;
  logic   [31:0] dec_pio_read_data;
  logic   [31:0] dec_pio_read_data_d1;
  logic  dec_pio_ack;
  logic  dec_pio_nack;
  logic  dec_pio_ack_next;
  logic  dec_pio_nack_next;
  logic  pio_internal_ack;
  logic  pio_internal_nack;
  logic  pio_external_ack;
  logic  pio_external_nack;
  logic  pio_external_ack_next;
  logic  pio_external_nack_next;
  logic  pio_no_acks;
  logic  pio_activate_write;
  logic  pio_activate_read;
  logic   [31:0] dec_pio_read_data_next;
  logic  external_transaction_active;
  
  
  //------- assigns
  assign  pio_dec_write_data = leaf_dec_wr_data;
  assign  dec_leaf_rd_data = dec_pio_read_data;
  assign  dec_leaf_ack = dec_pio_ack;
  assign  dec_leaf_nack = dec_pio_nack;
  assign  pio_dec_address = leaf_dec_addr [3:2] ;
  assign  block_sel_addr = 40'h0;
  assign  block_sel = leaf_dec_block_sel;
  assign  leaf_dec_wr_dvld_active = leaf_dec_wr_dvld | leaf_dec_wr_dvld_hld1;
  assign  leaf_dec_valid_active = leaf_dec_valid | leaf_dec_valid_hld1;
  assign  dec_leaf_accept = leaf_dec_valid & block_sel;
  assign  dec_leaf_reject = leaf_dec_valid & ~block_sel;
  assign  pio_dec_read = block_sel & leaf_dec_valid_active & (leaf_dec_cycle == 2'b10);
  assign  pio_dec_write = block_sel & leaf_dec_wr_dvld_active & (leaf_dec_cycle[1] == 1'b0);
  assign  dec_leaf_retry_atomic = 1'b0;
  assign  dec_leaf_data_width = 3'b0;
  
  //------- combinatorial assigns for pio read data
  always_comb begin
    dec_pio_read_data = dec_pio_read_data_d1;
  end
  
  //------- reg assigns for pio read data
  always_ff @ (posedge clk) begin
    if (reset) begin
      dec_pio_read_data_d1 <= #1  32'b0;
    end
    else begin
      dec_pio_read_data_d1 <= #1 dec_pio_read_data_next;
    end
  end
  
  //------- reg assigns for pio i/f
  always_ff @ (posedge clk) begin
    if (reset) begin
      pio_write_active <= #1  1'b0;
      pio_read_active <= #1  1'b0;
    end
    else begin
      pio_write_active <= #1  pio_write_active ? pio_no_acks : pio_activate_write;
      pio_read_active <= #1  pio_read_active ? pio_no_acks : pio_activate_read;
    end
    pio_dec_address_d1 <= #1   pio_dec_address;
    pio_dec_write_data_d1 <= #1  pio_dec_write_data;
  end
  
  //------- combinatorial assigns for leaf i/f
  always_comb begin
    leaf_dec_valid_hld1_next = leaf_dec_valid | leaf_dec_valid_hld1;
    if (dec_pio_ack_next | dec_pio_nack_next) leaf_dec_valid_hld1_next = 1'b0;
    leaf_dec_wr_dvld_hld1_next = leaf_dec_wr_dvld | leaf_dec_wr_dvld_hld1;
    if (dec_pio_ack_next | dec_pio_nack_next | leaf_dec_valid) leaf_dec_wr_dvld_hld1_next = 1'b0;
  end
  
  //------- reg assigns for leaf i/f
  always_ff @ (posedge clk) begin
    if (reset) begin
      leaf_dec_valid_hld1 <= #1  1'b0;
      leaf_dec_wr_dvld_hld1 <= #1  1'b0;
    end
    else begin
      leaf_dec_valid_hld1 <= #1 leaf_dec_valid_hld1_next;
      leaf_dec_wr_dvld_hld1 <= #1 leaf_dec_wr_dvld_hld1_next;
    end
  end
  
  //------- combinatorial assigns for pio ack/nack
  always_comb begin
    pio_internal_nack = (pio_read_active | pio_write_active) & ~pio_internal_ack & ~external_transaction_active;
    dec_pio_ack_next = (pio_internal_ack | (pio_external_ack_next & external_transaction_active));
    dec_pio_nack_next = (pio_internal_nack | (pio_external_nack_next & external_transaction_active));
    pio_no_acks = ~(dec_pio_ack | dec_pio_nack | pio_external_ack | pio_external_nack);
    pio_activate_write = (pio_dec_write & ~(dec_pio_ack | dec_pio_nack));
    pio_activate_read = (pio_dec_read & ~(dec_pio_ack | dec_pio_nack));
  end
  
  //------- reg assigns for pio ack/nack
  always_ff @ (posedge clk) begin
    if (reset) begin
      dec_pio_ack <= #1 1'b0;
      dec_pio_nack <= #1 1'b0;
      pio_external_ack <= #1  1'b0;
      pio_external_nack <= #1  1'b0;
    end
    else begin
      dec_pio_ack <= #1 dec_pio_ack ? 1'b0 : dec_pio_ack_next;
      dec_pio_nack <= #1 dec_pio_nack ? 1'b0 : dec_pio_nack_next;
      pio_external_ack <= #1 pio_external_ack_next;
      pio_external_nack <= #1 pio_external_nack_next;
    end
  end
  
  
  //------- address decode
  always_comb begin
    pio_internal_ack = 1'b0;
    external_transaction_active = 1'b0;
    pio_external_ack_next = 1'b0;
    pio_external_nack_next = 1'b0;
    dec_pio_read_data_next = 32'b0;
    
    d2l_X0_w = pio_dec_write_data_d1  [31:0] ;
    d2l_X0_we = 1'b0;
    d2l_X0_re = 1'b0;
    d2l_XRA_w = pio_dec_write_data_d1  [31:0] ;
    d2l_XRA_we = 1'b0;
    d2l_XRA_re = 1'b0;
    d2l_XSP_w = pio_dec_write_data_d1  [31:0] ;
    d2l_XSP_we = 1'b0;
    d2l_XSP_re = 1'b0;
    
    casez(pio_dec_address_d1)
    //  Register: X0     Address: 0x0     External: false
    2'b00:
      begin
        d2l_X0_we = pio_write_active & ~dec_pio_ack;
        d2l_X0_re = pio_read_active & ~dec_pio_ack;
        pio_internal_ack =  pio_read_active;
        dec_pio_read_data_next  [31:0]  = l2d_X0_r;
      end
    //  Register: XRA     Address: 0x4     External: false
    2'b01:
      begin
        d2l_XRA_we = pio_write_active & ~dec_pio_ack;
        d2l_XRA_re = pio_read_active & ~dec_pio_ack;
        pio_internal_ack =  pio_read_active | pio_write_active;
        dec_pio_read_data_next  [31:0]  = l2d_XRA_r;
      end
    //  Register: XSP     Address: 0x8     External: false
    2'b10:
      begin
        d2l_XSP_we = pio_write_active & ~dec_pio_ack;
        d2l_XSP_re = pio_read_active & ~dec_pio_ack;
        pio_internal_ack =  pio_read_active | pio_write_active;
        dec_pio_read_data_next  [31:0]  = l2d_XSP_r;
      end
    endcase
  end
  
endmodule

//
//---------- module RV32I_regfile_pio
//
module RV32I_regfile_pio
(
  clk,
  reset,
  h2l_XSP_xsp_w,
  leaf_dec_wr_data,
  leaf_dec_addr,
  leaf_dec_block_sel,
  leaf_dec_valid,
  leaf_dec_wr_dvld,
  leaf_dec_cycle,
  leaf_dec_wr_width,

  l2h_X0_x0_zero_r,
  l2h_XRA_xra_r,
  l2h_XSP_xsp_r,
  dec_leaf_rd_data,
  dec_leaf_ack,
  dec_leaf_nack,
  dec_leaf_accept,
  dec_leaf_reject,
  dec_leaf_retry_atomic,
  dec_leaf_data_width );

  //------- inputs
  input    clk;
  input    reset;
  input     [31:0] h2l_XSP_xsp_w;
  input     [31:0] leaf_dec_wr_data;
  input     [39:0] leaf_dec_addr;
  input    leaf_dec_block_sel;
  input    leaf_dec_valid;
  input    leaf_dec_wr_dvld;
  input     [1:0] leaf_dec_cycle;
  input     [2:0] leaf_dec_wr_width;

  //------- outputs
  output     [31:0] l2h_X0_x0_zero_r;
  output     [31:0] l2h_XRA_xra_r;
  output     [31:0] l2h_XSP_xsp_r;
  output     [31:0] dec_leaf_rd_data;
  output    dec_leaf_ack;
  output    dec_leaf_nack;
  output    dec_leaf_accept;
  output    dec_leaf_reject;
  output    dec_leaf_retry_atomic;
  output     [2:0] dec_leaf_data_width;


  //------- wire defines
  logic   [31:0] d2l_X0_w;
  logic  d2l_X0_we;
  logic  d2l_X0_re;
  logic   [31:0] d2l_XRA_w;
  logic  d2l_XRA_we;
  logic  d2l_XRA_re;
  logic   [31:0] d2l_XSP_w;
  logic  d2l_XSP_we;
  logic  d2l_XSP_re;
  logic   [31:0] l2d_X0_r;
  logic   [31:0] l2d_XRA_r;
  logic   [31:0] l2d_XSP_r;
  
  
  RV32I_regfile_jrdl_decode pio_decode ( .* );
    
  RV32I_regfile_jrdl_logic pio_logic ( .* );
    
endmodule

