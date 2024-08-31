`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/30/2024 04:12:05 PM
// Design Name: 
// Module Name: maindecoder
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


module maindecoder(input [6:0] op,
                   input [2:0] funct3,
                   output [2:0] ImmSrc, WidthSrc, ResultSrc, Branch,
                   output [1:0] ALUOp,
                   output ALUSrc,
                   output RegWrite, MemWrite,
                   output Jump, PCBaseSrc);


    reg [18:0] controls;
    
    assign {RegWrite, ImmSrc, ALUSrc, MemWrite,
            ResultSrc, Branch, ALUOp, WidthSrc, Jump, PCBaseSrc} = controls;
                   
    always @(*) begin
    
        case(op)
        //RegWrite_ImmSrc_ALUSrc_MemWrite_ResultSrc_Branch_ALUOp_WidthSrc_Jump_PCBaseSrc
            
            //Load I-Type Instructions
            7'b0000011: begin
                    
                    //Width of load dependant on funct3
                    case(funct3)
                        3'b010: controls = 19'b1_000_1_0_001_000_00_000_0_x; //lw
                        3'b001: controls = 19'b1_000_1_0_001_000_00_010_0_x; //lh
                        3'b101: controls = 19'b1_000_1_0_001_000_00_110_0_x; //lhu
                        3'b000: controls = 19'b1_000_1_0_001_000_00_001_0_x; //lb
                        3'b100: controls = 19'b1_000_1_0_001_000_00_101_0_x; //lbu
                    endcase
            
                end
               
            //S-Type Instructions
            7'b0100011: begin
                    
                    case(funct3) 
                        3'b010: controls = 19'b0_001_1_1_xxx_000_00_000_0_x; //sw
                        3'b001: controls = 19'b0_001_1_1_xxx_000_00_x10_0_x; //sh
                        3'b000: controls = 19'b0_001_1_1_xxx_000_00_x01_0_x; //sb
                    endcase
            
            
                end
        
        endcase
    
    end                   

endmodule
