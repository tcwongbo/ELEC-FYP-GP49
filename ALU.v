`timescale 1ns / 1ps
module ALU(
input [31:0] a,
input [31:0] b,
input [3:0] alu_control,
output zero,
output reg [31:0] alu_output
 );
 
always@(*) begin
    case(alu_control)
     4'b0000: alu_output <= a+b; //add
     4'b0001: alu_output <= a-b; //sub
     4'b0010: alu_output <= a|b;//or
     4'b0011: alu_output <= a^b; //xor
     4'b0100: alu_output <= a&b; //and
     
     4'b0101: alu_output <= ($signed(a)<$signed(b))?32'h00000001:32'h00000000;//set less than
     4'b0110: alu_output <= (a<b)? 32'h00000001:32'h00000000;//set less than unsigned
     
     4'b0111: alu_output <= a>>b;//shift right logical
     4'b1000: alu_output <= $signed (a) >>> b[4:0];//shift right arithmetic
     4'b1001: alu_output <= a<<b;//shift left logical
     default: alu_output <= 32'h00000000;//default case
    endcase 
 end
 
 
 

assign zero = (alu_output==32'h00000000) ; 

endmodule
