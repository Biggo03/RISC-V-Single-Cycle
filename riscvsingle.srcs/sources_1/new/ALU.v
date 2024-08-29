`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/27/2024 05:31:28 PM
// Design Name: 
// Module Name: ALU
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


module ALU(input [3:0] ALUControl,
           input [31:0] A, B,
           output [31:0] ALUResult,
           output N, Z, C, V);

    reg [31:0] TempResult;
    reg Cout;
    reg TempC, TempV; 
    
    //VControl is used to determine if the overflow flag would be set
    wire VControl;
    assign VControl = ~(ALUControl[0] ^ A[31] ^ B[31]) & (A[31] ^ TempResult[31]);
    
    
    always @(*) begin
        
        //Operation Logic
        case(ALUControl)
            
            //Addition
            4'b1000: {Cout, TempResult} = A + B;
            
            //Subtraction
            4'b1001: {Cout, TempResult} = A - B;
            
            //AND
            4'b0010: TempResult = A & B;
            
            //OR
            4'b0011: TempResult = A | B;
            
            //XOR
            4'b0100: TempResult = A ^ B;
            
            //SLT
            4'b0101: begin
                    TempResult = A - B;
                
                    //LT comparison for sgined numbers determined by V and N flags (V ^ N)
                    if (VControl ^ TempResult[31]) TempResult = 32'b1;
                    else TempResult = 32'b0;
                
                end
            
            //SLTU
            4'b0110: begin
                
                    {Cout, TempResult} = A - B;
                
                    //LT comparison for unsigned numbers determined by C'
                    if (~Cout) TempResult = 32'b1;
                    else TempResult = 32'b0;
                
                end
                
            //Shift Left Logical
            4'b0111: TempResult = A << B;
            
            //Shift Right Logical
            4'b0000: TempResult = A >> B;
            
            //Shift Right Arithmetic
            4'b0001: TempResult = A >>>B;
            
            //Undefined case
            default: TempResult = 32'bx;
        
        endcase
        
        //Overflow and Carry Flag logic
        if (ALUControl[3] == 1'b1) begin
            if (Cout == 1'b1) TempC = 1'b1;
            else TempC = 1'b0;
            
            if (VControl == 1'b1) TempV = 1'b1;
            else TempV = 1'b0;
            
        end
        
    end
    
    //Flag Assignment
        
    //Negative Flag
    assign N = TempResult[31];
    
    //Zero Flag
    assign Z = &(~TempResult);

    //Carry Flag
    assign C = TempC;
    
    //Overflow Flag
    assign V = TempV;
    
    //Final Result Assignment
    assign Result = TempResult;

endmodule
