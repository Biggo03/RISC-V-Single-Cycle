`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/25/2024 01:34:30 PM
// Design Name: 
// Module Name: writedecoder
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


module writedecoder(input [4:0] A,
                     output reg [31:0] en);
                     
    always @(A) begin
        
        //Initilize to all 0's
        en = 32'b0;
        
        //32 Registers, which have addresses 0-31, an address of 32 is invalid
        //Register 0 cannot be written to, so it is also invalid
        if (A == 32 | A == 0) en = 31'b0;
        
        else en[A] = 1'b1;
        
    end

endmodule
