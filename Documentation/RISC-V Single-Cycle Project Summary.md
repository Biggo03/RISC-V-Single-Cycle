# **RISC-V Single-Cycle Processor Project Summary**

## **Introduction:**  
This project involves the design and implementation of a RISC-V single-cycle processor using Verilog HDL. The goal was to develop digital design and verification skills, as well as proficiency in Verilog, while creating a simple processor based on the compact and extensible RISC-V architecture. This project was based on the single-cycle architecture provided by \[1\], with modifications to support additional instructions.

## **Architecture Overview:**  
The control unit decodes instructions and generates control signals, which drive the datapath to perform operations. The datapath retrieves operands, performs arithmetic or logical operations, and stores results in memory or registers based on these signals. The remainder of this section will focus on the control unit and key components within the datapath.

### **Control Unit:**  
The control unit is made of four decoders: main, ALU, branch, and width decoders. The main decoder generates control signals based on the opcode and produces secondary control signals for the specialized decoders. Each specialized decoder receives a subfield of the instruction, as well as the control signal from the main decoder. They each use these inputs in order to decode outputs for specific control signals, which they are named after. The only decoder that obtains additional inputs is the branch decoder which receives flags from the ALU, which are used in conditional branching. Further details on each decoder and its role can be found in the technical documentation.

### **Register File:**  
The register file allows two registers to be read simultaneously and one register to be written. It uses a write enable signal and is clocked on the rising edge to ensure correct writes. It includes 32 registers, as specified in the RISC-V ISA, with the zero register hardcoded to 0, and no way for it to be overwritten.

### **ALU:**  
The ALU supports basic arithmetic, logical, and shifting operations including addition, subtraction, and bitwise operations. It also produces flags that are used in order to determine branching. The operation it performs is determined by the control unit, and its inputs are either two registers, or a register and an immediate. Its output is routed both directly to the data memory (to determine address), as well as to a result multiplexer, which sends data to the register file to be written.

### **Data Memory:**  
The data memory receives an address, which determines the address to be read from or written to, it also receives a write enable signal as well a clock signal. Like the register file, it only allows writing to the given address when the write enable is active, and the clock is on a rising edge. The data memory handles variable-width reads and writes based on the WidthSrc signal, with extensions handled by the “Reduce” module.

### **Instruction Memory:**  
The Instruction memory is a read only memory that has its contents preloaded at synthesis. This memory receives an address, and reads out the data at that address. In this case the address is always determined by the PC.

### **Supported Instructions:**  
This processor supports all instructions within the RV32I ISA, which include most needed instructions for integer arithmetic, and processor control flow. It does not support any interrupts or exceptions.

## **Design Methodology:**  
As for the actual architecture design, I used the base architecture provided by \[1\], and added onto it in order to handle more instructions. To minimize hardware complexity and ensure efficient resource use, I focused on reusing existing components wherever possible, adding only essential control signals and multiplexers to maintain functionality. The biggest change I made was in breaking down the control unit down into four sections rather than two. I did this as the addition of new control signals increased the complexity of the main decoder to a level where it was not readable. This change increased both readability, and modularity, making any future changes easier to implement.

## **Testing and Validation:**  
Each module was tested individually, and all using a SystemVerilog testbench in order to provide stimulus and validate each module, ensuring correct functionality. For the ALU, Extend, and Reduce modules, a python script was used to generate random test vectors that were then applied to the module using the SystemVerilog testbench. 

The top level module was tested by creating a RISC-V assembly program that ran a subset of the implemented instructions. The programs were made such that a final result would only occur if all previous instructions ran correctly. There were 6 programs in total, with the 6th program being a combination of all previous programs. The first program used to test the design was taken from \[1\], and is not included in the final repository. The version of this program within the 6th program is changed due to differing requirements. To test different programs, the file loaded into instruction memory must be changed accordingly.

## **Future Plans:**  
I plan to continue work on this project, and continually add new features. To maintain a stable release while reworking the development process, I will create a new repository for the next iteration of the project, including its own documentation and development log. I could make a branch to the current repository, however I still want to create a separate development log, and ultimately having two development logs could be confusing, and make the repository messier than it needs to be. 

As for actually improving the processor I have a couple of features in mind to start, and the list will likely grow as I continue. As of now I’m planning to extend it to handle interrupts (improve reliability), pipeline it into 5 stages (increase throughput), add branch prediction (reduce stall cycles), and create a memory hierarchy controlled by a memory controller (more realistic memory access, improve memory access efficiency). As I continue to expand the processor’s capabilities, I will refine these goals based on further learning and experimentation.

## **Acknowledgments:**  
\[1\] S. Harris and D. Harris, Digital design and computer architecture: RISC-V Edition. Morgan Kaufmann, 2021\.
