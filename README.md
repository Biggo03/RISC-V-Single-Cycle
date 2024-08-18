# RISC-V-Single-Cycle

This project is a single-cycle implementation of a RISC-V microprocessor, developed using Verilog. This microarchiteecture will implement a subset of the RV32I instruction set architecture.

A schematic of the implemented microarchitecture is available in this repository under "RISC-V Single-Cycle Schematic"

# Supported instructions

| Instruction | Type | Opcode | Description |
|-------------|------|--------|-------------|
| `lw`        |'I'   | 0000011|Load word in rd|
| `sw`        |'S'   | 0100011|Store word in rd|
| `add`       |'R'   | 0110011|Add two registers|
| `sub`       |'R'   | 0110011|Subtract two registers|
| `and`       |'R'   | 0110011|AND two registers|
| `or`        |'R'   | 0110011|OR two registers|
| `slt`       |'R'   | 0110011|Sets if rs1 < rs2|
| `beq`       |'B'   | 1100011|Branches if equal|
| `jal`       |'J'   | 1101111|Jump and link|
| `addi`      |'I'   | 0010011|Add immediate|

# Memory Interface
This design assumes a memory that can be accessed in a single-cycle, and uses both a data memory, and an instruction memory.

# Control Unit
This processors control unit currently contains the following control signals, with the listed functions

| Control Signal | Function |
|----------------|----------|
|RegWrite|Determine if RF is to be written to, active high|
|ImmSrc|Determines how the extension unit is to extend an immediate|
|ALUSrc|Determines B operand ALU is to recieve|
|MemWrite|Determines if data memory is to be written to, active high|
|ResultSrc|Determines what value is to be written back to RF|
|Branch|Determine if a instruction MAY branch|
|PCSrc|Determines if branch/jump is actually to take place|
|ALUOp|Assists in determining ALU operation (further dependant on funct3 and funct7)|
|ALUControl|Determines the ALU operation|


# Main Decoder Truth Table

| Instruction | Op | RegWrite | ImmSrc | ALUSrc | MemWrite | ResultSrc | Branch | ALUOp | Jump |
|-------------|-------|--|--|--|--|--|--|--|--|
|lw           |0000011|1 |00|1 |0 |01|0 |00|0 |
|sw           |0100011|0 |01|1 |1 |xx|0 |00|0 |
|R-type       |0110011|1 |xx|0 |0 |00|0 |10|0 |
|beq          |1100011|0 |10|0 |0 |xx|1 |01|0 |
|I-type ALU   |0010011|1 |00|1 |0 |00|0 |10|0 |
|jal          |1101111|1| 11|x |0 |10|0 |xx|1 |


# ALU

The ALU implements add, subtract, and, or, xor, slt, and sltu. All logical and arithmetic shifts, are handeled by a shifting unit, while all extensions are handeled by an extension unit.

| Instructions | ALUOp | funct3 | {op[5], funct7[5] | ALUControl |
|--------------|-------|--------|-------------------|------------|
|lw, sw        |   00  | x      | x                 | 000        |
|beq           |   01  | x      | x                 | 001        |
|add           |   10  | 000    | 00, 01, 10        | 000        |
|sub           |   10  | 000    | 11                | 001        |
|slt           |   10  | 010    | x                 | 101        |
|or            |   10  | 110    | x                 | 011        |
|and           |   10  | 111    | x                 | 010        |

Note that the ALU control has the ALU perform the following operations:
| ALUControl | Operation |
|------------|-----------|
|000|add|
|001|subtract|
|010|and|
|011|or|
|100|xor|
|101|set less than (slt)|
|110|set less than unsigned (sltu)|

# Immediate Extension, and Shifting Units
The immediate extension unit needs to extend immediates depending on the type of instruction the immediate recieves. The type of extension is controlled by the signal ImmSrc. Note that this extension unit takes advantage of the fact that the most significant bit of all immediates is always held in bit 31 of instr. The following table describes the extension units behaviour.

| ImmSrc | ImmExt | Instruction Type | Description |
|--------|--------|------------------|-------------|
|00|{{20{Instr[31]}}, Instr[31:20]}| I | 12-bit signed immediate extension|
|01|{{20{Instr[31]}}, Instr[31:25], Instr[11:7]}| S | 12-bit signed immediate extension|
|10|{{20{Instr[31]}}, Instr[7], Instr[30:25], Instr[11:8], 1'b0}| B | 13-bit signed immediate extension|
|11|{{12{Instr[31]}}, Instr[19:12], Instr[20], Instr[30:21], 1'b0}| J | 21-bit signed immediate extension|


The shifting unit supports three shifting operations: shift left logical, shift right logical, and shift right arithmetic. The type of shift is controlled by the signal ShftSrc. The following table describes the shift units behaviour.

| ShftSrc | Type of Shift |
|---------|---------------|
|00|Shift left logical|
|01|Shift right logical|
|10|Shift right arithmetic|

