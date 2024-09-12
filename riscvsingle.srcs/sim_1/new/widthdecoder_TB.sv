`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/12/2024 03:15:43 PM
// Design Name: 
// Module Name: widthdecoder_TB
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Testbench for widthdecoder
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module widthdecoder_TB();
    
    //stimulus, outputs and expected outputs
    logic [2:0] funct3, WidthSrc, WidthSrcExp;
    logic WidthOp;
    
    //Array for holding testable values of funct3
    logic [2:0] funct3Val [5:0];
    
    //Array for holding associated expected output
    logic [2:0] funct3Output [5:0];
    
    
    
    widthdecoder DUT(funct3, WidthOp, WidthSrc);
    
    initial begin
        
        //Instructions where funct3 determines WidthSrc
        WidthOp = 0;
        WidthSrcExp = 3'b000;
        
        //Ensure output is as expected for all values of funct3
        for (int i = 0; i < 8; i++) begin
            funct3 <= i; #10;
            assert (WidthSrc === WidthSrcExp) else $fatal("Error: WidthOp = 0 produces unexpected output");
        end 
        
        //Instructions where funct3 determines WidthSrc
        WidthOp = 1;
        
        //Populate arrays for checking valid functions of funct3
        funct3Val[0] = 3'b010; funct3Output[0] = 3'b000;
        funct3Val[1] = 3'b001; funct3Output[1] = 3'b010;
        funct3Val[2] = 3'b000; funct3Output[2] = 3'b001;
        funct3Val[3] = 3'b101; funct3Output[3] = 3'b110;
        funct3Val[4] = 3'b100; funct3Output[4] = 3'b101;
        funct3Val[5] = 3'b111; funct3Output[5] = 3'bxxx;
        
        //loop through values of funct3
        for (int i = 0; i < 6; i++) begin
            funct3 = funct3Val[i]; WidthSrcExp = funct3Output[i]; #10;
            
            assert (WidthSrc === WidthSrcExp) else $fatal("Error: Unexpected output. funct3: %b\n\
                                                           Expected output: %b\n\
                                                           Actual output:   %b", funct3, WidthSrcExp, WidthSrc);
        end
        
        
        $display("Simulation Succesful!");
    
    end
    
endmodule
