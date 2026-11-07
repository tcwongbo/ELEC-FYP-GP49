`timescale 1ns / 1ps

module control(
    input wire [6:0] opcode,
    
    // Datapath Control Signals
    output reg RegWrite,   // Enable writing to Register File
    output reg MemRead,    // Enable reading Data Memory
    output reg MemWrite,   // Enable writing Data Memory
    output reg MemtoReg,   // 0: ALU result, 1: Memory data
    output reg ALUSrc,     // 0: Register, 1: Immediate
    output reg RegDst,     // 0: Rt (I-type), 1: Rd (R-type)
    output reg Branch,     // Branch instruction
    output reg Jump,       // Jump instruction
    output reg [1:0] ALUOp // ALU operation type
    );
    
    always @(*) begin
        // Default: all signals to 0 (prevents latches)
        RegWrite = 0; MemRead = 0; MemWrite = 0;
        MemtoReg = 0; ALUSrc = 0; RegDst = 0;
        Branch = 0; Jump = 0; ALUOp = 2'b00;

        case (opcode)
            // R-Type (add, sub, and, or, slt)
            7'b0110011: begin
                RegWrite = 1; RegDst = 1; ALUOp = 2'b10; 
            end
            // I-Type Load (lw)
            7'b0000011: begin
                RegWrite = 1; MemRead = 1; MemtoReg = 1; ALUSrc = 1; ALUOp = 2'b00; 
            end
            // S-Type Store (sw)
            7'b0100011: begin
                MemWrite = 1; ALUSrc = 1; ALUOp = 2'b00; 
            end
            // B-Type Branch (beq)
            7'b1100011: begin
                Branch = 1; ALUOp = 2'b01; 
            end
            // I-Type ALU (addi, andi)
            7'b0010011: begin
                RegWrite = 1; ALUSrc = 1; ALUOp = 2'b10; 
            end
            // J-Type Jump (jal)
            7'b1101111: begin
                RegWrite = 1; Jump = 1; ALUOp = 2'b00; // Jump uses PC+4
            end
            // Add U-Type (lui, auipc) or default here if required later
        endcase
    end
    
endmodule
