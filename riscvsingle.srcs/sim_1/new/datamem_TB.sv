`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/13/2024 07:37:50 PM
// Design Name: 
// Module Name: datamem_TB
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Testbench for datamem module
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module datamem_TB();
    
    //Stimulus and device outputs
    logic clk, WE;
    logic [1:0] WidthSrc;
    logic [31:0] A, WD, RD;
    
    //Array for expected values of each storage type
    logic [31:0] RDWExp [63:0];
    logic [15:0] RDHWExp [127:0];
    logic [7:0] RDByteExp [255:0];
    
    //Used for indexing in half word
    int LowHW, HighHW;
    
    //Used for indexing in Byte storage tests
    int Byte0, Byte1, Byte2, Byte3;
    
    //Instantiate DUT
    datamem DUT(clk, WE, WidthSrc, A, WD, RD);
    
    //Clock generation
    always begin
        clk = ~clk; #5;
    end
    
    initial begin
        
        //Initialize input signals 
        clk = 0; WE = 1; WidthSrc = 2'b00;
        
        //Populate memory with values using word storage
        for (int i = 0; i < 64; i++) begin
        
            A = (i * 4); WD = i; RDWExp[i] = i; #10;
            
            assert (RD === RDWExp[i]) 
            else $fatal("Error: WidthSrc: %b.\nAddress: %d\nExpected value: %b\nActual value:   %b", 
                        WidthSrc, A, RDWExp[i], RD);
            
        end
        
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
        //Set storage mode to HW
        WidthSrc = 2'b10;
        
        //Populate halfword intervals with unique values
        for (int i = 0; i < 128; i++) begin
            
            A = (i * 2); WD = i; RDHWExp[i] = i; #10;
            
        end
        
        //Disable WE, and set intial low and high indices
        WE = 0; LowHW = 0; HighHW = 1;
        
       
        //Ensure values are as expected
        for (int i = 0; i < 64; i++) begin
            
            A = (i * 4); #20;
            
            assert (RD[31:16] === RDHWExp[HighHW] & RD[15:0] === RDHWExp[LowHW]) 
            else $fatal("Error: WidthSrc: %b.\nAddress: %d\nExpected upper value: %b\nActual upper value:   %b\n\
                     Expected lower value: %b\nActual lower value:   %b", 
                     WidthSrc, A, RDHWExp[HighHW], RD[31:16], RDHWExp[LowHW], RD[15:0]);
            
            //Increment low and high indices
            LowHW = LowHW + 2; HighHW = HighHW + 2;
            
        end
        
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
        //Set storage mode to byte, enable writing
        WidthSrc = 2'b01; WE = 1;
        
        //Populate byte intervals with unique values
        for (int i = 0; i < 256; i++) begin
            
            A = i; WD = i; RDByteExp[i] = i; #10;
            
        end
        
        //Disable WE, and set intial byte indices
        WE = 0; Byte0 = 0; Byte1 = 1; Byte2 = 2; Byte3 = 3;
        
        for (int i = 0; i < 64; i++) begin
        
            A = (i * 4); #20;
            
            assert(RD[31:24] === RDByteExp[Byte3] & RD[23:16] === RDByteExp[Byte2] & RD[15:8] === RDByteExp[Byte1] & RD[7:0] === RDByteExp[Byte0])
            else $fatal("Error: WidthSrc: %b.\nAddress: %d\
                         \nExpected byte3: %b\nActual byte3:   %b\nExpected byte2: %b\nActual byte2:   %b\
                         \nExpected byte1: %b\nActual byte1:   %b\nExpected byte0: %b\nActual byte0:   %b",
                         WidthSrc, A, RDByteExp[Byte3], RD[31:24], RDByteExp[Byte2], RD[23:16],
                         RDByteExp[Byte1], RD[15:8], RDByteExp[Byte0], RD[7:0]);
        
            //Increment byte indices
            Byte0 = Byte0 + 4; Byte1 = Byte1 + 4; Byte2 = Byte2 + 4; Byte3 = Byte3 + 4;
        
        end
        
        $display("Simulation Succesful!");
        
    end
    

endmodule
