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
|'lw, sw'      | '00'  | 'x'    | 'x'               | '000'      |
|'beq'         | '01'  | 'x'    | 'x'               | '001'      |
|'add'         | '10'  | '000'  | '00, 01, 10'      | '000'      |
|'sub'         | '10'  | '000'  | '11'              | '001'      |
|'slt'         | '10'  | '010'  | 'x'               | '101'      |
|'or'          | '10'  | '110'  | 'x'               | '011'      |
|'and'         | '10'  | '111'  | 'x'               | '010'      |


