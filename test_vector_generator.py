from bitstring import BitArray
import random

def get_verilog_index(start_index=31, end_index=0):
    new_start = 31-start_index

    #is non-inclusive, so must take one off
    new_end = 32-end_index

    return new_start, new_end

def generate_extension(num_ext_bits, MSB, immediate):
    ext =  BitArray(int=-1*MSB, length=num_ext_bits)
    return ext + immediate

def extension_vector_gen(vector_per_op):
    immSrc = []

    #Create array of valid opCodes
    for i in range(5):
        immSrc.append(BitArray(uint=i, length=3))

    with open("ext_unit_test_vectors.txt", "w") as file:
        for opCode in immSrc:
            for j in range(vector_per_op):

                full_vector = []

                #Generate Random instrution field
                initial_num = random.randint(-2**24, 2**24-1)
                instr = BitArray(int = initial_num, length = 25)
                full_vector.append(instr.bin)

                #append opCode
                full_vector.append(opCode.bin)

                #I-type instructions
                if (opCode.bin == "000"):
                    
                    #Determine intial immediate ([31:20], sign extended)
                    start, end = get_verilog_index(31, 20)
                    immediate = instr[start:end]

                    #Generate extension bits
                    Expected_result = generate_extension(20, instr[0], immediate)

                    #append expected result to test vector
                    full_vector.append(Expected_result.bin)
                
                #S-type Instructions
                elif (opCode.bin == "001"):

                    #Determine initial immediate ([31:25], [11:7])
                    start, end = get_verilog_index(31,25)
                    immediate = instr[start:end]
                    start, end = get_verilog_index(11,7)
                    immediate += instr[start:end]

                    #Generate extension bits
                    Expected_result = generate_extension(20, instr[0], immediate)

                    #Append to vector
                    full_vector.append(Expected_result.bin)
                
                #B-type Instructions
                elif (opCode.bin == "010"):

                    #Determine initial Immediate ([7], [30:25], [11:8], 0)
                    start, end = get_verilog_index(7)
                    immediate = BitArray(uint=instr[start], length=1)
                    
                    start, end = get_verilog_index(30, 25)
                    immediate += instr[start:end]

                    start, end = get_verilog_index(11, 8)
                    immediate += instr[start:end] + BitArray(uint=0, length=1)

                    #Generate expected result
                    Expected_result = generate_extension(20, instr[0], immediate)
                    
                    #Appendd expected result
                    full_vector.append(Expected_result.bin)
                
                #J-type Instructions
                elif (opCode.bin == "011"):
                    
                    #Determine immediate ([19:12], [20], [30:21], 0)
                    start, end = get_verilog_index(19, 12)
                    immediate = instr[start:end]

                    start, end = get_verilog_index(20)
                    immediate += BitArray(uint=instr[start], length=1)

                    start, end = get_verilog_index(30, 21)
                    immediate += instr[start:end] + BitArray(uint=0, length=1)

                    #Generate expected result
                    Expected_result = generate_extension(12, instr[0], immediate)

                    #Append expected result
                    full_vector.append(Expected_result.bin)
                
                #U-type Instructions
                elif(opCode.bin == "100"):
                    
                    #Determine immediate ([31:12])
                    start, end = get_verilog_index(31, 12)
                    immediate = instr[start:end]

                    #Special case, add on 12 zeros to end of vector
                    ext =  BitArray(int=0, length=12)

                    Expected_result = immediate + ext

                    full_vector.append(Expected_result.bin)

                else:
                    full_vector.append(32* "x")

                #Write all to file
                for k in range(len(full_vector)):
                    file.write(full_vector[k])
                    if (k != len(full_vector) - 1):
                        file.write(" ")
                file.write("\n")


def main():

    extension_vector_gen(100)

if __name__ == "__main__":
    main()