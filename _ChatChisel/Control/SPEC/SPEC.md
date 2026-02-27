Module name:control
I/O ports:
val io = IO(new Bundle {
    val opcode = Input(UInt(7.W))
    val funct7 = Input(UInt(7.W))
    val funct3 = Input(UInt(3.W))
    val aluop = Output(UInt(4.W))
    val immsrc = Output(UInt(1.W))
    val isbranch = Output(UInt(1.W))
    val memread = Output(UInt(1.W))
    val memwrite = Output(UInt(1.W))
    val regwrite = Output(UInt(1.W))
    val memtoreg = Output(UInt(2.W))
    val pcsel = Output(UInt(1.W))
    val rdsel = Output(UInt(1.W))
    val isjump = Output(UInt(1.W))
    val isupper = Output(UInt(1.W))
    val islui = Output(UInt(1.W))
})

Internal Logic:
 In a RISC-V processor, the control unit use information in instructions(Rv32I in this processor) to generate the control signals. The truth table of control unit is shown below.The input is opcode,funct3,funct7,and the other are output.The table is written in markdown format, and all numbers are binary.The x in truth table means they're DontCare signals, and can be any value (0 or 1)
 
| Inst | FMT | opcode | funct3 | funct7 | aluop | immsrc | isbranch | memread | memwrite | regwrite | memtoreg | pcsel | rdsel | isjump | isupper | islui |
| ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- |
| add | R | 0110011 | 000 | 0000000 | 0000 | 0 | 0 | 0 | 0 | 1 | 10 | 0 | 0 | 0 | 0 | 0 |
| sub | R | 0110011 | 000 | 0100000 | 0001 | 0 | 0 | 0 | 0 | 1 | 10 | 0 | 0 | 0 | 0 | 0 |
| xor | R | 0110011 | 100 | 0000000 | 0010 | 0 | 0 | 0 | 0 | 1 | 10 | 0 | 0 | 0 | 0 | 0 |
| or | R | 0110011 | 110 | 0000000 | 0011 | 0 | 0 | 0 | 0 | 1 | 10 | 0 | 0 | 0 | 0 | 0 |
| and | R | 0110011 | 111 | 0000000 | 0100 | 0 | 0 | 0 | 0 | 1 | 10 | 0 | 0 | 0 | 0 | 0 |
| sll | R | 0110011 | 001 | 0000000 | 0101 | 0 | 0 | 0 | 0 | 1 | 10 | 0 | 0 | 0 | 0 | 0 |
| srl | R | 0110011 | 101 | 0000000 | 0110 | 0 | 0 | 0 | 0 | 1 | 10 | 0 | 0 | 0 | 0 | 0 |
| sra | R | 0110011 | 101 | 0100000 | 0111 | 0 | 0 | 0 | 0 | 1 | 10 | 0 | 0 | 0 | 0 | 0 |
| slt | R | 0110011 | 010 | 0000000 | 1000 | 0 | 0 | 0 | 0 | 1 | 10 | 0 | 0 | 0 | 0 | 0 |
| sltu | R | 0110011 | 011 | 0000000 | 1001 | 0 | 0 | 0 | 0 | 1 | 10 | 0 | 0 | 0 | 0 | 0 |
| addi | I | 0010011 | 000 | xxxxxxx | 0000 | 1 | 0 | 0 | 0 | 1 | 10 | 0 | 0 | 0 | 0 | 0 |
| xori | I | 0010011 | 100 | xxxxxxx | 0010 | 1 | 0 | 0 | 0 | 1 | 10 | 0 | 0 | 0 | 0 | 0 |
| ori | I | 0010011 | 110 | xxxxxxx | 0011 | 1 | 0 | 0 | 0 | 1 | 10 | 0 | 0 | 0 | 0 | 0 |
| andi | I | 0010011 | 111 | xxxxxxx | 0100 | 1 | 0 | 0 | 0 | 1 | 10 | 0 | 0 | 0 | 0 | 0 |
| slli | I | 0010011 | 001 | 0000000 | 0101 | 1 | 0 | 0 | 0 | 1 | 10 | 0 | 0 | 0 | 0 | 0 |
| srli | I | 0010011 | 101 | 0000000 | 0110 | 1 | 0 | 0 | 0 | 1 | 10 | 0 | 0 | 0 | 0 | 0 |
| srai | I | 0010011 | 101 | 0100000 | 0111 | 1 | 0 | 0 | 0 | 1 | 10 | 0 | 0 | 0 | 0 | 0 |
| slti | I | 0010011 | 010 | xxxxxxx | 1000 | 1 | 0 | 0 | 0 | 1 | 10 | 0 | 0 | 0 | 0 | 0 |
| sltiu | I | 0010011 | 011 | xxxxxxx | 1001 | 1 | 0 | 0 | 0 | 1 | 10 | 0 | 0 | 0 | 0 | 0 |
| lb | I | 0000011 | 000 | xxxxxxx | 0000 | 1 | 0 | 1 | 0 | 1 | 01 | 0 | 0 | 0 | 0 | 0 |
| lh | I | 0000011 | 001 | xxxxxxx | 0000 | 1 | 0 | 1 | 0 | 1 | 01 | 0 | 0 | 0 | 0 | 0 |
| lw | I | 0000011 | 010 | xxxxxxx | 0000 | 1 | 0 | 1 | 0 | 1 | 01 | 0 | 0 | 0 | 0 | 0 |
| lbu | I | 0000011 | 100 | xxxxxxx | 0000 | 1 | 0 | 1 | 0 | 1 | 01 | 0 | 0 | 0 | 0 | 0 |
| lhu | I | 0000011 | 101 | xxxxxxx | 0000 | 1 | 0 | 1 | 0 | 1 | 01 | 0 | 0 | 0 | 0 | 0 |
| sb | S | 0100011 | 000 | xxxxxxx | 0000 | 1 | 0 | 0 | 1 | 0 | 00 | 0 | 0 | 0 | 0 | 0 |
| sh | S | 0100011 | 001 | xxxxxxx | 0000 | 1 | 0 | 0 | 1 | 0 | 00 | 0 | 0 | 0 | 0 | 0 |
| sw | S | 0100011 | 010 | xxxxxxx | 0000 | 1 | 0 | 0 | 1 | 0 | 00 | 0 | 0 | 0 | 0 | 0 |
| beq | B | 1100011 | 000 | xxxxxxx | 1000 | 0 | 1 | 0 | 0 | 0 | 00 | 0 | 0 | 0 | 0 | 0 |
| bne | B | 1100011 | 001 | xxxxxxx | 1000 | 0 | 1 | 0 | 0 | 0 | 00 | 0 | 0 | 0 | 0 | 0 |
| blt | B | 1100011 | 100 | xxxxxxx | 1000 | 0 | 1 | 0 | 0 | 0 | 00 | 0 | 0 | 0 | 0 | 0 |
| bge | B | 1100011 | 101 | xxxxxxx | 1000 | 0 | 1 | 0 | 0 | 0 | 00 | 0 | 0 | 0 | 0 | 0 |
| bltu | B | 1100011 | 110 | xxxxxxx | 1001 | 0 | 1 | 0 | 0 | 0 | 00 | 0 | 0 | 0 | 0 | 0 |
| bgeu | B | 1100011 | 111 | xxxxxxx | 1001 | 0 | 1 | 0 | 0 | 0 | 00 | 0 | 0 | 0 | 0 | 0 |
| jal | J | 1101111 | xxx | xxxxxxx | 0000 | 1 | 0 | 0 | 0 | 1 | 00 | 0 | 0 | 1 | 0 | 0 |
| jalr | I | 1100111 | 000 | xxxxxxx | 0000 | 1 | 0 | 0 | 0 | 1 | 00 | 1 | 0 | 1 | 0 | 0 |
| lui | U | 0110111 | xxx | xxxxxxx | 0000 | 1 | 0 | 0 | 0 | 1 | 10 | 0 | 0 | 0 | 1 | 1 |
| auipc | U | 0010111 | xxx | xxxxxxx | 0000 | 1 | 0 | 0 | 0 | 1 | 00 | 0 | 1 | 0 | 1 | 0 |


