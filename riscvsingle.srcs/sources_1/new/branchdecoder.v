`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/02/2024 04:32:00 PM
// Design Name: 
// Module Name: branchdecoder
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


module branchdecoder(input [2:0] funct3,
                     input [1:0] BranchOp,
                     input N, Z, C, V,
                     output PCSrc);

    reg TempPCSrc;

    
    //Branch signal computation
    always @(*) begin
        
        case(BranchOp)
            
            2'b00: TempPCSrc = 1'b0; //Non-branching instructions
            2'b01: TempPCSrc = 1'b1; //Jumping instructions
            
            //B-type instructions
            2'b10: begin
                
                //Type of branch dependant on funct3
                case(funct3)
                    
                    3'b000: TempPCSrc = Z;      //beq
                    3'b001: TempPCSrc = ~Z;     //bne
                    3'b101: TempPCSrc = ~(N^V); //bge
                    3'b111: TempPCSrc = C;      //bgeu
                    3'b100: TempPCSrc = N^V;    //blt
                    3'b110: TempPCSrc = ~C;     //bltu
                    default: TempPCSrc = 1'bx;   //Unknown branch condition
                
                endcase
                
            end
            
            default: TempPCSrc = 1'bx; //Unknown BranchOp
            
        endcase
    
    end
    
    //Assignment of temp value to proper signal
    assign PCSrc = TempPCSrc;
    

endmodule
