# RISC-V-Single-Cycle

This project is a single-cycle implementation of a RISC-V microprocessor, developed using Verilog. This microarchiteecture will implement a subset of the RV32I instruction set architecture.

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

| Instruction | Op | RegWrite | ImmSrc | ALUSrc | MemWrite | ResultSrc | Branch | ALUOp |
|-------------|-------|--|--|--|--|--|--|--|
|lw|0000011|1|00|1|0|1|0|00|
|sw|0100011|0|01|1|1|x|0|00|
|R-type|0110011|1|xx|0|0|0|0|10|
|beq|1100011|0|10|0|0|x|1|01|

# ALU Decoder Truth Table

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
|011|or|
|010|and|
101|set less than (slt)|

