`timescale 1ns / 1ps

module data_mem(
    input wire clk,
    input wire MemWrite,        // Write enable
    input wire MemRead,         // Read enable (optional in simple designs, but good practice)
    input wire [31:0] addr,     // Address from ALU
    input wire [31:0] write_data, // Data from Register File (Rs2)
    output wire [31:0] read_data  // Data to Writeback MUX
    );
    
    // 256 words of 32-bit memory
    reg [31:0] ram [0:255];

    // Synchronous Write
    always @(posedge clk) begin
        if (MemWrite)
            ram[addr[9:2]] <= write_data;
    end

    // Asynchronous Read
    assign read_data = (MemRead) ? ram[addr[9:2]] : 32'b0;
    
endmodule
