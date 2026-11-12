`timescale 1ns / 1ps

module PC_Add(
input [31:0] pc_input,
output [31:0] pc_output
);
    
    
assign
pc_output = pc_input+32'd4;

endmodule
