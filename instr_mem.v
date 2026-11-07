`timescale 1ns / 1ps

module instr_mem(
    input wire [31:0] addr,      // PC address
    output wire [31:0] instr_out // 32-bit instruction
    );
    
    // 256 words of 32-bit memory (1KB)
    reg [31:0] rom [0:255];

    // Initialize memory from a hex file (compiled RISC-V code)
    initial begin
        $readmemh("test_program.mem", rom);
    end

    // RISC-V is byte-addressable, but instructions are word-aligned (4 bytes).
    // We ignore the bottom 2 bits of the address to fetch the correct word.
    assign instr_out = rom[addr[9:2]]; 

    
endmodule
