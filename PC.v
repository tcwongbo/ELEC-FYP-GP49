`timescale 1ns / 1ps
module PC(
input clk,reset,
input [31:0] pc_target,
output reg [31:0] pc
    );
    
always @(posedge clk)
begin
    if(reset==1)
        pc <= 32'd0;
    else
        pc<= pc_target;
end    
     
endmodule
