/* Testbench top with nested program to keep Module separated */
// `include "./regfile_if.sv"

// Top module
module tb_top();
    // Input ports
    // clock and reset
    bit clk;
    bit ares;
    
    // Store Values
    bit [REG_DATA_W-1:0] acomp[REG_NUMBER-1:0];
    // local varibales
    logic [31:0] od1, od2;

    // Declare interface
    regfile_if r_if(.clk(clk),.ares(ares));

    // DUT
    register_file uut (
        // Input ports
        // clock and reset
        .rf_clk     (r_if.clk),
        .rf_ares    (r_if.ares),
        // decoder addresses
        .rw_dec     (r_if.waddr),
        .ra_dec     (r_if.raddr1),
        .rb_dec     (r_if.raddr2),
        .w_data_in  (r_if.wdata),
        // write enable
        .wr_en      (r_if.wen),
        // Output ports
        .qa_out     (r_if.rdata1),
        .qb_out     (r_if.rdata2)
    );

    // clock gen
    always begin: clk_gen
        clk = #10 ~clk;
    end

    // program blocks are always executed in Re-Region
    // program regfile_programm();
        // First case incremental write
        initial begin           
            // reset
            r_if.issue_reset();

            // Start
            for(int i = 0; i <= (REG_NUMBER-1); i++) begin
                r_if.issue_wr(i,i);
                acomp[i] = i;
            end
            
            // Second case incremental read
            for(int ii = 0; ii <= (REG_NUMBER-1); ii++) begin
                r_if.issue_rd1(ii,od1);
                r_if.issue_rd2(ii,od2);
                @(posedge r_if.clk);
            end
        
            // Third case B2B WRR or RRW access
            
            // Fourth case Parallel Read After Write
        end
    // endprogram


    // Test time controller
    initial begin
        // Dump
        $dumpfile("dump.vcd");
        $dumpvars(0);    
        #2000;
        $finish();
    end
endmodule