`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/23/2024 08:52:13 PM
// Design Name: 
// Module Name: reduce
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


module reduce (input [31:0] BaseResult,
               input [2:0] Width,
               output [31:0] Result);
        
    reg [31:0] TempResult;
    
    always @(*) begin
        case(Width)
        
            //32-bit
            3'b000: TempResult = BaseResult;
        
            //16-bit signed
            3'b010: TempResult = {{16{BaseResult[15]}}, BaseResult[15:0]};
        
            //16-bit unsigned
            3'b110: TempResult = {16'b0, BaseResult[15:0]};
        
            //8-bit signed
            3'b001: TempResult = {{24{BaseResult[7]}}, BaseResult[7:0]};
        
            //8-bit unsigned
            3'b101: TempResult = {24'b0, BaseResult[7:0]};
        
            //Undefined
            default: TempResult = 32'bx;
        
        endcase
    
    end
    
    
endmodule
