# RISC-V-Single-Cycle

This project is a single-cycle implementation of a RISC-V microprocessor, developed using Verilog. This microarchiteecture will implement a subset of the RV32I instruction set architecture.

# Supported instructions

| Instruction | Type | Opcode | Description |
|-------------|------|--------|-------------|
| `lw'        |'I'   | 0000011|Load word in rd|
| `sw`        |'S'   | 0100011|Store word in rd|
| `add`       |'R'   | 0110011|Add two registers|
| `sub`       |'R'   | 0110011|Subtract two registers|
| `and`       |'R'   | 0110011|AND two registers|
| `or`        |'R'   | 0110011|OR two registers|
| `slt`       |'R'   | 0110011|Sets if rs1 < rs2|
| `beq`       |'B'   | 1100011|Branches if equal|
| `jal`       |'J'   | 1101111|Jump and link|
| `addi`      |'I'   | 0010011|Add immediate|
