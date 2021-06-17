/* Register file main including parameter and defines */

// Parameters
parameter N_WORD    = 1024;
parameter ADDR_W    = 10;
parameter INSTR_LEN = 32;

// Classes tests
program test_p();
endprogram

class testclass;
    string ln;
    function new(string name);
        ln = name;
    endfunction
endclass

// Macros if needed