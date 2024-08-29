`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/25/2024 01:37:54 PM
// Design Name: 
// Module Name: readdecoder
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


module readdecoder(input clk,
                   input [4:0] A,
                   output reg [31:0] R);
                   
    always @(posedge clk) begin
        
        R = 32'b0;
        
        if (A == 32) R = 32'b0;
        else R[A] = 1'b1;
        
    end


endmodule
