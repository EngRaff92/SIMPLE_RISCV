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
    int sel;
    bit error;

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
    // endprogram

    initial begin: run_test
        // Dump
        $dumpfile("dump.vcd");
        $dumpvars(0);    
        // select test
        if (!$value$plusargs("s=%d", sel)) begin
            $error("ERROR: please specify test scenario to start");
            // end
            $finish;
        end
        else begin
            case(sel)
                0: testcase0();
                1: testcase1();
                2: testcase2();
                3: testcase3();
                // default run only reset test
                default: testcase2();
            endcase
            // report
            report(error);
            // end
            $finish();
        end
    end

    // Test scenarios 
    /*
        coded with tasks since:
        1. the programs do not accept interfaces as input
        2. the program needs ports to be rerouted to the DUT
        3. Reusability since the interface was already been coded up
    */
    task testcase0();
        // First case incremental write     
        $display("Running incremental op scenario ");

        // reset
        r_if.issue_reset();

        // Start
        for(int i = 0; i <= (REG_NUMBER-1); i++) begin
            r_if.issue_wr(i,i);
            acomp[i] = i;
        end
        
        // Second case incremental read
        for(int ii = 0; ii <= (REG_NUMBER-1); ii++) begin
            // read both
            r_if.issue_rd1(ii,od1);
            r_if.issue_rd2(ii,od2);
            // Compare
            if(acomp[ii] !== od1) begin
                $error("read value: %0h on port1 not equal to the first value written: %0h at time: %0t", od1,acomp[ii],$time());
                error = 1;
            end
            if(acomp[ii] !== od2) begin
                $error("read value: %0h on port2 not equal to the first value written: %0h at time: %0t", od2,acomp[ii],$time());
                error = 1;
            end
        end
    endtask

    task testcase1();
        // second case B2B access RWR
        $display("Running B2B scenario RWR");

        // reset
        r_if.issue_reset();

        // Start
        for(int i = 0; i <= (REG_NUMBER-1); i++) begin
            r_if.issue_rd1(i,od1);
            if(32'h0 !== od1) begin
                $error("read value: %0h on port1 not equal to 0", od1);
                error = 1;
            end
            acomp[i] = $random();
            r_if.issue_wr(i,acomp[i]);
            // Make sure the first value is always 0
            acomp[i] = (i == 0) ? '0 : acomp[i];
            r_if.issue_rd2(i,od2);
            if(acomp[i] !== od2) begin
                $error("read value: %0h on port2 not equal to the first value written: %0h", od2,acomp[i]);            
                error = 1;
            end
        end
    endtask

    task testcase2();
        // reset test run the reset and make sure everything is 0
        $display("Running reset scenario");

        // reset
        r_if.issue_reset();

        // Start
        for(int i = 0; i <= (REG_NUMBER-1); i++) begin
            r_if.issue_rd1(i,od1);

            if(32'h0 !== od1) begin
                $error("read value: %0h on port1 not equal to 0", od1);
                error = 1;
            end

            r_if.issue_rd2(i,od2);

            if(32'h0 !== od2) begin
                $error("read value: %0h on port2 not equal to 0", od1);
                error = 1;
            end
        end      

        // Pass fail test  
    endtask

    task testcase3();
        // Randomize the address
        bit [5:0] addr = $urandom();

        // Parallel Access
        $display("Running Parallel OP scenario");

        // reset
        r_if.issue_reset();

        // Fork threads
        fork
            r_if.issue_rd1(addr,od1);
            r_if.issue_rd2(addr,od2);
            r_if.issue_wr(addr,'hA);
        join // join_all

        // Compare since the write is consumed after the 2 reads we should ideally read back 0
        // This happens because the Read is faster than the write so if Read is issued is consumed straight after
        if(od1 == 'hA)
            $error("Write won on the Read on port 1 at time: %0t",$time());
        if(od2 == 'hA)
            $error("Write won on the Read on port 2 at time: %0t",$time());

        // Repeat
        // Fork threads
        fork
            r_if.issue_rd1(addr,od1);
            r_if.issue_rd2(addr,od2);
            r_if.issue_wr(addr,'hFA);
        join // join_all

        // Compare since the write is consumed after the 2 reads we should ideally read back 0
        // This happens because the Read is faster than the write so if Read is issued is consumed straight after
        if(od1 != 'hA)
            $error("Write won on the Read on port 1 at time: %0t",$time());
        if(od2 != 'hA)
            $error("Write won on the Read on port 2 at time: %0t",$time());
    endtask

    // report task used at the end of the sim
    task report (input bit error);
        $display("###############################################");
        if(error)   $error("Test scenario: %0d is failing",sel);
        else        $display("Test scenario: %0d is passing",sel);
        $display("###############################################");
        $display("Total time taken by simulation is: %0t (ns)",$time());
        $display("###############################################");
    endtask
endmodule