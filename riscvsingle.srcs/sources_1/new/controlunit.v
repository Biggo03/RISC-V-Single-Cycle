`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/01/2024 04:13:20 PM
// Design Name: 
// Module Name: controlunit
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Combines 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module controlunit(input [6:0] op,
                   input [2:0] funct3,
                   input funct7b5,
                   output [3:0] ALUControl,
                   output [2:0] ImmSrc, WidthSrc, ResultSrc,
                   output ALUSrc,
                   output RegWrite, MemWrite,
                   output PCSrc, PCBaseSrc);
        
endmodule
