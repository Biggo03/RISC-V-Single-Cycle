# **Contents:**

**Preamble:**

- [Organization](#bookmark=id.9gp0jmvep4mp)  
- [Dates](#bookmark=id.6hrbhwyz2ra3)

**Base Provided by Textbook:**

- N/A

**Initial Additions:**

- [Xor, xori, and sltu](#bookmark=id.smmfzi52ezau)  
- [Shifting Instructions](#bookmark=id.s59xp1got3d2)  
- [U-type Instructions](#bookmark=id.4z82xgmtdxpp)  
  - Lui  
  - Auipc  
- [Variable Width Load and Store Instructions](#bookmark=id.qfq94vblfk8u)  
- [B-type Instructions](#bookmark=id.fuph13qzdd12)  
- [Jalr](#bookmark=id.z2rg1urzs3j0)

**Verilog Coding:**

- [Adder](#bookmark=id.l37m31ayh5v9)  
- [Extend](#bookmark=id.ia629a397esh)  
- [Reduce](#bookmark=id.bhlckku45ewb)  
- [Multiplexers](#bookmark=id.xcl2lubff7vy)  
- [Registers](#bookmark=id.gm8p9is3d9fl)  
- [Register File](#bookmark=id.i4qeoxspxbc2)  
  - Creating signals to hold values  
  - Handling Register Writing  
  - Register Reading  
- [Writing Decoder](#bookmark=id.idq6vg8eikpt)  
  - Initial Design and Changes  
- [ALU](#bookmark=id.ada17fdimk7x)  
  - Intermediate Signals  
  - Zero and Negative Flags  
  - Carry and Overflow Flags  
  - ALUControl Signal Adjustments  
  - SLT Operation  
  - Implementation Issues  
- [ALU Decoder](#bookmark=id.idcmxncoc6ls)  
- [Main Decoder](#bookmark=id.hgxd8rlnmb1j)  
- [Branch Decoder](#bookmark=id.8kg9j3tmccfo)  
- [Width Decoder](#bookmark=id.kn1skz6qwoz2)  
- [Control Unit](#bookmark=id.8all4s32jwdn)  
- [Data Path](#bookmark=id.rxz41wwo6l81)  
- [RISC-V Module](#bookmark=id.6czwya5mtqgt)  
- [Instruction Memory](#bookmark=id.pwj0tpugi7u0)  
- [Data Memory](#bookmark=id.t4ksxgq3s50j)  
- [Top-Level Module](#bookmark=id.2ap3kells87s)

**Testing:**

- [Preamble](#bookmark=id.isebjfopz3pj)  
- [Initial Plan](#bookmark=id.rmiq9m88lxop)  
- [Multiplexers](#bookmark=id.36j1aejrk3h)  
- [Registers](#bookmark=id.c698gjrrz8jo)  
- [Adder](#bookmark=id.m8gnppl52zfu)  
- [Extend](#bookmark=id.k0itvf8dfdde)  
- [Reduce](#bookmark=id.gqlu50okgyev)  
- [Write Decoder](#bookmark=id.ofn6jzn4hpm9)  
- [ALU](#bookmark=id.yhkkqwc0hije)  
- [Register File](#bookmark=id.5i5g5id37cob)  
- [Main Decoder](#bookmark=id.j6c8p62n0shi)  
- [Width Decoder](#bookmark=id.atjoo0tw14ac)  
- [ALU Decoder](#bookmark=id.wg2dgxdt84cm)  
- [Branch Decoder](#bookmark=id.l2jqhcri798)  
- [Data Memory](#bookmark=id.98nz0i806wtt)  
- [Instruction Memory](#bookmark=id.a4xun6t1l88a)  
- [Top-Level](#bookmark=id.r7hsnq7p3sf7)

**Synthesis and Implementation:**

- [Overview](#bookmark=id.e3ectngwo2h)  
- [Synthesis](#bookmark=id.9tdpviw22n8h)  
  - Overview  
  - Synthesis Settings  
  - Utilization  
  - Optimal Timing  
  - Power Consumption  
  - Final Note

**Challenges:**

- [Zero Register in Register File](#bookmark=id.drqv82p1aiav)  
- [Creation of Width and Branch Decoders](#bookmark=id.hdwfo88dcx98)  
- [Determining Verification Strategy](#bookmark=id.gm7lqfdsm6yz)  
- [Test Generation](#bookmark=id.g4few3dcjrbs)  
- [Data Memory Storage Type](#bookmark=id.9jvoc1d7ksha)  
- [Allowing Byte Addressable Loading](#bookmark=id.2fl7ucvd6ni0)  
- [Top-Level Module Testing](#bookmark=id.svlep5aty2es)

**Changelog**

- [Branch Decoder and Branching Logic](#bookmark=id.4iqo85y4fycp)  
- [Width Decoder](#bookmark=id.kaqr7w5d14gc)  
- [Write Decoder Change](#bookmark=id.hgpnylqxzaio)  
- [Register File Register Instantiation](#bookmark=id.ftrvfcl58mp0)  
- [ALU Fixes](#bookmark=id.27qtt12r3r90)  
- [Write Decoder Fix](#bookmark=id.fwhrh8dqhhqk)  
- [Data Memory Writing Fix](#bookmark=id.r25oepl0rfti)  
- [Data Memory Byte and HW Addressing](#bookmark=id.qeqx4iwvfn1q)  
- [Removal of Latches](#bookmark=id.nlgw4d7yagya)

**Key Takeaways:**

- [Testing](#bookmark=id.xb052l8qq84x)  
- [Verilog Coding](#bookmark=id.vi02lxttwq7x)  
- [Documentation Setup](#bookmark=id.407kffv59poq)

**Next Steps**

- N/A

**Preamble:**  
I just want to note some things before beginning the rest of this development log. These include how I plan on organizing the information, as well as how I plan on dating it.

**Organization:**  
I intend to have major sections that are then split into smaller parts, much like this section itself. The main sections I plan on including are:

- Base Provided by textbook  
  - This section acknowledges the starting material provided by the textbook and its authors.  
- Initial additions to the design  
  - Here, I will discuss my approach to implementing instructions not covered in the textbook. These are labeled "initial additions," as I may revisit and expand the processor's capabilities in the future.  
- Verilog coding  
  - This section details the design process for each Verilog module used in the processor's implementation.  
- Testing  
  - This section outlines my methodology for testing both individual Verilog modules and the overall processor design.  
- Synthesis  
  - I will cover the utilization, power, and clock speed achieved through synthesis on the Zynq-7010 development board.  
- Challenges  
  - This section highlights the particularly difficult aspects of the design, explains why they were challenging, and describes the solutions I developed.  
- Changelog  
  - This section will cover any changes I make to the design mid-development.  
- Big Takeaways  
  - A couple things I learned working on the project.  
  - Not exhaustive

**Dates:**  
I will include the date range for each section and subsection, along with any specific dates when changes were made. If a project day is not explicitly mentioned within a range, no work was done on that day.

**Base Provided by Textbook (August 21st):**  
I began by using the single-cycle RISC-V processor provided in chapter 7 of Digital Design and Computer Architecture RISC-V edition, by Sarah L. Harris, and David Harris as a base.

This design included the control signals: RegWrite, ImmSrc\[1:0\], ALUSrc, MemWrite, ResultSrc, Branch, ALUOp\[1:0\], and Jump.

The instructions implemented included: 

Load/Store: lw, sw

Branching: beq, jal

The R-type arithmetic operations included: add, sub, slt, or, and

The I-type arithmetic operations included: addi, slti, ori, andi

**Initial Additions to the Design (August 21st-23rd):**  
I expanded both the control signal logic and the datapath to enable the processor to execute a wider range of operations.

Initially, I planned to implement only a subset of the RV32I integer instructions. However, many of the remaining instructions were relatively straightforward to add, given the existing connections and control signals. As a result, I decided to implement the full set of RV32I integer instructions, as outlined in the appendix of the aforementioned textbook.

**xor, xori, and sltu (August 21st):**  
These instructions were straight-forward to implement, as they didn’t require any change to the data path. 

I added all the above operations to the ALU truth table, and assigned appropriate ALUControl signal values for each of these operations.

**Shifting Instructions (August 21st):**  
When working with shifting instructions, I noted that the immediate field for the I-type variant only uses the lower 5 bits and is treated as unsigned. This differs from other I-type instructions.

Initially, I considered adding a new extension option to handle this. However, I realized that the R-type instructions also use the lowest 5 bits of rs2. To avoid complicating the schematic with additional control signals and multiplexers, I decided to modify the ALU to select the lowest 5 bits of the incoming signal and treat it as an unsigned integer. This approach simplifies the schematic by leveraging the similarity between the I-type and R-type shift operations.

Subsequently, I implemented all shift operations into the ALU truth tables, differentiating them based on their funct3 values and selecting the correct ALUControl signal. Right shifts required additional differentiation using op\[5\] and funct7\[5\].

All I-type arithmetic operations were grouped under the same main decoder control signal values, concluding with the ALUControl signal having a final width of 4 bits and 10 meaningful values.

**U-Type Instructions (August 22nd):**

**lui:**   
The first thing I did was add the U-type immediate extension type in the extension unit truth table, as both U-type instructions I’m implementing use the first 20-bits of instr as the upper immediate, and zero extend the bottom 12-bits.

Then as this is the first instruction I implemented that directly loads an immediate value into a register, I routed a connection directly from the extension unit to the result multiplexer. This of course resulted in a new meaningful value for ResultSrc.

**auipc:**   
The auipc instruction adds an upper immediate value to the program counter (PC), storing the result in a register. The extension unit already handled the required extension, and the previous branch instructions calculated PC \+ imm using the PCTarget signal with an adder separate from the ALU. I only needed to connect the PCTarget signal to the result multiplexer and extend ResultSrc to 3 bits with 5 meaningful values.

**Variable Width Load and Store Instructions (August 22nd):**

I approached the implementation of variable width load and store instructions as a cohesive group due to their similarities.

First, I identified the different width variations needed: byte, halfword, and word sizes, both signed and unsigned. This results in five distinct width options.

I introduced a new 3-bit control signal, WidthSrc, to manage these variations. I assigned 000 to represent word length, the most commonly used size, and designated values for the other widths.

Initially, WidthSrc was computed by the main decoder. However, I later decided to delegate this task to a dedicated decoder. For details on this change, refer to the [**Challenges section \#2**](#bookmark=id.hdwfo88dcx98) and [**Changelog section \#2**](#bookmark=id.kaqr7w5d14gc). The usage of WidthSrc remained unchanged and is described below.

For store instructions, I routed the two least significant bits of WidthSrc to the data memory. This setup ensures that the width of the stored data is determined by these bits, without distinguishing between signed and unsigned. The signal’s two LSBs are constant based on the width, while the most significant bit determines the signed/unsigned nature.

For load instructions, I added a new extension unit, called "reduce," immediately after the data memory. This unit was introduced to handle width determination of fetched data. However, this arrangement later proved problematic, and I plan to either integrate the reduce functionality into the data memory or eliminate the need for a separate reduce unit.

**B-Type Instructions (August 22nd):**  
I implemented the B-type instructions as a group due to their similar functionality and branching requirements.

In the initial design, only the beq instruction was included, so the branch control signal was a single bit, indicating whether beq was active and the zero flag needed to be checked.

Initially, I created a multiplexer logic connected to the main decoder within the control unit. However, I later decided to introduce a dedicated branch decoder unit. For details on this change, see the [**Challenges section \#2**](#bookmark=id.hdwfo88dcx98) and [**Changelog section \#1**](#bookmark=id.4iqo85y4fycp).

In summary, the branch decoder receives a control signal, BranchOp, from the main decoder. It uses this along with funct3 to determine the internal Branch signal, which serves as a select signal for a multiplexer. The decoder then outputs PCSrc, which controls the branching. This adjustment replaces the original Branch control signal used in the textbook design and eliminates the Jump control signal.

**Jalr (August 23rd):**   
Implementing the jalr instruction was an interesting challenge, as it allowed me to leverage and extend the existing datapath circuitry while introducing a new control signal.

The jalr instruction is of I-type, and since the I-type immediate extension was already implemented in the extension unit, no additional changes were needed there. It sets the destination register to PC+4, a signal already used by the jal instruction, so no new additions were required for that part either, apart from ensuring correct control signal values in the truth table.

The new component I added was a multiplexer controlled by a new signal, PCBaseSrc. This signal determines which input is fed into the adder that calculates the PCTarget signal (the jump target address). Unlike jal, which only adds an immediate to PC, jalr adds an immediate to a value in rs1. Therefore, PCBaseSrc selects between PC and the value in rs1, while the adder continues to add an immediate value.

The PCTarget signal is then routed to a multiplexer that selects between PCPlus4 and PCTarget. In this case, it will select PCTarget, completing the jump operation.

**Verilog Coding (August 24th-September 6th):**  
In this section, I will detail the development of all Verilog modules, presented in the order they were created. I used the generic building blocks provided in Section 7.6.2 of the textbook as bases to work from. However, due to the additional features I incorporated into the processor, modifications were necessary.

The modules are written in SystemVerilog within the textbook, requiring adjustments to be compatible with reg and wire types from standard Verilog. While I used the textbook code as a style guide and followed its organizational format for many of the higher-level modules, these implementations are not direct copies. I renamed some modules and made modifications to accommodate new signals and capabilities introduced during the design process.

**Adder (August 24th):**  
The adder module has a and b as inputs, and y as the output. a and b are the numbers to be added, and y is the result. This module was heavily based on the adder found in Section 7.6.2 of the textbook and is used for adders outside of the ALU, where only the result is needed without Carry-in (Cin) or Carry-out (Cout) signals.

**Extend (August 24th):**  
The Extend module has Instr\[31:7\] and ImmSrc as inputs, and ImmExt as the output. Instr\[31:7\] consists of the instruction bits used for extension, while ImmSrc is the control signal that determines how to extend a subset of these bits. ImmExt is the resulting extended immediate.

I followed the textbook's approach by using a case statement to select the result based on the control signal. This method was extended to include all the different extension types defined in the final extension table. An intermediary reg signal is used within the always statement to store the result before assigning it to the output. The input description reflects that only Instr\[31:7\] is sent to this module.

**Reduce (August 24th):**  
The Reduce module has BaseResult and WidthSrc as inputs, and Result as the output. BaseResult is the result fetched from memory that is either reduced or passed through, while WidthSrc is the control signal that determines the width to which BaseResult is reduced. Result is the resulting data.

This module is similar to the Extend module but implements different logic based on the WidthSrc control signal. The WidthSrc signal determines the type of reduction performed on BaseResult, reflecting the varying operations required for different width specifications.

**Multiplexers (August 24th):**  
The multiplexer modules include 2:1 and 5:1 configurations. Each multiplexer has multiple data inputs (either 2 or 5\) and a select input, which determines which data input is passed through to the output. The general structure of the multiplexers is based on the multiplexer code presented in section 7.6.2 of the textbook.

**2:1 Multiplexers:** The implementation uses a conditional operator to select between two inputs, with the select input determining the output.

**5:1 Multiplexer:** This multiplexer extends the same concept to handle five inputs. The conditional operation was adapted to select among five possible data inputs.

In both cases, I parameterized the width of the inputs to allow flexibility, although the design currently only uses 32-bit inputs. The base width is set to 32 bits.

**Registers (August 24th):**  
The Registers module has inputs clock, en, reset, and D, and an output Q. Clock is the clock signal, en enables the register for writing, reset resets the register to store 0, and D is the input data. Q is the value currently stored in the register.

This module is based on the flip-flop with enable from Section 7.6.2 of the textbook. The primary difference is that Q is declared as a reg, while the other signals are declared as wire. Initially, I planned to implement a standard register without enable or reset signals. However, as I developed the register file, I found that adding an enable signal greatly simplified writing to registers, and including a reset capability provided a useful default state.

**Register File (August 24th-25th):**  
**(Changes on September 3rd)**  
Creating this module was a challenge, as it represents one of the largest pieces of synchronous sequential logic I’ve developed (as of August 25th). It required careful consideration of how to efficiently implement register storage and access.

#### **Creating Signals to Hold Values**

I created an array of 32 32-bit reg signals to store the values associated with each register. For most of the registers, I used a generate block and a for loop to instantiate them. The zero register was instantiated separately with unique input signals to ensure it cannot be written to.

Initially, I instantiated each register individually. The change to using a generate block and for loop is detailed in [**Changelog section \#4**](#bookmark=id.ftrvfcl58mp0).

#### **Handling Register Writing**

To prevent updating all registers simultaneously when changing the WD3 signal, I introduced an enable signal, which is set to correspond with the register address (A3). This approach allows only the intended register to be overwritten. The enable signal is 32 bits wide, and I implemented a priority decoder module to activate the correct bit based on the register index.

The zero register's enable signal is hardwired to 0 to ensure it remains unwritable. Although the enable signal is 32 bits wide, this design choice improves code readability and manageability, with only a minor increase in signal width.

#### **Register Reading**

For reading register values, I used an assign statement to directly map the address index to the corresponding output port.

**Writing decoder (August 25th):**  
**(Changes on September 3rd, September 10th and September 12th)**  
This module takes in A  and WE as an input, and outputs en as an output. A is the address of the register that is to be enabled, WE is a signal determining if any bit will be enabled,  and en is a 32-bit signal that is essentially one-hot encoded to the register that is to be written to. 

#### **Initial Design and Changes**

Initially, the module used an always statement to check if A==0, setting the corresponding bit of en to be active. For details on this initial design and its changes, refer to Changelog section \#3.

Originally, the module did not include a WE signal. The addition of this signal and the rationale behind it are discussed in [**Changelog section \#6**.](#bookmark=id.fwhrh8dqhhqk)

To achieve the desired functionality, I implemented an assign statement to left shift the value 1'b1 by A positions. This approach positions the active bit at the index specified by A, contingent on the WE signal being high. If WE is low, the output is set to 0; otherwise, it is assigned as described.

While this approach does allow for the zero register to be “enabled” via the en signal, the zero register does not receive an enable signal due to its specific implementation in the register file. Thus, this design decision does not impact functionality.

Although a 31-bit enable signal could have sufficed, maintaining a 32-bit signal improves code readability and simplifies the use of a single genvar variable when generating registers in the register file. Using a 31-bit signal would require two variables: one for the enable signal and another for the register index.

**ALU (August 29th):**  
**(Change on September 10th)**

This module takes in ALUControl, and two 32-bit inputs, A and B. It outputs ALURestult, and N, Z, C and V. ALUControl is a control signal generated by the control unit to determine the operation to be performed, and A and B are the operands of the operation. ALUResult is the result of the operation, and N, Z, C and V are the flags generated by the operation.

**Intermediate Signals:**

Created two temporary reg signals to store intermediate results: tempResult and Cout, as well as VControl for the overflow flag.

**Zero and Negative Flags:**

Zero flag (Z) is computed using a bitwise NAND operation on ALUResult.

Negative flag (N) is determined by checking the most significant bit (MSB) of ALUResult.

**Carry and Overflow Flags:**

These flags are only relevant for addition and subtraction operations. To simplify flag computation, the MSB of ALUControl was set to 1 for addition and subtraction. An if statement was used to update tempC and tempV flags only when the MSB of ALUControl is 1\. 

Computation for the Carry flag (C) is based on Cout.

For overflow (V), a new signal, VControl, was introduced to determine if the V flag should be set. The SLT operation utilizes this flag.

**ALUControl Signal Adjustments:**

Reversed the original ALUControl encoding for shift operations and arithmetic operations.

Addition was assigned 1000, subtraction 1001, and SLT was given 0101 to align with the subtraction flag for overflow detection.

**SLT Operation:**

The SLT operation involves calculating A \- B, with the result stored in tempResult.

Used VControl to determine if the SLT result should be set based on the overflow condition.

The SLT result is determined by checking if A is less than B after the subtraction, and the result is set accordingly.

#### **Implementation Issues**

There were some implementation issues, but these were related to the design's execution rather than the logic behind it. Details on these issues can be found in the [**Testing, ALU**](#bookmark=id.yhkkqwc0hije) section. There were also some other change made to the module, details can be found in [**Changelog Section \#5**](#bookmark=id.27qtt12r3r90)**,** and [**Changelog Section \#9**](#bookmark=id.nlgw4d7yagya).

**ALU Decoder (August 30th):**  
This module takes in funct3, ALUOp, op\[5\], and funct7\[5\] as inputs and outputs ALUControl. Funct3, op\[5\], and funct7\[5\] are all part of the instruction being executed, and ALUOp is a control signal internal to the control unit generated by the main decoder. ALUControl determines the operation performed by the ALU.

I started by creating a temporary reg signal to hold the value for ALUControl that is computed within an always statement. The always statement uses an exterior case statement based on ALUOp, which has three meaningful values. Two of these values lead directly to either addition or subtraction, associated with S-type, I-type loads, or B-type instructions. The remaining value covers other operations, requiring further decoding based on funct3.

Inside this case block, I added another case statement to handle additional decoding for other operations. Some operations also depend on op\[5\] and funct7\[5\], so I used if statements within this interior case block to determine the ALUControl value.

Finally, I included default assignments to handle unknown cases by setting ALUControl to all don’t-care values.

**Main Decoder (September 1st \- September 2nd):**  
While developing this module, I also created the Branch and Width decoders, which took over some functions previously handled by the main decoder. Details on this decision are in [**Challenges section \#2**](#bookmark=id.hdwfo88dcx98), and the related changes to the main decoder are covered in [**Changelog Section \#1**](#bookmark=id.4iqo85y4fycp) and **[Changelog Section \#2](#bookmark=id.kaqr7w5d14gc)**.

This module takes the instruction's opcode as input and outputs ImmSrc, ResultSrc, ALUOp, BranchOp, WidthOp, ALUSrc, PCBaseSrc, RegWrite, and MemWrite. All outputs are control signals, with signals ending in Op providing input to more specialized decoders.

I began by defining a reg signal with a width of 15 bits (the combined width of all control signals outputted by this module), and used an assign statement to map each control signal to a segment of this larger combined control signal.

Next, I implemented the logic using an always statement. Since all control signals are fully dependent on the opcode, I used a case statement to output the appropriate control signals for each opcode.

I set the default case to 15’bx to facilitate debugging. Note that some control signals have "x" values, as they are not relevant for certain instruction types.

**Branch Decoder (September 2nd):**  
This module takes the instruction's funct3 field, BranchOp, and the N, Z, C, and V flags as inputs. It outputs PCSrc, which is the control signal responsible for selecting the next address to be sent to the PC. BranchOp is an internal control signal generated by the main decoder, while the N, Z, C, and V flags help determine if a branch should occur.

I started by defining a temporary reg type signal. Then, I created an always statement with a full sensitivity list. Within this always statement, I implemented a case statement where the case expression was BranchOp. This case statement had three meaningful cases: two for direct results (jump and non-branching instructions) and one requiring further decoding based on funct3.

For the third case, which deals with B-type instructions, I added another case statement with funct3 as the case expression. This inner case statement set the temporary reg signal to the corresponding flag condition for each branch instruction type. For example, for beq, I set the temporary signal to the Z flag.

In both case statements, I set the temporary signal to 'x' for unknown values.

Finally, I used an assign statement to set the module output to the value of the temporary signal used within the always statement.

**Width Decoder (September 2nd):**  
This module takes the instruction's funct3 field and WidthOp as inputs. It outputs WidthSrc, which determines the width of data in load and store operations. WidthOp is an internal control signal generated by the main decoder.

I began by defining a temporary reg type signal. I then created an always statement with a full sensitivity list. Within this always statement, I first used an if statement to check the value of WidthOp, since WidthOp is a 1-bit signal. The initial if condition handles straightforward cases, assigning a value directly to the temporary signal. The else condition contains a case statement, where the case expression is funct3.

This case statement sets the temporary signal to the appropriate value for WidthSrc based on the funct3 value. The default case of this case statement assigns 'x' to the temporary signal to handle unknown values.

Finally, I used an assign statement to set the module output to the value of the temporary signal used within the always statement.

**Control Unit (September 3rd):**

This module takes in op, funct3, funct7\[5\], and flags N, Z, C and V as inputs. It outputs the control signals ALUControl, ImmSrc, WidthSrc, ResultSrc, ALUSrc, RegWrite, MemWrite, PCSrc, and PCBaseSrc. All inputs that are not flags are portions of the instruction, and the flags are generated by the ALU. The outputs are all control signals that control the data path.

This module is essentially entirely structural. I created three wire signals for the internal control signals used (ALUOp, BranchOp, and WidthOp)I then instantiated each of the previously designed decoders (ALUDecoder, BranchDecoder, and WidthDecoder) with the appropriate signals.

**Data Path (September 3rd):**  
This module takes in clk, reset, ALUControl, ImmSrc, WidthSrc, ResultSrc, ALUSrc, RegWrite, PCSrc, PCBaseSrc, Instr, and ReadData. It outputs WriteData, PC, ALUResult, and flags N, Z, C, and V. Most inputs are control signals, with exceptions being clk, reset, Instr, and ReadData. clk is the clock for the datapath, reset resets the register file and PC, Instr is the instruction, and ReadData is data read from memory. WriteData is the data to be written to memory, PC is the address of the next instruction, ALUResult is the result from the ALU, and the flags are self-explanatory.

I began by creating intermediate signals within the datapath that aren’t inputs or outputs of the module. These included PCNext, PCPlus4, PCBase, PCTarget, ImmExt, SrcA, SrcB, ReducedData, and Result.

Next, I instantiated the appropriate modules with the corresponding signals. I used the textbook's code as a base for organization and naming, but adapted it to fit the slightly different design of my datapath. This involved ensuring that the modules were mapped accordingly with all new signals and paths.

**RISC-V Module (September 4th):**

This module takes in clk, rest, instr, and ReadData, and outputs PC, MemWrite, WidthSrc, ALUResult, and WriteData. Clk is the clock for the processor, and reset is used to reset the register file, ReadData is data read in from the data memory. PC is the program counter, WriteData is data sent to be written to memory (if enabled), and ALUResult is the result of the ALU, but in the context of an output, it’s sent to the address of data memory. WidthSrc and MemWrite are control signals.

I started work on this module by creating a schematic of the overall top level system in order to make it clearer in how to set up the signals being inputs, outputs, or internal. Note that I used the diagram in the textbooks section 7.6 as a base, and added any additional signals new to my design.

Then I just instantiated the datapath and control unit with the appropriate signals.

**Instruction Memory (September 6th):**  
This module takes in a (an address), and outputs rd (readdata). 

I initialized a reg signal called ram, that was an array of 64 32-bit words (to be instruction words). I then used an initial block in order to read in machine code from a given file into RAM. Then an assign statement was used in order to set RD to the value contained in RAM at address A. Within the index used within the assign statement, the value of A is taken as \[31:2\], as to maintain word alignment.

**Data Memory (September 6th):**  
**(Changes made on September 14th and 15th)**  
This module takes in WE (write enable), WidthSrc, A (address), and WD (write data), and outputs RD (read data).

I first created a reg signal array containing 64 32-bit words for memory storage. An always block triggered on the positive edge of the clock (clk) was then established. Inside this block, an if statement checks if WE is active. If so, a case statement based on WidthSrc handles writing data to memory with different widths.

For byte and halfword storage, conditional statements were used to determine the specific portion of the word-aligned address to modify, depending on the last two bits of the address.

This approach was a revision from the initial implementation, as detailed in [**Changelog section \#7**](#bookmark=id.r25oepl0rfti).

For reading data, the logic initially only supported word-aligned addresses but was updated to handle partial word reads in a similar manner to the write logic. This updated read logic, which reads different portions of a word based on the address, is managed by a separate always statement with a full sensitivity list, ensuring continuous updates. Further details on this change can be found in [**Challenges section \#6**](#bookmark=id.2fl7ucvd6ni0) and [**Changelog section \#8**](#bookmark=id.qeqx4iwvfn1q).

**Top Level Module (September 6th):**  
This module takes in clk and reset as inputs, and outputs WriteData, DataAdr, and MemWrite.

This is just the structural model containing all lower level modules, including the instruction memory, the data memory, and the RISC-V processor itself.

**Testing (September 6th-September 15th):**

**Preamble (September 6th):**  
Testing of the system as well as all modules within the system took place after development. The reason for this is the fact that at the time of designing this, I did not have any experience in writing testbenches.

That being said, at the time of writing this, the first versions of each model have been created, and I do want to have some verification of its validity. As such, I will be writing basic testbenches for each module, and learning as I go. Note that I’m not looking for functional coverage, but rather a good indicator that the module works as intended for a reasonable number of cases. 

**Initial Plan (September. 7th):**  
My plan for each testbench is to align its complexity with the design of the corresponding module. For more complex modules, I intend to generate a large number of test vectors using loops to iterate through these vectors. Simpler modules, such as flip-flops (FFs) and multiplexers (Muxes), will be tested by manually setting signals and using assertions to verify that the outputs match expected values.

For the more complex modules, I’m planning to use python in order to generate test vectors, as well as the expected outputs of said test vectors. This will allow me to do some very basic random testing, as well as easily create directed tests for corner cases.

The Python script for generating test vectors will include functions tailored for each module. This design choice will enhance organization by consolidating test vector generation into a single script and allow for reusability if modules share similar functionalities.

**Multiplexers (September 7th):**  
Given their relatively simple design, multiplexers primarily depend on the select signal. There is no indication that varying data inputs would alter the module’s functionality.

Therefore, I plan to conduct only a few basic assertions. These will verify that the output corresponds to the correct input value based on the selected signal and ensure that changes in the input value correctly propagate to the output when it is selected.

This limited testing is appropriate due to the simplicity of the multiplexers. It is also worth noting that these modules were designed based on the “Digital Design and Computer Architecture RISC-V Edition,” which minimizes the likelihood of errors.

**This module had no issues revealed through this test.**

**Registers (September 8th):**  
For testing this module, I aimed to verify three key functionalities: the correct operation of the reset, the enable signal, and data propagation.

I began the testbench by creating an always statement to generate a clock with a 10ns cycle. An initial block was then set up to initialize the clock, reset, enable, and data (D) signals. Following this, I developed test cases to ensure the module operated as expected.

The first set of assertions involved enabling the signal and checking if the data propagated correctly. Next, I disabled the enable signal to confirm that the data did not propagate. Finally, I asserted the reset signal to verify that the register was properly reset.

**This module had no issues revealed through this test.**

**Adder (September 8th):**  
I wanted to ensure the following worked as intended: adding small numbers, adding 0, adding large numbers, and adding negative numbers.

I created a single test case for both small numbers, and addition of 0\. I created two test cases for large numbers, and three test cases for negative numbers (including addition with 0).

**This module had no issues revealed through this test.**

**Extend (September 8th):**  
This was the first module where I employed Python to automate the generation of test vectors. Although verifying each mode based on the control signal ImmSrc could have been accomplished with directed testing, I used this opportunity to familiarize myself with the bitstring library in Python, which I plan to use for generating test vectors for the initial set of testbenches in this project.

The Python script was developed to include several functions: one to convert Verilog-style indexes to Python-style indexes, another to generate the extended immediate based on the most significant bit (MSB), length of extension, and the immediate value itself, and a third to create the test vectors and write them to a file.

Test vectors were produced by slicing the instruction and extending the result according to the control signal ImmSrc.

After generating the test vectors, I created a self-checking testbench in SystemVerilog. This testbench used a while loop to read from the file until it was fully parsed. The %fscanf method was employed to read the data into signals used to drive the DUT, as well as a signal for the expected result. I verified that the correct number of arguments were read and then used assertions to compare the actual output with the expected output. In case of errors, I included a message displaying all signal values. Finally, I printed a message indicating a successful simulation and closed the file.

This structure will be the basis for all testbenches using imported test vectors, and I will refer to this section whenever this format is employed.

**This module had no issues revealed through this test.**

**Reduce (September 9th):**  
The testing for this module followed a process similar to that of the extension unit, though it was notably simpler to implement. This was due to several factors: I was already familiar with the bitstring library, I had previously created functions for handling repetitive operations, and the reduction operations were less complex. Additionally, since the Reduce module performs functions analogous to the extension unit, I was able to reuse the SystemVerilog testbench with minimal modifications.

When developing the Python script for test vector generation, I focused on consolidating repetitive tasks into functions to enhance reusability. I also adjusted the script to handle file operations more efficiently by moving these tasks out of the generation functions and into the main script.

**This module had no issues revealed through this test.**

**Write Decoder (September 9th):**  
I tested this module using only SystemVerilog, as it has a very limited number of inputs and a straightforward output. To test it, I created a for loop that iterates through each possible address value. For each address, I set the expected output to be 2^i (where i is the address). This approach is designed to activate the ith bit of the signal. I then asserted that the actual output matched the expected value.

Additionally, I inspected the waveform to verify correctness. The waveform displayed a staircase pattern of active bits, as anticipated, making it relatively easy to confirm the module's functionality.

**This module had no issues revealed through this test.**

**ALU (September 9th \- 10th, September 12th):**  
I first used the python script to generate test vectors. This involved creating different random integer ranges for A and B in order to get closer to testing edge cases. The ranges were labeled as: “Random”, “High”, “Negative” and “Zeros”, with the zeros range only being \[0,1\], in order to ensure operations worked with 0\. After that, I used the bitstring library in order to predict the operation result, as well as the flags. This was then all written to a test vector file.

The testbench was essentially identical to the extend and reduce testbenches, but just with more variables involved, meaning longer error messages.

Note that I came back to this module and testbench in September. 12th. The carry flag was being incorrectly calculated for subtraction in both the python script, and the code itself, so I needed to fix it. This is because I initially wasn’t clear on how it was to be calculated when doing subtraction. I fixed the issue, having python calculate the correct  C flag, and ensuring that the ALU module gave the same result. This required me to use a conditional statement based on if addition or subtraction was occurring to flip the Cout signal. This is due to the fact that the subtraction C flag is calculated as the complement of Cout.

**Problems:**

**Problem 1:** Final signal assignment was to incorrect uninitialized value  
**Solution:** Assigned to correct signal

**Problem 2:** Incorrect calculation of the carry flag in SLTU. Before fix C flag was set when Cout \== 0  
**Solution:** Simplify expression to use A \< B rather than using a carryout value

**Problem 3:** VControls value was calculated outside an always block as a wire, in order to calculate an intermediate signal within the always block. Means wire signal wasn’t updated to be used within the block.  
**Solution:** Turn VControl into a reg type signal, and calculate only right before needing to be used within the always statement.

**Problem 4:** Arithmetic shift right was performing logical shift right  
**Solution:** Cast A as a signed type when calculating shifted result

**Register File (September 10th):**  
I created this testbench entirely in SystemVErilog without importing test vectors imported from a text file. The reasoning behind this is that the functionalities that need to be tested don’t need to be tested with an exhaustive set of values for my purposes.

Although it would have been possible to create a Python script to generate randomized values for A1, A2, A3, WE3, and WD3 to test a wide range of inputs, this level of complexity was not necessary for my testing goals. Instead, I focused on creating a few directed test cases to verify that the module worked correctly for relatively simple operations.

I therefore just had a couple of directed cases to ensure that certain functions worked correctly. These cases covered: ensuring all registers held 0 after reset, ensuring that a register was written to when WE3 was enabled, ensuring a register wasn’t written to when WE3 was disabled, and ensuring that the zero register could not be written to.

The reading capabilities needed to be functioning correctly for the other tests to have an output to check, so they were effectively tested in every test case.

**Problems:**

**Problem 1:** can’t have an array of reg types (the type the RegisterArray was at beginning of testing)  
**Solution:** Turn it into wire type

**Problem 2:** WE didn’t work  
**Solution:** Actually include WE3 in the write decoder module. Note that I already tested the write decoder module, however seeing as how the rf testbench passed all tests after making the change, I did not see the need to retest it.

**Main Decoder (September 11th):**  
I developed the testbench for the Main Decoder entirely in SystemVerilog, as its only input is the opcode. This was my first experience using tasks in SystemVerilog, and they significantly expedited the testing process by simplifying the verification of numerous outputs.

I created a task to set the expected outputs, which streamlined the process of defining expected values. Instead of using multiple assignment statements, I could now input the expected values as function arguments. Additionally, I developed a task to compare the expected outputs with the actual outputs produced by the Main Decoder. This task provided detailed information by printing the opcode where the error occurred, along with the expected and actual values.

To test the decoder, I set the opcode to each valid value and verified that the outputs were correct. I also included a test case with an invalid opcode to ensure that the output was as expected (32’bx).

**Problems:**

**Problem 1:** The ImmSrc value didn’t match expected value for U-type instructions  
**Solution:** This was due to me changing the U-type instruction in my verilog code without fully documenting it. The output was actually correct, I just didn’t change my documentation for it. So this actually led to a fix in my documentation, rather than the actual module. This was caught as the expected outputs were based on my documentation

**Width Decoder (September 12th):**  
I created the testbench for the Width Decoder entirely in SystemVerilog. Initially, I used a for loop to test all possible values of funct3 when WidthOp was set to 0, to ensure that the correct output was consistently produced. I then created an array of valid funct3 inputs along with one non-valid funct3 value. Correspondingly, I constructed an array with the expected outputs for each funct3 input.

Using another for loop, I verified that the DUT produced the correct results based on the value of funct3. The use of arrays simplified the process, as it allowed me to define all input-output pairs beforehand and then apply them within the loop, reducing repetition.

Testing all values of funct3 when WidthOp was 0 might not have been strictly necessary, especially given that my goal is not to rigorously verify the system. However, it was straightforward to implement and provided additional confidence in the module's functionality.

**Problems:**

**Problem 1:** Output for all WidthOp \= 0 operations was set to 3’bx, when it should’ve been 3’b000.  
**Solution:** set output to correct value.

**ALU  Decoder (September 12th):**  
This testbench was designed entirely in SystemVerilog and posed a challenge due to the complex range of inputs. The ALUOp signal has two values that lead directly to specific outputs, while the final valid ALUOp value results in operations dependent on funct3, and sometimes on funct7\[5\] and/or op\[5\].

For the first two ALUOp values, I employed direct assertions to verify that the outputs matched the expected values.

For the more complex ALUOp value, which has dependencies on funct3, funct7\[5\], and op\[5\], I took a more detailed approach. I created an array of expected outputs indexed by funct3, and another array containing all possible combinations of op5 and funct7b5.

A for loop iterated through each value of funct3 with ALUOp set to the value of interest. If the output did not depend on op5 or funct7b5, it was compared directly to the expected output from the array.

If the output did depend on op5 and funct7b5, a nested for loop was used to iterate through all possible combinations of these signals. Within this loop, op5 and funct7b5 values were set accordingly, and an if statement was used to determine the expected output based on these values. The array entry for the current funct3 value was updated with this expected output and then compared to the actual output.

For funct3 \= 000, the value at index 0 was updated during each iteration of the inner loop, reflecting the combinations of op5 and funct7b5.

To manage verbosity and streamline error reporting, I created a task responsible for printing error messages.

**Problems:**  
**Problem 1:** Didn’t actually assign output to the temporary reg signal  
**Solution:** assign the output to the temporary reg signal

**Branch Decoder (September 12th):**  
This testbench was developed entirely in SystemVerilog. The BranchOp signal has two values that directly lead to specific outputs, so these were tested first using direct assertions.

To test the more complex cases, I used a queue containing all valid values of funct3 and iterated over it with a foreach loop. Within this loop, I set funct3 to the current value and then initiated another for loop to test all possible combinations of flag values. This inner loop employed a case statement to produce expected outputs, followed by assertions to ensure that the actual output matched the expected output.

To facilitate assertion checking, I created a task that compared the actual and expected signals. This task also generated detailed error messages, including all relevant signal values, if an assertion failed.

**This module had no issues revealed through this test.**

**Data Memory (September 14th):**  
This testbench was made entirely in SystemVerilog, and was quite involved considering the different storage types. Each type of addressing followed the same testing procedure. First, the data memory was populated with unique values at each appropriate interval (for words, each word was unique, for bytes each byte was unique). While this occurred, an array of expected values for each interval was populated with the same unique values. After this each address was checked to ensure that the data was stored correctly. This worked for words, halfwords, and bytes, as the datamem had been updated s.t it could load and store variable width data. The big difference between testing for each was that for words the address was always a multiple of 4, half-words always a multiple of 2, and bytes went through every address.

**\*\*\*\*\*\*\*INITIAL TB, CHANGES MADE BASED ON DATAMEM CHANGES\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\***  
For halfwords and bytes, each halfword or byte interval needed to be checked. In order to achieve this, indices relating to one of the sub-portions of the word were created, and used in order to index the expected array. (for example, in HW checking, the array was 128 long, and indices for both lower and upper HW incremented by 2 for each address). The expected values were checked against the portion of the word they were related to.  
**\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\***

**Problems:**

**Problem 1:** Byte and HW storage working incorrectly  
**Solution:** This solution was more in depth, so I listed it in [**Changelog** **Section \#7.**](#bookmark=id.r25oepl0rfti)

**Instruction Memory (September 14th):**  
This testbench was made entirely in SystemVerilog, and was relatively simple. I created input and output signals for the DUT, as well as a RAM array containing the same data as the RAM array in the instruction memory. I then looped through all addresses and ensured that the result from the instruction memory matched that of the external memory.

**There were no issues with this module.**

**Top-Level (September 14th \- September 15th):**  
This was quite a challenge, so I covered my testing process in [**Challenges section \#7**](#bookmark=id.svlep5aty2es). But I will go over the problems that were uncovered while working on this.

**Problems**

**Problem 1:** Initially it was not running any instructions. The problem was that in the riscv module, the output PC was listed as 1-bit in length.  
**Solution:** Make PC the appropriate width

**Problem 2:** The variable width loads and stores were not working correctly, this is what prompted me to look into the data memory module and make changes.  
**Solution:** Fix the data memory module, ensuring it could handle both variable width loads and stores.

All other problems were related to creating the assembly programs that were to be made, and assembly programming is not a focus of this project, so I will be leaving it out for now.

**Synthesis and Implementation (September 16th-September 20th):**

**Overview:**  
As I didn’t have any experience with synthesis or implementation, this portion of the project was particularly challenging. Initially I was planning to base my performance metrics off of both synthesis and implementation, however as implementation speed can be very variable depending on implementation settings, and optimizing the actual implementation was never my goal with this project, I’m going to leave it at synthesis. 

Another reason I’m basing the result on only synthesis is that there are only 50 output pins on my particular FPGA, and my top level module has 65 outputs. I could just run implementation on another board, however there’s no compelling reason for me to do so. I could likely make the implementation work by making the output interface with some internal pins within the FPGA, however there is again no compelling reason for me to do this at this time.

**Synthesis:**

**Overview:**  
The first thing to mention is that the synthesis timing results differed depending on which RISC-V assembly program was loaded in. My assumption is that if no signals are sent through a given set of hardware due to an instruction not being run, that signal path is not considered in the final timing analysis, as it is not actively involved at any point while the system is running. I could do analysis to find the critical path myself, and ensure that instruction is included in the test program, however I believe that the better way to go about this is to include all instructions to ensure the critical path is run. This is due to the fact that I could be wrong, and make an error in determining the critical path, and  not only that, but the synthesized hardware schematic is substantially different from the RTL schematic, so there could be automatic optimizations that render my analysis invalid.

Therefore I created a RISC-V assembly program (riscvprogram\_6.txt) that was essentially a combination of all the other RISC-V programs I created prior. I made some changes to ensure each register was also accessed, as well as to allow the program to be compatible with my testbench. Therefore testing this program tests all instructions in one go.

This required extending the instruction memories capacity, however that is not really an issue.  
**Synthesis settings:**  
The synthesis settings were all set to Vivado’s defaults, this was to ensure that the results would be easily compared with later iterations of the design without needing to edit any settings.

**Utilization:**  
The utilization of the device was as follows:

| Module | LUT’s (17600) | Registers (35200) | F7 Muxes (8800) | F8 Muxes (4400) | Bonded IOB (100) |
| :---- | :---- | :---- | :---- | :---- | :---- |
| Top | 1776 (10.1%) | 1024 (2.91%) | 367 (4.17%) | 64 (1.45%) | 67 (67%) |
| rvsingle | 1562 (8.875%) | 1024 (2.91%) | 277 (3.15%( | 32 (0.723%) | 0 (0%) |
| Dmem | 149 (0.847%) | 0 (0%) | 64 (0.73%) | 32 (0.723%) | 0 (0%) |

Note that the IOB’s are only due to the top level module having output ports in order for testing, the design does not inherently require these IOB’s.

To elaborate on the LUT’s, overall 1648 (9.36%) were used for logic functions, whereas 128 (0.727%) were used as distributed RAM (this was entirely within the dmem module)

**Optimal Timing:**  
With the setup as explained above, the design was able to achieve a maximum clock speed of 64.935Mhz, which is just over half of the maximum clock speed possible on the targeted FPGA board. This meant a clock period of 15.4ns, and allowed for a slack of 0.056ns, meaning that the clock speed could be improved slightly with no affect on performance.

**Power Consumption:**  
The total on chip power was given as 0.18W. 49% of power dissipation was dynamic, while the remaining 51% was static.

The dynamic power further broke down as follows:

| Process | Power Consumption |
| :---- | :---- |
| Clocks | 0.006W (7%) |
| Signals | 0.025W (29%) |
| Logic | 0.019W (22%) |
| I/O | 0.036W (42%) |

Note that the percentages given are percentages of dynamic power, not total power.

**Final Note:**  
As this is synthesized to fit onto an FPGA, as far as I can tell they don’t mean all that much by themselves (besides utilization). However, as I am planning to continue working on this project, these numbers will provide a good baseline for me to measure future PPA against as the design evolves.

**Challenges:**

**\#1 Zero register in register file (August 25th):**  
Deciding how to implement this was a challenge, as there were a couple of things that I wanted for it:

- Retain the constant value of 0  
- Be non-writable  
- Not use an actual register module

I wanted it to retain a constant value of 0, as that is its purpose, and that is the same reason I wanted this register in particular to be non-writable, so that it would retain this value. Because it doesn’t need to be written to, I believed it would help the hardware complexity to not use a register module for it, as that requires handling multiple input signals to determine if it could be written to, as well as hardware to reset the register. None of these are needed for this register, as it is not meant to be written to.

That being said, including the register module increases the overall readability of the code, as some controlling signals wouldn’t need to have an offset index (i.e the register array and enable signal). If I made a register for it, I could simply design the enable and reset signals s.t that it is always set to 0, and can’t be written to.

My final decision was to just instantiate a register module for it, and instantiate it with the enable signal being set to 0, and the WD port being set to 32’b0.

For reading I considered hardwiring the result to return 0 rather than accessing the zero register itself. But I felt that the way it’s implemented, there should be no case where it doesn’t return 0, so I read from the zero register the same as any other register. It may have even increased hardware complexity, as it would’ve required a conditional operator, or some other control statement to change the assignment based on the value of A.

**\#2 Creation of Width and Branch Decoders**   
**(september 1st \- September 2nd):**

As I was implementing my main decoder in Verilog, I realized that I could greatly simplify its design by creating two additional decoders. One to deal with the width of load and store instructions, and the other to deal with the branch condition. Note that prior to this, both branching, and width logic was contained within the main decoder.

The main reason that this occurred to me was because of the need to nest case statements within my main decoder code, and I thought that by splitting these two off, I could make my code a lot easier to read. It also occurred to me that it made the main decoder more general than I would have liked, as by dealing with width and branch decision making, it needed to deal with the funct3 portion of the instruction, which is only needed for these instructions.

By making these decoders separate, the main decoder would just need to deal with the opcode, making it easier to understand both in general, and in how the code is written. After this change, I was able to combine S-type, I-type loads, and B-type instructions into their own sections within the main decoder truth table, greatly improving its readability.

It also creates a solution for a problem I hadn’t run into at the point of making this decision. The extra branch logic required using control signals created by the main decoder.

By creating a branch decoder, I can handle the branch logic using flags as inputs directly within this decoder. Before making this decision, the branching/jumping logic was determined by using an OR gate, a multiplexer, and the Branch and Jump control signals. By having a decoder dedicated to branching logic, I can deal with all of this logic within a black box rather than having to deal with it within the control unit directly. 

**\#3 Determining Verification Strategy (September 7th):**  
This was definitely the most challenging part of the project, at least as of September 7th. The reason for this is my lack of experience in formal verification, which left me wondering about how I was to verify a relatively complex design with said lack of experience. 

Initially I wanted to learn how to design a relatively sophisticated testbench using SystemVerilog right from the get go. This would consist of all the components of a layered testbench, including all the components mentioned in the first chapter of SystemVerilog for Verification”, by Chris Spear and Greg Tumbush. This however was impractical considering that I would have needed to essentially read the entire textbook, and then applied everything I learned from it within a very short span of time. This approach may have been practical had I begun working through this textbook at an earlier time, however, as of September 7th, I’ve only completed 3/12 chapters.

Because this was not possible I considered different ways I could verify my modules without the same level of sophistication. I considered two approaches that differed slightly: individual testbenches for each individual module, and creating a base testbench that created functions/tasks that would be commonly used in testbenches for each individual module. So the only real difference was the creation of a base testbench.

I wanted the base testbench to introduce some reusability, and decrease my overall workload, as if it shared the most common functions, I wouldn’t have to recreate them with each testbench. However, as  I began work on the base testbench, I realized I was still a bit out of my depth with my current knowledge. 

This was unfortunate, however it’s not like there aren’t upsides to individual testbenches. The main upside being that it gives me more experience in the SystemVerilog syntax, as well as strategies for verifying different kinds of components. This is likely to make it easier to learn how to develop more sophisticated testbenches in the future.

The rest of my rationale behind verification can be found in the verification section.

**\#4 Test Generation (September 8th):**  
As at the time of generating tests, I didn’t have experience with SystemVerilog, or generating constrained-random stimulus, so I decided on two methods of generating test cases and expected outputs. These were directed tests created by setting signal values and asserting the expected result in the SystemVerilog testbench directly, and generating a test vector file using python.

The directed test creation was relatively easy, and what I used for simpler modules like the multiplexers, adder, and register. However I did want to generate more varied stimulus for some of the other modules. I did this for modules where generating the expected output was either very tedious, or where I felt a larger number of tests was warranted.

The main challenge came from learning the library bitstring in order to more easily manipulate bits, and get binary outputs for different arithmetic operations. It took me about two hours to learn how to use this library and generate test vectors for my first module using this method, and I expected it to take less time as I became more familiar with it.

Using this method also forced me to become more comfortable with handling files in SystemVerilog, as well as automating application of test signals and checking of the result.

**\#5 Data Memory Storage Type (September 14th):**  
This is a problem I came across while making the testbench for the datamem module. Essentially the memory wasn’t being updated appropriately when either HW or byte storage modes were selected. This was a challenge as it wasn’t immediately clear to me why this was happening. More details can be found under [**Changelog section \#7**](#bookmark=id.r25oepl0rfti)**.**

**\#6 Allowing Byte Addressable Loading (September 15th)**  
After already creating essentially the whole system, and doing my final tests with assembly code instructions I ran into a really big problem, loading bytes and halfwords from non-word-aligned addresses. This was due to not fully understanding how loading bytes and halfwords worked at the time of creating the microarchitecture. Because the datamemory can only read out word-aligned addresses, it was not possible to actually load either bytes or halfwords. So although the “Reduce” unit could reduce the effective width of any word, what would be loaded was always the lower part of the word regardless of the actual address given. For example using lh from address 42 would give the lower halfword of the word stored at address 40\.

Because of this I needed to go back in and rework my datamemory so that it could access halfwords and bytes on half-word and byte aligned addresses. This also required a rework of the datamem testbench.

Because of this change, there was an opportunity to throw the functionality of the reduction unit into the datamemory, however as it would effectively be the same code I decided to keep them separate to improve the readability of both modules. However as it is possible, I may make this change in the future

The changes made to datamem to support this can be found under [**Changelog section \#8**](#bookmark=id.qeqx4iwvfn1q)**.** Note that the 

**\#7 Top-Level Module Testing (September 15th):**  
The top level module was very difficult to test, as I essentially needed to confirm that every instruction worked as intended. I used the same strategy used in the textbook “Digital Design and Computer Architecture: RISC-V Edition” by David and Sarah L. Harris. This was to write a program in RISC-V assembly and ensure that it made a final write to memory as expected. I used the testbench provided in chapter 7 of the book, as well as the test program they provided to test some of the instructions. The rest of the instructions I tested by creating assembly programs myself. I still used the same testbench, with a small change to allow reading and writing to memory without triggering the final correctness check. This meant that I needed to create programs that used all the instructions, and resulted in a final memory store of 25 to memory address 100\.

This was quite difficult to do, as I needed to ensure that the program would not be able to store the correct number (25) if any instruction did not work correctly. To even out the workload, and make it easier to find the root of the problem I created 5 separate programs that tested different subsets of the instructions. I will go over the problems that were found, and the solutions in the **Testing** section.

**Changelog:**

**\#1 Branch Decoder and Branching logic**   
**(September 1st \- September 2nd):**

Initially the design dealt with branching using a multiplexer, flag values, and an OR gate directly within the control unit. It did this using internal control signals Branch and Jump, which were generated using the main decoder, and used to determine PCSrc, which is what actually determined if a branch occurred.

The new design deals with all branching logic within a new branch decoder module. This module takes in funct3, flags, as well as BranchOp from the main decoder. It outputs only PCSrc.

It uses an internal signal called branch (repurposed now), which acts essentially as a select signal for a multiplexer. The multiplexer has 8 inputs, one for no branch, one for jumps, and 6 for each branch condition. The output of this multiplexer is PCSrc.

The reason for changing this can be found under [**Challenges section \#2**](#bookmark=id.hdwfo88dcx98).

The only section affected was B-type Instructions, under Initial changes on page 3\.

**\#2 Width Decoder (September 1st \- September 2nd):**

The control signal WidthSrc was initially computed using the main decoder. The reason for changing this computation to be dealt with by its own decoder is explained fully in [**Challenges section \#2**.](#bookmark=id.hdwfo88dcx98)

The new design takes a control signal, WidthOp from the main decoder, as well as funct3 in order to determine the value of the control signal WidthSrc. WidthOp is dependent on the opcode, and will be used similarly to ALUOp. Because the width is only dependent on funct3 for variable width load and store instructions, WidthOp must only be 1-bit (one value for variable width load and stores, one value for everything else). The decoder will then either set the width to one word, or determine what it is to be based on funct3.

The only section affected by this change was Variable Width Load and Store Instructions on page 3\.

**\#3 Write Decoder change (September 3rd):**

I changed the verilog code for the write decoder to be more efficient. This change included removing an always statement, along with an if-statement that checked if A==0. This was possible because the 0th bit of enable isn’t set as an input to the zero register, so it can’t be enabled regardless. The new code is an assignment operator that assigns en to 1’b1 \<\< A, resulting in the “hot” bit being in the proper location.

I made this change because I was reviewing my code, and realized that what I did was overkill, and could be achieved in a much simpler way, so I made the change. I also had a check for A \== 32, which isn’t even possible considering A is 5-bits, which really made me reevaluate how I implemented this module.

**\#4 Register File Register Instantiation (September 3rd):**  
Initially I instantiated each register individually, giving each register the appropriate name according to the RISC-V architecture. However, when I learned about the generate block, I realized I could substantially reduce code within this module and retain the same functionality, so I made the change. Note that to retain clarity on the purpose of each register, I listed the register categories, as well as the register numbers associated with each category. 

**\#5 ALU Fixes (September 10th, September 12th):**  
Problems were found with the ALU during testing. The problems and their solutions can be found in the [**Testing, ALU**](#bookmark=id.yhkkqwc0hije) section. The entry for ALU design has been updated, and refers to both this entry, and the testing section where the changes are explained. I also made changes to the ALU code on September 12th, however these were largely to increase simplicity of the code, and did not affect the overall design.

**\#6 Write Decoder Fix (September 10th):**  
When testing the register file, it was brought to my attention that I did not include a WE signal for the write decoder module, meaning that it always enabled the inputted addresses register for writing. This was an easy fix, I just added a WE input signal to the write decoder, and used a conditional operator to assign 0 to the output whenever WE was not enabled.

**\#7 Data Memory Writing Fix (September 14th):**  
Initially the data memory was designed to store halfwords and bytes using HW aligned and byte aligned addressing (for example Address\[31:1\] for HW aligned). However this didn’t work as intended, as the RAM memory array stores a 32-bit word in each index. This meant that by indexing using \[31:1\], I would only be accessing the word corresponding to \[31:2\], or I would just be accessing an invalid point in memory. The intended action is to select either the upper or lower portion of a word, and that’s based on Address\[1\]. So I used either an if statement (HW) or a case statement (byte) in order to select the right portion of the word to write to. These conditional statements were based on the 2nd last bit (HW) or last 2 bits (byte). For example, if Address\[1\] \== 0 for HW addressing, then the HW is to be stored in the lower half of the word. 

This fixed the problem, as the word was first accessed using word-aligned addressing, and after this word was retrieved, the appropriate range of bits were changed accordingly.

**\#8 Data Memory Byte and HW Addressing (September 15th):**  
Initially the data memory module only read out words along word aligned boundaries. This was an issue, as this processor was to support loading both bytes and halfwords. The fix was essentially the same as that made under [**Changelog section \#7**](#bookmark=id.r25oepl0rfti). To put it shortly, I needed to change the reading logic s.t it read the full word of the word-aligned address, and then make use of the last two bits in order to determine which section of the word to actually read. More about this change can be found in [**Challenges section \#6**](#bookmark=id.2fl7ucvd6ni0)**.**

**\#9 Removal of Latches (September 17th):**  
I just went through the design and removed latches from the ALU module, and the datamem module. The latches in the ALU module included the reg signals: Cout, TempV, and TempC. Cout was given a value for every case by just appending it to the end of all TempResult assignments. TempC and TempV were just given default values of 0\. This shouldn’t affect anything, as the only time flags are used is in branching. The latch in datamem was the TempRD value, and I made it so that any undefined WidthSrc signal will lead to TempRD being assigned to X.

**Key Takeaways:**

Overall I learned a lot about the FPGA design flow, and designing digital systems. However there are a couple mistakes that I made, both in my planning, as well as my implementation that were really big learning moments for me.

**Testing:**

This was an error in planning on my part. Designing every module and then testing them after made it harder to understand the initial modules function and code while creating the tests themselves. Having the development log, and developing them relatively close to testing was helpful, however either designing the tests/testbench before development, or immediately afterwards likely would’ve sped up the debugging and test development process.

It also would’ve been a good idea to create a verification plan for each component before designing it.

**Verilog Coding:**  
The biggest mistake I made coding wise was in respect to the ALU, and trying to use a value updated concurrently within an always block, I’ll definitely be keeping that in mind in the future. Another smaller mistake with coding had to do with the arithmetic shift, I now know that a value must be declared as signed for an arithmetic shift to work as intended. 

I also learned when testing the datamem module how addressing memory in Verilog works. More details can be found under [**Changelog section \#7**](#bookmark=id.r25oepl0rfti) and [**Challenges section \#5**](#bookmark=id.9jvoc1d7ksha).

Another simple mistake I made was with the sensitivity list in the datamem module. This issue arose when I was making datamem able to load variable width data. I initially put the read logic in the same always statement as the write logic, however the write logic is only supposed to trigger on a rising clock edge, whereas the read logic is meant to be updated constantly. This caused an issue with loading the proper words, and it took me a while to figure out that the problem was simply with the sensitivity list. I put the read logic in a separate always statement, with a full sensitivity list, and it fixed the problem.

**Documentation Setup:**  
There are a couple things I would change in how I documented my project. The first being the setup of my truth tables. Next time, I’ll likely try to group signals of the same width together, to make it easier and clearer when transferring over to actual HDL code. I would also try to think of ways to optimize operation codes before setting the values, as this would save me time in changing things later on, but that’s somewhat of an aside. 

As for the actual development log, I’ll want to find a way of documenting that makes it simpler to make changes to previously completed sections. Perhaps retaining only the final implementation in the actual section, and relegating any changes to only be mentioned within the change log would be a better strategy. In this way the changes can be referenced without needing to rewrite and re-explain parts within the main section.

**Next Steps:**  
I plan on calling this stage of the project complete at this time, however I do plan on continuing work on a pipelined processor using this as a base. I’m creating a separate repository to do this, primarily because this particular document, as well as the current repository is named “Single-Cycle”, and the documentation is beginning to get very large and hard to keep track of. By moving to a new repository, as well as a new development log I’ll be able to achieve a couple of things. Those being simpler documentation, and retention of the current stable design of the single-cycle processor. I can use this version for direct comparison, as well as implementation should I choose to actually implement it on an FPGA. 

The documentation style I chose to use for this project was very much based on incremental development, as I had sections going from one thing to the next. This made the document very rigid, and increased the time needed to make changes if needed. I intend to refine the documentation style as I move on to the next iteration of this project.

I plan on improving the processor by extending it to handle interrupts, pipelining it into 5 stages, adding branch prediction, and creating a memory hierarchy controlled by a memory controller. I may want to add more features as I continue development, however as of now those features provide a sufficient start.   
