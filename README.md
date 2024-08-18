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
|lw           |0000011|1 |000|1 |0 |01|0 |00|0 |
|sw           |0100011|0 |001|1 |1 |xx|0 |00|0 |
|R-type       |0110011|1 |xxx|0 |0 |00|0 |10|0 |
|beq          |1100011|0 |010|0 |0 |xx|1 |01|0 |
|I-type arithmetic ALU|0010011|1 |000|1 |0 |00|0 |10|0 |
|I-type shift ALU     |0010011|1 |100|1 |0 |00|0 |10|0 |
|jal          |1101111|1 |011|x |0 |10|0 |xx|1 |


# ALU

The ALU implements add, subtract, and, or, xor, slt, sltu, sll, srl, and sra. All extensions are handeled by an extension unit.

| Instructions | ALUOp | funct3 | {op[5], funct7[5] | ALUControl |
|--------------|-------|--------|-------------------|-------------|
|lw, sw        |   00  | x      | x                 | 0000        |
|beq           |   01  | x      | x                 | 0001        |
|add           |   10  | 000    | 00, 01, 10        | 0000        |
|sub           |   10  | 000    | 11                | 0001        |
|slt           |   10  | 010    | x                 | 0101        |
|or            |   10  | 110    | x                 | 0011        |
|and           |   10  | 111    | x                 | 0010        |
|sll, slli     |   10  | 001    | 00, 10            | 0111        |
|srl, srli     |   10  | 101    | 00, 10            | 1000        |
|sra, srai     |   10  | 101    | 11, 01            | 1001        |

Note that the ALU control has the ALU perform the following operations:
| ALUControl | Operation |
|------------|-----------|
|0000|add|
|0001|subtract|
|0010|and|
|0011|or|
|0100|xor|
|0101|set less than (slt)|
|0110|set less than unsigned (sltu)|
|0111|shift left logical (sll)|
|1000|shift right logical (srl)|
|1001|shift right arithmetic (sra)|

# Immediate Extension
The immediate extension unit needs to extend immediates depending on the type of instruction the immediate recieves. The type of extension is controlled by the signal ImmSrc. Note that this extension unit takes advantage of the fact that the most significant bit of all immediates is always held in bit 31 of instr. The following table describes the extension units behaviour.

| ImmSrc | ImmExt | Instruction Type | Description |
|--------|--------|------------------|-------------|
|000|{{20{Instr[31]}}, Instr[31:20]}| I | 12-bit signed immediate extension|
|001|{{20{Instr[31]}}, Instr[31:25], Instr[11:7]}| S | 12-bit signed immediate extension|
|010|{{20{Instr[31]}}, Instr[7], Instr[30:25], Instr[11:8], 1'b0}| B | 13-bit signed immediate extension|
|011|{{12{Instr[31]}}, Instr[19:12], Instr[20], Instr[30:21], 1'b0}| J | 21-bit signed immediate extension|
|100|{27'b0, Instr[24:20]}| I | 5-bit unsigned immediate extension|

