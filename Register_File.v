`timescale 1ns / 1ps
module Register_File(
input write_en,
input [4:0] read_reg1,//rs1 address
input [4:0] read_reg2,//rs2 address
input [4:0] write_reg,//rd address
input [31:0] write_data,
input clk,
output [31:0] read_data1,
output [31:0] read_data2
);


//Register array
reg [31:0] mem_array [31:0];

//Write
always @(posedge clk)
begin
    if((write_en==1)&&(write_reg!=5'd0))
    begin
        mem_array [write_reg] <= write_data;
    end
end


//Read
assign read_data1 = (read_reg1 == 5'd0)? 0:mem_array[read_reg1];
assign read_data2 = (read_reg2 == 5'd0)? 0:mem_array[read_reg2];
endmodule