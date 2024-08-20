# RISC-V-Single-Cycle

This project is a single-cycle implementation of a RISC-V microprocessor, developed using Verilog. This microarchiteecture will implement a subset of the RV32I instruction set architecture.

A schematic of the implemented microarchitecture is available in this repository under "RISC-V Single-Cycle Schematic"

# Supported instructions

| Instruction | Type | Opcode | Description |
|-------------|------|--------|-------------|
| `lw`        |'I'   | 0000011|Load word in rd|
| `lb`        |'I'   | 0000011|Load signed byte in rd|
| `lbu`       |'I'   | 0000011|Load unsigned byte in rd|
| `lui`       |'U'   | 0110111|Load immediate into upper 20-bits of rd|
| `auipc`     |'U'   | 0010111|Add upper immediate to PC|
| `sw`        |'S'   | 0100011|Store word in rd|
| `add`       |'R'   | 0110011|Add two registers|
| `sub`       |'R'   | 0110011|Subtract two registers|
| `and`       |'R'   | 0110011|AND two registers|
| `or`        |'R'   | 0110011|OR two registers|
| `slt`       |'R'   | 0110011|Sets if rs1 < rs2|
| `sltu`      |'R'   | 0110011|Sets if rs1 < rs2 in unsigned representation|
| `sll`       |'R'   | 0110011|Shift left logical|
| `srl`       |'R'   | 0110011|Shift right logical|
| `sra`       |'R'   | 0110011|Arithmetic shift right|
| `beq`       |'B'   | 1100011|Branches if equal|
| `bne`       |'B'   | 1100011|Branches if not equal|
| `bge`       |'B'   | 1100011|Branches if greater or equal to|
| `bgeu`      |'B'   | 1100011|Branches if greater or equal to (unsigned)|
| `blt`       |'B'   | 1100011|Branches if less than|
| `bltu`      |'B'   | 1100011|Branches if less than (unsigned)|
| `jal`       |'J'   | 1101111|Jump and link|
| `addi`      |'I'   | 0010011|Add immediate|
| `andi`      |'I'   | 0010011|AND a register and an immediate|
| `ori`       |'I'   | 0010011|OR a register and an immediate|
| `slli`      |'I'   | 0010011|Shift left logical by an immediate|
| `srli`      |'I'   | 0010011|Shift right logical by an immediate|
| `srai`      |'I'   | 0010011|Arithmetic shift right by an immediate|




# Memory Interface
This design assumes a memory that can be accessed in a single-cycle, and uses both a data memory, and an instruction memory.

# Control Unit
This processors control unit currently contains the following control signals. Note that this table includes internal control signals which are not seen on the final schematic.

| Control Signal | Function |
|----------------|----------|
|RegWrite|Determine if RF is to be written to, active high|
|ImmSrc|Determines how the extension unit is to extend an immediate|
|ALUSrc|Determines B operand ALU is to recieve|
|MemWrite|Determines if data memory is to be written to, active high|
|ResultSrc|Determines what value is to be written back to RF|
|Branch|Determine if an instruction MAY branch, used in conjunction with flags|
|PCSrc|Determines if branch/jump is actually to take place|
|jump|Asserts PCSrc, ensuring a jump takes place|
|ALUOp|Assists in determining ALU operation (further dependant on funct3 and funct7)|
|ALUControl|Determines the ALU operation|
|WidthSrc|Determines the width of meaningful data in result signal|

(*Note to self: WidthSrc dependant on funct3, as well as the opcode, this is why funct3 is routed to main decoder now, may want to add funct3 to main decoder truth table for clarity)

# Main Decoder Truth Table

| Instruction         | Op    | funct3 | RegWrite | ImmSrc | ALUSrc | MemWrite | ResultSrc | Branch | ALUOp | WidthSrc | Jump |
|---------------------|-------|--------|----------|--------|--------|----------|-----------|--------|-------|----------|------|
|lw                   |0000011|010     |1         |000     |1       |0         |001        |000     |00     |00        |0     |
|lb                   |0000011|000     |1         |000     |1       |0         |001        |000     |00     |01        |0     |
|lbu                  |0000011|100     |1         |000     |1       |0         |001        |000     |00     |10        |0     |
|lui                  |0110111|xxx     |1         |101     |x       |0         |011        |000     |xx     |00        |0     |
|auipc                |0010111|xxx     |1         |101     |x       |0         |100        |000     |xx     |00        |0     |
|sw                   |0100011|010     |0         |001     |1       |1         |xxx        |000     |00     |00        |0     |
|R-type               |0110011|op spec |1         |xxx     |0       |0         |000        |000     |10     |00        |0     |
|I-type arithmetic ALU|0010011|op spec |1         |000     |1       |0         |000        |000     |10     |00        |0     |
|I-type shift ALU     |0010011|op spec |1         |100     |1       |0         |000        |000     |10     |00        |0     |
|beq                  |1100011|000     |0         |010     |0       |0         |xxx        |001     |01     |00        |0     |
|bne                  |1100011|001     |0         |010     |0       |0         |xxx        |010     |01     |00        |0     |
|bge                  |1100011|101     |0         |010     |0       |0         |xxx        |011     |01     |00        |0     |
|bgeu                 |1100011|111     |0         |010     |0       |0         |xxx        |100     |01     |00        |0     |
|blt                  |1100011|100     |0         |010     |0       |0         |xxx        |101     |01     |00        |0     |
|bltu                 |1100011|110     |0         |010     |0       |0         |xxx        |110     |01     |00        |0     |
|jal                  |1101111|xxx     |1         |011     |x       |0         |010        |xxx     |xx     |00        |1     |


# ALU

The ALU implements add, subtract, and, or, xor, slt, sltu, sll, srl, and sra. All extensions are handeled by an extension unit.

| Instructions | ALUOp | funct3 | {op[5], funct7[5] | ALUControl |
|--------------|-------|--------|-------------------|-------------|
|lw, sw        |   00  | x      | x                 | 0000        |
|B-type instructions|01| x      | x                 | 0001        |
|add, addi     |   10  | 000    | 00, 01, 10        | 0000        |
|sub           |   10  | 000    | 11                | 0001        |
|slt           |   10  | 010    | x                 | 0101        |
|sltu          |   10  | 011    | x                 | 0110        |
|or, ori       |   10  | 110    | x                 | 0011        |
|and, andi     |   10  | 111    | x                 | 0010        |
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
|101|{Instr[31:12], 12'b0}| U | Zero-extend bottom 12-bits of upper immediate|


