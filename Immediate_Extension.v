`timescale 1ns / 1ps
module Immediate_Extension(
input [31:0] instruc,
output reg [31:0] imm
    );

//instruc[6:0] = opcode
always @(*)
begin
    case(instruc[6:0])
        //I type
        7'b0010011,7'b0000011,7'b1100111: //Imm, Load, JALR
        begin
        imm = {{20{instruc[31]}}, instruc[31:20]};// Sign extension + 12bit original bits
        end
        //S type
        7'b0100011://store
        begin
        imm = {{20{instruc[31]}},instruc[31:25],instruc[11:7]};//Sign ext + upper 7 Bits + lower 5 bits
        end
        //J type
        7'b1101111://.JAL
        begin
        imm = {{12{instruc[31]}},instruc[19:12],instruc[20],instruc[30:21],1'b0};
        end
        //B type
        7'b1100011://branch
        begin
        imm = {{20{instruc[31]}},instruc[7],instruc[30:25],instruc[11:8],1'b0};
        end
        //U type
        7'b0010111,7'b0110111://AUIPC,LUI
        begin
        imm = {instruc[31:12],12'b0};
        end
        
        default: imm = 0;  
    endcase
end            
endmodule