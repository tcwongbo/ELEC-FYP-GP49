`timescale 1ns / 1ps
module Register_File_tb();
reg write_en;
reg [4:0] read_reg1;//rs1 address
reg [4:0] read_reg2;//rs2 address
reg [4:0] write_reg;//rd address
reg [31:0] write_data;
reg clk;
wire [31:0] read_data1;
wire [31:0] read_data2;

//10ns a cycle clock
always #5 clk=~clk;

//test module
Register_File test(
.write_en(write_en),
.read_reg1(read_reg1),
.read_reg2(read_reg2),
.write_reg(write_reg),
.write_data(write_data),
.clk(clk),
.read_data1(read_data1),
.read_data2(read_data2)
);

initial begin
clk=0;
write_en=0;
read_reg1=0;
read_reg2=0;
write_reg=0;
write_data=0;


//1:Normal write data check
#10;//1cycle
write_en =1;
write_reg=5'd1;
write_data=32'd10;
#10;
read_reg1=5'd1;
write_en =0;
#10;
if(read_data1 ==32'd10)
    $display("Pass test1 : successful read and write");
else
    $display("Fail test1 : wrong read or write");

//2:Write to reg x0
#10;//1cycle
write_en =1;
write_reg=5'd0;
write_data=32'd5;
#10;
read_reg1=5'd0;
write_en =0;
#10;
if(read_data1 ==32'd0)
    $display("Pass test2 : successful read and write to reg x0");
else
    $display("Fail test2 : wrong read or write to reg x0");

//3:Read 2 register at the same time
#10;//1cycle
write_en =1;
write_reg=5'd2;
write_data=32'd20;
#10;
write_en =0;
read_reg1=5'd1;
read_reg2=5'd2;
#10;
if((read_data1 ==32'd10) && (read_data2==32'd20))
    $display("Pass test3 : successful read and write two register simultaneously");
else
    $display("Fail test3 : wrong read or write two register simultaneously");

//4: write enable test
#10;
write_en=0;
write_reg=5'd2;
write_data=32'd30;
#10;
read_reg1=5'd2;
#10;
if(read_data1 == 20)
    $display("Pass test4 : successful write enable test");
else if (read_data1 == 30)
    $display("Fail test4 : write enable not working");
else
    $display("Error in test4");

#10;
    $display("Tests for Register File Completed");
#10;
    $finish;
end

endmodule
