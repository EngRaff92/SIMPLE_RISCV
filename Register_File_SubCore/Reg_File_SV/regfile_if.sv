/* Main Interface */
// `include "regfile_pkg.sv"

// Interface
interface regfile_if(input bit clk, output bit ares);
    bit [ADDR_WIDTH-1:0] waddr, raddr1, raddr2;
    bit [REG_DATA_W-1:0] wdata, rdata1, rdata2;
    bit wen;

    // Task issue single write write the write is CLOKED
    task issue_wr(  input bit [ADDR_WIDTH-1:0] addr, 
                    input bit [REG_DATA_W-1:0] wd);
        $display("Rquesting write at address: %0h with data: %0h",addr,wd);
        @(posedge clk);
        waddr = addr;
        wdata = wd;
        wen = 1;
        // Clocking blocks are not yet supported with signals
        // cb_wr.waddr = addr;
        // cb_wr.wdata = wd;
        @(negedge clk);
        wen = 0;
    endtask

    // Task to issue a single read to port 1
    task issue_rd1( input bit [ADDR_WIDTH-1:0] addr, 
                    output bit [REG_DATA_W-1:0] rd1);
        raddr1 = addr;
        rd1 = rdata1;
        // No Race
        $monitor("Rquesting read 1 at address: %0h with data: %0h",addr,rdata1);            
    endtask

    // Task to issue a single read to port 1
    task issue_rd2( input bit [ADDR_WIDTH-1:0] addr, 
                    output bit [REG_DATA_W-1:0] rd2);
        raddr2 = addr;
        rd2 = rdata2;
        // No Race
        $monitor("Rquesting read 2 at address: %0h with data: %0h",addr,rdata2);            
    endtask

    // Task used to issue the reset
    task issue_reset();
        $display("DUT under of reset");
        ares = 0;
        #20;
        ares = 1;
        #20;
        ares = 0;
        $display("DUT out of reset");
    endtask

    /* not yet supported by Icarus v11 */
    // Clocking block
    // clocking cb_wr @(posedge clk);
    //     default input #1step output #1step;
    //     output waddr, wdata;
    // endclocking: cb_wr
endinterface

// program test1(interface pif);
//     initial pif.issue_reset();
// endprogram