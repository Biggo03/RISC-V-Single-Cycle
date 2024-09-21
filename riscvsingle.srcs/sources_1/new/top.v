`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/06/2024 06:35:17 PM
// Design Name: 
// Module Name: top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Instantiates the processor, as well as it's associated memories
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module top(input clk, reset,
           output [31:0] WriteData, 
           output [31:0] DataAdr,
           output MemWrite
           );
    
    (* keep = "true" *) wire [31:0] PC, Instr, ReadData;
    (* keep = "true" *) wire [2:0] WidthSrc;
    
    //instantiation of processor and memories
    riscvsingle rvsingle(clk, reset, PC, Instr, MemWrite,
                         WidthSrc, DataAdr, WriteData, ReadData);
    
    instrmem imem(PC, Instr);
    
    datamem dmem(clk, MemWrite, WidthSrc[1:0], DataAdr, WriteData, ReadData);
    
endmodule
