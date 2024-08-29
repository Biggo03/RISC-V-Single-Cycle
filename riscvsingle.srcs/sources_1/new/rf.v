`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/23/2024 09:43:28 PM
// Design Name: 
// Module Name: rf
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


module rf(input clk, reset,
          input [4:0] A1, A2, A3,
          input [31:0] WD3,
          input WE3,
          output [31:0] RD1, RD2);
    
    //Signals to hold the values of the created registers at all times
    reg [31:0] RegisterArray [31:0];
    
    //will enable writing to register that matches index of the active bit
    wire [31:0] en;
    
    //Initalize the registers
    
    //Zero register
    flop zero(clk, 1'b0, reset, 32'b0, RegisterArray[0]);
    
    //Return address register (x1)
    flop ra(clk, en[1], reset, WD3, RegisterArray[1]);
    
    //Stack pointer (x2)
    flop sp(clk, en[2], reset, WD3, RegisterArray[2]);  
    
    //Global pointer (x3)
    flop gp(clk, en[3], reset, WD3, RegisterArray[3]);
    
    //Thread pointer (x4)
    flop tp(clk, en[4], reset, WD3, RegisterArray[4]);
    
    //Temporary registers (x5-x7, x28-x31)
    flop t0(clk, en[5], reset, WD3, RegisterArray[5]);
    flop t1(clk, en[6], reset, WD3, RegisterArray[6]);
    flop t2(clk, en[7], reset, WD3, RegisterArray[7]);
    flop t3(clk, en[28], reset, WD3, RegisterArray[28]);
    flop t4(clk, en[29], reset, WD3, RegisterArray[29]);
    flop t5(clk, en[30], reset, WD3, RegisterArray[30]);
    flop t6(clk, en[31], reset, WD3, RegisterArray[31]);
    
    //Saved register/Frame pointer (x8)
    flop s0(clk, en[8], reset, WD3, RegisterArray[8]);
    
    //Saved registers (x9, x18-x27)
    flop s1(clk, en[9], reset, WD3, RegisterArray[9]);
    flop s2(clk, en[18], reset, WD3, RegisterArray[18]);
    flop s3(clk, en[19], reset, WD3, RegisterArray[19]);
    flop s4(clk, en[20], reset, WD3, RegisterArray[20]);
    flop s5(clk, en[21], reset, WD3, RegisterArray[21]);
    flop s6(clk, en[22], reset, WD3, RegisterArray[22]);
    flop s7(clk, en[23], reset, WD3, RegisterArray[23]);
    flop s8(clk, en[24], reset, WD3, RegisterArray[24]);
    flop s9(clk, en[25], reset, WD3, RegisterArray[25]);
    flop s10(clk, en[26], reset, WD3, RegisterArray[26]);
    flop s11(clk, en[27], reset, WD3, RegisterArray[27]);
    
    //Function arguments and return values (x10- x17)
    flop a0(clk, en[10], reset, WD3, RegisterArray[10]);
    flop a1(clk, en[11], reset, WD3, RegisterArray[11]);
    flop a2(clk, en[12], reset, WD3, RegisterArray[12]);
    flop a3(clk, en[13], reset, WD3, RegisterArray[13]);
    flop a4(clk, en[14], reset, WD3, RegisterArray[14]);
    flop a5(clk, en[15], reset, WD3, RegisterArray[15]);
    flop a6(clk, en[16], reset, WD3, RegisterArray[16]);
    flop a7(clk, en[17], reset, WD3, RegisterArray[17]);
    
    
    //Reading logic   
    assign RD1 = RegisterArray[A1];
    assign RD2 = RegisterArray[A2];
    
    //Writing Logic (only need to set enable bit)
    writedecoder enabledecoder(A3, en);     
          
endmodule
