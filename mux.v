`timescale 1ns / 1ps

module mux_2to1 #(parameter WIDTH = 32)(
    input wire [WIDTH-1:0] d0, d1,
    input sel,
    output [WIDTH-1:0] y
    );
    
    assign y = sel ? d1 : d0;
        
endmodule
