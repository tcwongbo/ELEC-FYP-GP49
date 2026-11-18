`timescale 1ns / 1ps

module control_tb();

reg [6:0] opcode;
wire RegWrite, MemRead, MemWrite, MemtoReg, ALUSrc, RegDst, Branch, Jump;
wire [1:0] ALUOp;

control ctrl (
        .opcode(opcode),
        .RegWrite(RegWrite), .MemRead(MemRead), .MemWrite(MemWrite),
        .MemtoReg(MemtoReg), .ALUSrc(ALUSrc), .RegDst(RegDst),
        .Branch(Branch), .Jump(Jump), .ALUOp(ALUOp)
        );

initial begin

// Test R-type (opcode 0110011)
opcode = 7'b0110011;
#10;
$display("R-type: RegWrite=%b, ALUSrc=%b, RegDst=%b, ALUOp=%b",
         RegWrite, ALUSrc, RegDst, ALUOp);
// Expected: RegWrite=1, ALUSrc=0, RegDst=1, ALUOp=10

// Test lw (opcode 0000011)
opcode = 7'b0000011;
#10;
$display("lw: RegWrite=%b, MemRead=%b, MemtoReg=%b, ALUSrc=%b",
         RegWrite, MemRead, MemtoReg, ALUSrc);
// Expected: RegWrite=1, MemRead=1, MemtoReg=1, ALUSrc=1

// Test sw (opcode 0100011)
opcode = 7'b0100011;
#10;
$display("sw: MemWrite=%b, ALUSrc=%b", MemWrite, ALUSrc);
// Expected: MemWrite=1, ALUSrc=1

// Test beq (opcode 1100011)
opcode = 7'b1100011;
#10;
$display("beq: Branch=%b, ALUOp=%b", Branch, ALUOp);
// Expected: Branch=1, ALUOp=01

// Test addi (opcode 0010011)
opcode = 7'b0010011;
#10;
$display("addi: RegWrite=%b, ALUSrc=%b, ALUOp=%b", RegWrite, ALUSrc, ALUOp);
// Expected: RegWrite=1, ALUSrc=1, ALUOp=10

// Test jal (opcode 1101111)
opcode = 7'b1101111;
#10;
$display("jal: RegWrite=%b, Jump=%b", RegWrite, Jump);
// Expected: RegWrite=1, Jump=1

$finish;

end

endmodule
