`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/21/2024 04:33:04 PM
// Design Name: 
// Module Name: riscvsingle
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module riscvsingle(input clk, reset,
                   output PC,
                   input [31:0] instr,
                   output MemWrite,
                   output [2:0] WidthSrc,
                   output [31:0] ALUResult, WriteData,
                   input ReadData);

    wire PCSrc, PCBaseSrc, ALUSrc, RegWrite, Jump;
    wire Zero, Overflow, Carry, Negative;
    wire [2:0] ResultSrc, ImmSrc;
    wire ALUControl[3:0];

endmodule




