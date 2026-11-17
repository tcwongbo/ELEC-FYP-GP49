`timescale 1ns / 1ps

module Immediate_Extension_tb( );

reg [31:0]instruc;
wire [31:0] imm;

Immediate_Extension test(
.instruc(instruc),
.imm(imm)
);


initial begin
//1: I type
#10;
instruc = 32'h00A10093;
#10;
if (imm== 32'h0000000A)
    $display("Pass test 1: Successful I type extension");
else
    $display("Fail test 1: Wrong I type extension");



//2: Negative I type
#10;
instruc = 32'hFFF00093;
#10;
if (imm== 32'hFFFFFFFF)
    $display("Pass test 2: Successful Negative I type extension");
else
    $display("Fail test 2: Wrong Negative I type extension");

//3:S type 
#10;
instruc = 32'h00512423;
#10;
if (imm== 32'h00000008)
    $display("Pass test 3: Successful S type extension");
else
    $display("Fail test 3: Wrong S type extension");

//4:J type
#10;
instruc = 32'h010000EF;
#10;
if (imm== 32'h00000010)
    $display("Pass test 4: Successful J type extension");
else
    $display("Fail test 4: Wrong J type extension");
//5:B type
#10;
instruc = 32'h08000063;
#10;
if (imm== 32'h00000080)
    $display("Pass test 5: Successful B type extension");
else
    $display("Fail test 5: Wrong B type extension");

//6:U type
#10;
instruc = 32'hABCDE0B7;
#10;
if (imm== 32'hABCDE000)
    $display("Pass test 6: Successful U type extension");
else
    $display("Fail test 6: Wrong U type extension");

#10;
    $display("Finished immediate extension tests");
    
  $finish; 
end
endmodule
