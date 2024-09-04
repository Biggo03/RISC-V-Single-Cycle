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
// Description: Generates a one-hot encoded signal based on a given address.
//              The active bit is of index A.
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module writedecoder(input [4:0] A,
                    output [31:0] en);
                            
    assign en = 1'b1 << A;

endmodule
