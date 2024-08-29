`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/24/2024 11:04:06 PM
// Design Name: 
// Module Name: writepriority
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Used to decide what register is to be written to. The active index of en is the register that will be written to
//              An invalid address will return a signal with no active bit (0)
//              
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments: 32 is an invalid address, as registers are numbered 0-31. 0 is also an invalid address, the zero register
//                      is intended to retain a constant value of 0
// 
//////////////////////////////////////////////////////////////////////////////////


module writepriority(input [4:0] A,
                     output [30:0] en);
                     
    reg [30:0] Tempen;
    
    always @(A) begin
        
        //Initilize to all 0's
        Tempen = 31'b0;
        
        //32 Registers, which have addresses 0-31, an address of 32 is invalid
        //Register 0 cannot be written to, so it is also invalid
        if (A == 32 | A == 0) Tempen = 31'b0;
        
        else Tempen[A-1] = 1'b1;
        
    end
    
    assign en = Tempen;

endmodule
