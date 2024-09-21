# RISC-V-Single-Cycle
A single-cycle implementation of a RISC-V microprocessor in Verilog.

## Introduction
This project is a single-cycle implementation of a RISC-V microprocessor, developed using Verilog. The processor executes one instruction per clock cycle and implements the RV32I instruction set architecture (ISA). This compact yet powerful architecture is widely used in both academia and industry for building RISC processors.

A single-cycle processor processes one instruction in every clock cycle. As a result, the clock speed is limited by the most complex instruction, making it slower compared to pipelined designs. However, this approach simplifies control logic, making it an ideal starting point for learning processor design.

The project showcases a fundamental understanding of processor architecture by implementing key RISC-V instructions and focusing on control and data paths. By integrating testbenches for validation, this project also emphasizes the importance of hardware testing and verification.

A schematic for the complete microarchitecture can be found in the "Documentation" folder.

## Key Features
- Single-cycle operation for simplified control logic
- Implements RV32I instructions
- Separate Instruction and data memories
- Testbenches for hardware validation

## Technical Details
For a detailed explanation of the architecture, supported instructions, control signals, and testing procedures, please refer to [TECHNICAL_DETAILS.md](Documentation/Technical_Documentation.md).

## Future Work
I plan on building on this processor in the future, although I will begin work in a seperate repository. Plans for building onto this porcessor include adding interrupt handelling, pipelining, branch prediction, and a memory hierarchy/cache system. Once the repositroy is created and work has begun I will link it here.

## Acknowledgments
S. Harris and D. Harris, Digital design and computer architecture: RISC-V Edition. Morgan Kaufmann, 2021.
