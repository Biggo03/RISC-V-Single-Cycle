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
    
    //Temporary values for outputs while in always statements
    reg [31:0] TempRD1, TempRD2;
    
    //Signals to hold the values of the created registers at all times
    reg [31:0] x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12, x13, x14, x15;
    reg [31:0] x16, x17, x18, x19, x20, x21, x22, x23, x24, x25, x26, x27, x28, x29, x30, x31;
    
    //Make value for zero register wire to allow constant assignment of 0
    wire [31:0] x0;
    
    //will enable writing to register that matches index of the active bit
    wire [30:0] en;
    
    //Initalize the registers
    
    //Zero register
    assign x0 = 32'b0;
    
    //Return address register
    flop ra(clk, en[0], reset, WD3, x1);
    
    //Stack pointer
    flop sp(clk, en[1], reset, WD3, x2);  
    
    //Global pointer
    flop gp(clk, en[2], reset, WD3, x3);
    
    //Thread pointer
    flop tp(clk, en[3], reset, WD3, x4);
    
    //Temporary registers
    flop t0(clk, en[4], reset, WD3, x5);
    flop t1(clk, en[5], reset, WD3, x6);
    flop t2(clk, en[6], reset, WD3, x7);
    flop t3(clk, en[27], reset, WD3, x28);
    flop t4(clk, en[28], reset, WD3, x29);
    flop t5(clk, en[29], reset, WD3, x30);
    flop t6(clk, en[30], reset, WD3, x31);
    
    //Saved register/Frame pointer
    flop s0(clk, en[7], reset, WD3, x8);
    
    //Saved registers
    flop s1(clk, en[8], reset, WD3, x9);
    flop s2(clk, en[17], reset, WD3, x18);
    flop s3(clk, en[18], reset, WD3, x19);
    flop s4(clk, en[19], reset, WD3, x20);
    flop s5(clk, en[20], reset, WD3, x21);
    flop s6(clk, en[21], reset, WD3, x22);
    flop s7(clk, en[22], reset, WD3, x23);
    flop s8(clk, en[23], reset, WD3, x24);
    flop s9(clk, en[24], reset, WD3, x25);
    flop s10(clk, en[25], reset, WD3, x26);
    flop s11(clk, en[26], reset, WD3, x27);
    
    //Function arguments and return values
    flop a0(clk, en[9], reset, WD3, x10);
    flop a1(clk, en[10], reset, WD3, x11);
    flop a2(clk, en[11], reset, WD3, x12);
    flop a3(clk, en[12], reset, WD3, x13);
    flop a4(clk, en[13], reset, WD3, x14);
    flop a5(clk, en[14], reset, WD3, x15);
    flop a6(clk, en[15], reset, WD3, x16);
    flop a7(clk, en[16], reset, WD3, x17);
    
    //Reading logic
    
          
          
endmodule
