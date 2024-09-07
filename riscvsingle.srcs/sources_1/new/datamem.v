`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/06/2024 12:25:17 PM
// Design Name: 
// Module Name: datamem
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Stores the data of the system. Can have variable width stores through control signal WidthSrc
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module datamem #(parameter WIDTH = 32)
            (input clk, WE,
             input [1:0] WidthSrc,
             input [WIDTH-1:0] A, WD,
             output [WIDTH-1:0] RD);
               
    reg [31:0] RAM[63:0];

    always @(posedge clk) begin
        
        if (WE) begin
        //Change last bit of A index to maintain word, and half-word alignment
            case(WidthSrc)
                2'b00: RAM[A[31:2]] <= WD;
                2'b10: RAM[A[31:1]] <= WD[15:0];
                2'b01: RAM[A[31:0]] <= WD[8:0];

            endcase
        
        
        end
       
    
    end
    

endmodule
