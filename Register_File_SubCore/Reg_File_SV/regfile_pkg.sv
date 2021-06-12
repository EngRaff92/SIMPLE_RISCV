/* Register file main including parameter and defines */

// Parameters
parameter REG_NUMBER    = 32;
parameter REG_DATA_W    = 32;
parameter ADDR_WIDTH    = 5; //$clog2(REG_NMBER);

// Enum
typedef enum{  
    SEQ=0,
    B2B=1,
    RRW=2,
    WRR=3
}tsttype;

// Classes tests
program test_p();
endprogram

class testclass;
    string ln;
    rand tsttype test_sel;
    function new(string name);
        ln = name;
    endfunction
endclass

// Macros if needed