
## Module name: ALU

## I/O ports
val io = IO(new Bundle {
    val alu_in1 = Input(UInt(32.W))
    val alu_in2 = Input(UInt(32.W))
    val aluop = Input(UInt(4.W))
    val zero = Output(UInt(1.W))
    val alu_result = Output(UInt(32.W))
})

## Internal Logic
 In a RISC-V processor, Alu (Arithmetic Logic Unit) is a computing unit. It calculates two inputs (alu_in1 and alu_in2) to generate output alu_result, and output signal zero indicate shows whether alu_in1=alu_in2. At the same time, control signal ALUOP is used to select the computing operation.Alu supports the following operations:

| operation | aluop |
| ---- | ---- |
| ADD<br> | 0000 |
| SUB | 0001 |
| XOR | 0010 |
| OR | 0011 |
| AND | 0100 |
| Shift Left Logical | 0101 |
| Shift Right Logical | 0110 |
| Shift Right Arith(msb-extends) | 0111 |
| Set Less Than | 1000 |
| Set Less Than(U)(zero-extends) | 1001 |


