`timescale 1ns / 1ps

module ALU_tb();
reg [31:0] a;
reg [31:0] b;
reg [3:0] alu_control;
wire zero;
wire [31:0] alu_output;

ALU test(
.a(a),
.b(b),
.alu_control(alu_control),
.alu_output(alu_output),
.zero(zero)
);
initial begin

//1:add
alu_control=4'b0000;
a=32'd20;
b=32'd10;
#10;
if(alu_output==32'd30)
    $display("Pass test 1:Correct add case");
else
    $display("Fail test 1:wrong add case");
#10;

//2:sub
alu_control=4'b0001;
a=32'd20;
b=32'd10;
#10;
if(alu_output==32'd10)
    $display("Pass test 2:Correct sub case");
else
    $display("Fail test 2:wrong sub case");
#10;
 
//zero case
alu_control=4'b0001;
a=32'd20;
b=32'd20;
#10;
if((zero==1'b1)&& (alu_output==32'd0))
    $display("Pass test 2:Correct sub zero case");
else
    $display("Fail test 2:wrong sub zero case");
#10;
    
//3:or
alu_control=4'b0010;
a=32'h0000F000;
b=32'h0000000F;
#10;
if(alu_output==32'h0000F00F)
    $display("Pass test 3:Correct or case");
else
    $display("Fail test 3:wrong or case");
#10;
    
//4:xor
alu_control=4'b0011;
a=32'h0000000A;
b=32'h0000000B;
#10;
if(alu_output==32'h00000001)
    $display("Pass test 4:Correct xor case");
else
    $display("Fail test 4:wrong xor case");
#10;
    
//5:and
alu_control=4'b0100;
a=32'h000A000A;
b=32'h0000000B;
#10;
if(alu_output==32'h0000000A)
    $display("Pass test 5:Correct and case");
else
    $display("Fail test 5:wrong and case");
#10;
    
    
//6:set less than
alu_control=4'b0101;
a=32'hFFFFFFFF;//-1
b=32'h00000001;//1
#10;
if(alu_output==32'h00000001)
    $display("Pass test 6:Correct set less than case");
else
    $display("Fail test 6:wrong set less than case");
#10;

//7:set less than unsigned
alu_control=4'b0110;
a=32'hFFFFFFFF;
b=32'h00000001;
#10;

if(alu_output==32'h00000000)
    $display("Pass test 7:Correct set less than unsigned case");
else
    $display("Fail test 7:wrong set less than unsigned case");
#10;

//8:shift right logical
alu_control=4'b0111;
a=32'h80000000;
b=32'h00000001;
#10;

if(alu_output==32'h40000000)
    $display("Pass test 8:Correct shift right logical case");
else
    $display("Fail test 8:wrong shift right logical case");
#10;
  
//9:shift right arithmetic
alu_control=4'b1000;
a=32'h80000000;
b=32'h00000001;
#10;

if(alu_output==32'hC0000000)
    $display("Pass test 9:Correct shift right arithmetic case");
else
    $display("Fail test 9:wrong shift right arithmetic case");
#10;
//10:shift left logical
alu_control=4'b1001;
a=32'h40000000;
b=32'h00000001;
#10;

if(alu_output==32'h80000000)
    $display("Pass test 10:Correct shift left logical case");
else
    $display("Fail test 10:wrong shift left logical case");
#10;

//default case test
alu_control=4'b1111;
#10;

if(alu_output==32'h00000000)
    $display("Pass default case test");
else
    $display("Fail default case test");
#10;

$display("Tests completed");
$finish;


end
endmodule
