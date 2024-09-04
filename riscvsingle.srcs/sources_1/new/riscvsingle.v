`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/21/2024 04:33:04 PM
// Design Name: 
// Module Name: riscvsingle
// Project Name: riscvsingle
// Target Devices: 
// Tool Versions: 
// Description: Top level processor module containing both the datapath, and the control unit.
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
                   input [31:0] ReadData);
    
    //Signals used to communicate between control unit and datapath
    wire PCSrc, PCBaseSrc, ALUSrc, RegWrite;
    wire N, Z, C, V;
    wire [2:0] ResultSrc, ImmSrc;
    wire [3:0] ALUControl;
    
    //Control Unit
    controlunit CU(instr[6:0], instr[14:12], instr[30], N, Z, C, V, 
                   ALUControl, ImmSrc, WidthSrc, ResultSrc, ALUSrc, 
                   RegWrite, MemWrite, PCSrc, PCBaseSrc);
    
    //Datapath
    datapath DP(clk, reset, ALUControl, ImmSrc, WidthSrc, ResultSrc, ALUSrc,
                RegWrite, PCSrc, PCBaseSrc, instr, ReadData, WriteData, PC, ALUResult,
                N, Z, C, V);

endmodule




