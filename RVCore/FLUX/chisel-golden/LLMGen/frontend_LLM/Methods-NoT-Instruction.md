
## Base Method-verilog
Please act as a professional verilog designer. Give me the complete verilog code.

Give me the complete verilog code.

## Base Method
Please act as a professional Chisel designer. Give me the complete Chisel code.

```
Introduction:
The following table summarizes the instructions of each part of the RISC-V instruction set, including its BitPat mode table and micro-operation code table (MicroOp).
The following content includes RISCV32I instructions, RV32I_ALUInst (instructions about operations), RV32I_BRUInst (instructions about jumps), RV32I_LSUInst (instructions about memory operations). In addition, there are RVZicsrInst (instructions about CSR) and Privileged (instructions about privileged levels).

It needs to be constructed according to the following example format based on the contents of the table:
object RV32I_ALUInst extends HasNPCParameter 
with TYPE_INST
{
    def ADDI    = BitPat("b????????????_?????_000_?????_0010011")
    def SLLI    = BitPat("b0000000?????_?????_001_?????_0010011")
    // ...
    val table = Array (
    ADDI    -> List(TYPE_I, FuType.alu, ALUOpType.add, FuSrcType.rfSrc1, FuSrcType.imm),
    SLLI    -> List(TYPE_I, FuType.alu, ALUOpType.sll, FuSrcType.rfSrc1, FuSrcType.imm),
    // ...
    )
}

#### RV32I_ALUInst
**BitPat Table**

| Instruction  | BitPat Mode                     |
|-------|-------------------------------------|
| ADDI  | `b????????????_?????_000_?????_0010011` |
| SLLI  | `b0000000?????_?????_001_?????_0010011` |
| SLTI  | `b????????????_?????_010_?????_0010011` |
| SLTIU | `b????????????_?????_011_?????_0010011` |
| XORI  | `b????????????_?????_100_?????_0010011` |
| SRLI  | `b0000000?????_?????_101_?????_0010011` |
| ORI   | `b????????????_?????_110_?????_0010011` |
| ANDI  | `b????????????_?????_111_?????_0010011` |
| SRAI  | `b0100000?????_?????_101_?????_0010011` |
| ADD   | `b0000000_?????_?????_000_?????_0110011` |
| SLL   | `b0000000_?????_?????_001_?????_0110011` |
| SLT   | `b0000000_?????_?????_010_?????_0110011` |
| SLTU  | `b0000000_?????_?????_011_?????_0110011` |
| XOR   | `b0000000_?????_?????_100_?????_0110011` |
| SRL   | `b0000000_?????_?????_101_?????_0110011` |
| OR    | `b0000000_?????_?????_110_?????_0110011` |
| AND   | `b0000000_?????_?????_111_?????_0110011` |
| SUB   | `b0100000_?????_?????_000_?????_0110011` |
| SRA   | `b0100000_?????_?????_101_?????_0110011` |
| AUIPC   | `b????????????????????_?????_0010111` |
| LUI   | `b????????????????????_?????_0110111` |

**MicroOp Table**
| Instruction | Type    | Functional unit type | Operation Type  | Source 1 Type  | Source 2 Type |
|-------|---------|--------------|-------------|---------------|---------------|
| ADDI  | TYPE_I  | FuType.alu   | ALUOpType.add | FuSrcType.rfSrc1 | FuSrcType.imm |
| SLLI  | TYPE_I  | FuType.alu   | ALUOpType.sll | FuSrcType.rfSrc1 | FuSrcType.imm |
| SLTI  | TYPE_I  | FuType.alu   | ALUOpType.slt | FuSrcType.rfSrc1 | FuSrcType.imm |
| SLTIU | TYPE_I  | FuType.alu   | ALUOpType.sltu | FuSrcType.rfSrc1 | FuSrcType.imm |
| XORI  | TYPE_I  | FuType.alu   | ALUOpType.xor | FuSrcType.rfSrc1 | FuSrcType.imm |
| SRLI  | TYPE_I  | FuType.alu   | ALUOpType.srl | FuSrcType.rfSrc1 | FuSrcType.imm |
| ORI   | TYPE_I  | FuType.alu   | ALUOpType.or | FuSrcType.rfSrc1 | FuSrcType.imm |
| ANDI  | TYPE_I  | FuType.alu   | ALUOpType.and | FuSrcType.rfSrc1 | FuSrcType.imm |
| SRAI  | TYPE_I  | FuType.alu   | ALUOpType.sra | FuSrcType.rfSrc1 | FuSrcType.imm |
| ADD   | TYPE_R  | FuType.alu   | ALUOpType.add | FuSrcType.rfSrc1 | FuSrcType.rfSrc2 |
| SLL   | TYPE_R  | FuType.alu   | ALUOpType.sll | FuSrcType.rfSrc1 | FuSrcType.rfSrc2 |
| SLT   | TYPE_R  | FuType.alu   | ALUOpType.slt | FuSrcType.rfSrc1 | FuSrcType.rfSrc2 |
| SLTU  | TYPE_R  | FuType.alu   | ALUOpType.sltu | FuSrcType.rfSrc1 | FuSrcType.rfSrc2 |
| XOR   | TYPE_R  | FuType.alu   | ALUOpType.xor | FuSrcType.rfSrc1 | FuSrcType.rfSrc2 |
| SRL   | TYPE_R  | FuType.alu   | ALUOpType.srl | FuSrcType.rfSrc1 | FuSrcType.rfSrc2 |
| OR    | TYPE_R  | FuType.alu   | ALUOpType.or | FuSrcType.rfSrc1 | FuSrcType.rfSrc2 |
| AND   | TYPE_R  | FuType.alu   | ALUOpType.and | FuSrcType.rfSrc1 | FuSrcType.rfSrc2 |
| SUB   | TYPE_R  | FuType.alu   | ALUOpType.sub | FuSrcType.rfSrc1 | FuSrcType.rfSrc2 |
| SRA   | TYPE_R  | FuType.alu   | ALUOpType.sra | FuSrcType.rfSrc1 | FuSrcType.rfSrc2 |
| AUIPC | TYPE_U  | FuType.alu   | ALUOpType.add | FuSrcType.pc | FuSrcType.imm |
| LUI   | TYPE_U  | FuType.alu   | ALUOpType.add | FuSrcType.zero | FuSrcType.imm |


#### RV32I_BRUInst
**BitPat Table**
| Instruction  | BitPat Mode                     |
|-------|-------------------------------------|
| JAL   | `b????????????????????_?????_1101111` |
| JALR  | `b????????????_?????_000_?????_1100111` |
| BEQ   | `b???????_?????_?????_000_?????_1100011` |
| BNE   | `b???????_?????_?????_001_?????_1100011` |
| BLT   | `b???????_?????_?????_100_?????_1100011` |
| BGE   | `b???????_?????_?????_101_?????_1100011` |
| BLTU  | `b???????_?????_?????_110_?????_1100011` |
| BGEU  | `b???????_?????_?????_111_?????_1100011` |

**MicroOp Table**
| Instruction | Type    | Functional unit type | Operation Type  | Source 1 Type  | Source 2 Type |
|------|---------|--------------|--------------|---------------|---------------|
| JAL  | TYPE_J  | FuType.alu   | ALUOpType.add | FuSrcType.pc  | FuSrcType.four |
| JALR | TYPE_I  | FuType.alu   | ALUOpType.add | FuSrcType.pc  | FuSrcType.four |
| BEQ  | TYPE_B  | FuType.bru   | ALUOpType.beq | FuSrcType.rfSrc1 | FuSrcType.rfSrc2 |
| BNE  | TYPE_B  | FuType.bru   | ALUOpType.bne | FuSrcType.rfSrc1 | FuSrcType.rfSrc2 |
| BLT  | TYPE_B  | FuType.bru   | ALUOpType.blt | FuSrcType.rfSrc1 | FuSrcType.rfSrc2 |
| BGE  | TYPE_B  | FuType.bru   | ALUOpType.bge | FuSrcType.rfSrc1 | FuSrcType.rfSrc2 |
| BLTU | TYPE_B  | FuType.bru   | ALUOpType.bltu | FuSrcType.rfSrc1 | FuSrcType.rfSrc2 |
| BGEU | TYPE_B  | FuType.bru   | ALUOpType.bgeu | FuSrcType.rfSrc1 | FuSrcType.rfSrc2 |

#### RV32I_LSUInst
**BitPat Table**
| Instruction  | BitPat Mode                     |
|-------|-------------------------------------|
| SB    | `b???????_?????_?????_000_?????_0100011` |
| SH    | `b???????_?????_?????_001_?????_0100011` |
| SW    | `b???????_?????_?????_010_?????_0100011` |
| LB    | `b????????????_?????_000_?????_0000011`  |
| LH    | `b????????????_?????_001_?????_0000011`  |
| LW    | `b????????????_?????_010_?????_0000011`  |
| LBU   | `b????????????_?????_100_?????_0000011`  |
| LHU   | `b????????????_?????_101_?????_0000011`  |


**MicroOp Table**

| Instruction | Type    | Functional unit type | Operation Type  | Source 1 Type  | Source 2 Type |
|-------|---------|--------------|-------------|---------------|---------------|
| SB    | TYPE_S  | FuType.lsu   | LSUOpType.sb | FuSrcType.rfSrc1 | FuSrcType.imm |
| SH    | TYPE_S  | FuType.lsu   | LSUOpType.sh | FuSrcType.rfSrc1 | FuSrcType.imm |
| SW    | TYPE_S  | FuType.lsu   | LSUOpType.sw | FuSrcType.rfSrc1 | FuSrcType.imm |
| LB    | TYPE_I  | FuType.lsu   | LSUOpType.lb | FuSrcType.rfSrc1 | FuSrcType.imm |
| LH    | TYPE_I  | FuType.lsu   | LSUOpType.lh | FuSrcType.rfSrc1 | FuSrcType.imm |
| LW    | TYPE_I  | FuType.lsu   | LSUOpType.lw | FuSrcType.rfSrc1 | FuSrcType.imm |
| LBU   | TYPE_I  | FuType.lsu   | LSUOpType.lbu | FuSrcType.rfSrc1 | FuSrcType.imm |
| LHU   | TYPE_I  | FuType.lsu   | LSUOpType.lhu | FuSrcType.rfSrc1 | FuSrcType.imm |



#### RVZicsrInst & Privileged
**BitPat Table**
| Instruction  | BitPat Mode                     |
|-------|-------------------------------------|
| CSRRW | `b????????????_?????_001_?????_1110011` |
| CSRRS | `b????????????_?????_010_?????_1110011` |

**MicroOp Table**
| Instruction | Type    | Functional unit type | Operation Type  | Source 1 Type  | Source 2 Type |
|-------|---------|--------------|-------------|---------------|---------------|
| CSRRW | TYPE_I  | FuType.csr   | CSROpType.wrt | FuSrcType.rfSrc1 | FuSrcType.imm |
| CSRRS | TYPE_I  | FuType.csr   | CSROpType.set | FuSrcType.rfSrc1 | FuSrcType.imm |


**BitPat Table**
| Instruction  | BitPat Mode                     |
|--------|-------------------------------------|
| ECALL  | `b000000000000_00000_000_00000_1110011` |
| EBREAK | `b000000000001_00000_000_00000_1110011` |
| MRET   | `b001100000010_00000_000_00000_1110011` |

**MicroOp Table**
| Instruction | Type    | Functional unit type | Operation Type  | Source 1 Type  | Source 2 Type |
|--------|---------|---------------|----------------|----------------|----------------|
| ECALL  | TYPE_I  | FuType.csr    | CSROpType.jmp  | FuSrcType.rfSrc1 | FuSrcType.imm  |
| EBREAK | TYPE_I  | FuType.csr    | CSROpType.jmp  | FuSrcType.rfSrc1 | FuSrcType.imm  |
| MRET   | TYPE_R  | FuType.csr    | CSROpType.jmp  | FuSrcType.rfSrc1 | FuSrcType.rfSrc2 |
```
Give me the complete Chisel code.


## NoT Method s1-Spec Slicer
Please act as a professional Chisel designer. Slice the `Internal logic` into several coding tasks

```
## ISA

Introduction:
The following table summarizes the instructions of each part of the RISC-V instruction set, including its BitPat mode table and micro-operation code table (MicroOp).
The following content includes RISCV32I instructions, RV32I_ALUInst (instructions about operations), RV32I_BRUInst (instructions about jumps), RV32I_LSUInst (instructions about memory operations). In addition, there are RVZicsrInst (instructions about CSR) and Privileged (instructions about privileged levels).

It needs to be constructed according to the following example format based on the contents of the table:
object RV32I_ALUInst extends HasNPCParameter 
with TYPE_INST
{
    def ADDI    = BitPat("b????????????_?????_000_?????_0010011")
    def SLLI    = BitPat("b0000000?????_?????_001_?????_0010011")
    // ...
    val table = Array (
    ADDI    -> List(TYPE_I, FuType.alu, ALUOpType.add, FuSrcType.rfSrc1, FuSrcType.imm),
    SLLI    -> List(TYPE_I, FuType.alu, ALUOpType.sll, FuSrcType.rfSrc1, FuSrcType.imm),
    // ...
    )
}

#### RV32I_ALUInst
**BitPat Table**

| Instruction  | BitPat Mode                     |
|-------|-------------------------------------|
| ADDI  | `b????????????_?????_000_?????_0010011` |
| SLLI  | `b0000000?????_?????_001_?????_0010011` |
| SLTI  | `b????????????_?????_010_?????_0010011` |
| SLTIU | `b????????????_?????_011_?????_0010011` |
| XORI  | `b????????????_?????_100_?????_0010011` |
| SRLI  | `b0000000?????_?????_101_?????_0010011` |
| ORI   | `b????????????_?????_110_?????_0010011` |
| ANDI  | `b????????????_?????_111_?????_0010011` |
| SRAI  | `b0100000?????_?????_101_?????_0010011` |
| ADD   | `b0000000_?????_?????_000_?????_0110011` |
| SLL   | `b0000000_?????_?????_001_?????_0110011` |
| SLT   | `b0000000_?????_?????_010_?????_0110011` |
| SLTU  | `b0000000_?????_?????_011_?????_0110011` |
| XOR   | `b0000000_?????_?????_100_?????_0110011` |
| SRL   | `b0000000_?????_?????_101_?????_0110011` |
| OR    | `b0000000_?????_?????_110_?????_0110011` |
| AND   | `b0000000_?????_?????_111_?????_0110011` |
| SUB   | `b0100000_?????_?????_000_?????_0110011` |
| SRA   | `b0100000_?????_?????_101_?????_0110011` |
| AUIPC   | `b????????????????????_?????_0010111` |
| LUI   | `b????????????????????_?????_0110111` |

**MicroOp Table**
| Instruction | Type    | Functional unit type | Operation Type  | Source 1 Type  | Source 2 Type |
|-------|---------|--------------|-------------|---------------|---------------|
| ADDI  | TYPE_I  | FuType.alu   | ALUOpType.add | FuSrcType.rfSrc1 | FuSrcType.imm |
| SLLI  | TYPE_I  | FuType.alu   | ALUOpType.sll | FuSrcType.rfSrc1 | FuSrcType.imm |
| SLTI  | TYPE_I  | FuType.alu   | ALUOpType.slt | FuSrcType.rfSrc1 | FuSrcType.imm |
| SLTIU | TYPE_I  | FuType.alu   | ALUOpType.sltu | FuSrcType.rfSrc1 | FuSrcType.imm |
| XORI  | TYPE_I  | FuType.alu   | ALUOpType.xor | FuSrcType.rfSrc1 | FuSrcType.imm |
| SRLI  | TYPE_I  | FuType.alu   | ALUOpType.srl | FuSrcType.rfSrc1 | FuSrcType.imm |
| ORI   | TYPE_I  | FuType.alu   | ALUOpType.or | FuSrcType.rfSrc1 | FuSrcType.imm |
| ANDI  | TYPE_I  | FuType.alu   | ALUOpType.and | FuSrcType.rfSrc1 | FuSrcType.imm |
| SRAI  | TYPE_I  | FuType.alu   | ALUOpType.sra | FuSrcType.rfSrc1 | FuSrcType.imm |
| ADD   | TYPE_R  | FuType.alu   | ALUOpType.add | FuSrcType.rfSrc1 | FuSrcType.rfSrc2 |
| SLL   | TYPE_R  | FuType.alu   | ALUOpType.sll | FuSrcType.rfSrc1 | FuSrcType.rfSrc2 |
| SLT   | TYPE_R  | FuType.alu   | ALUOpType.slt | FuSrcType.rfSrc1 | FuSrcType.rfSrc2 |
| SLTU  | TYPE_R  | FuType.alu   | ALUOpType.sltu | FuSrcType.rfSrc1 | FuSrcType.rfSrc2 |
| XOR   | TYPE_R  | FuType.alu   | ALUOpType.xor | FuSrcType.rfSrc1 | FuSrcType.rfSrc2 |
| SRL   | TYPE_R  | FuType.alu   | ALUOpType.srl | FuSrcType.rfSrc1 | FuSrcType.rfSrc2 |
| OR    | TYPE_R  | FuType.alu   | ALUOpType.or | FuSrcType.rfSrc1 | FuSrcType.rfSrc2 |
| AND   | TYPE_R  | FuType.alu   | ALUOpType.and | FuSrcType.rfSrc1 | FuSrcType.rfSrc2 |
| SUB   | TYPE_R  | FuType.alu   | ALUOpType.sub | FuSrcType.rfSrc1 | FuSrcType.rfSrc2 |
| SRA   | TYPE_R  | FuType.alu   | ALUOpType.sra | FuSrcType.rfSrc1 | FuSrcType.rfSrc2 |
| AUIPC | TYPE_U  | FuType.alu   | ALUOpType.add | FuSrcType.pc | FuSrcType.imm |
| LUI   | TYPE_U  | FuType.alu   | ALUOpType.add | FuSrcType.zero | FuSrcType.imm |


#### RV32I_BRUInst
**BitPat Table**
| Instruction  | BitPat Mode                     |
|-------|-------------------------------------|
| JAL   | `b????????????????????_?????_1101111` |
| JALR  | `b????????????_?????_000_?????_1100111` |
| BEQ   | `b???????_?????_?????_000_?????_1100011` |
| BNE   | `b???????_?????_?????_001_?????_1100011` |
| BLT   | `b???????_?????_?????_100_?????_1100011` |
| BGE   | `b???????_?????_?????_101_?????_1100011` |
| BLTU  | `b???????_?????_?????_110_?????_1100011` |
| BGEU  | `b???????_?????_?????_111_?????_1100011` |

**MicroOp Table**
| Instruction | Type    | Functional unit type | Operation Type  | Source 1 Type  | Source 2 Type |
|------|---------|--------------|--------------|---------------|---------------|
| JAL  | TYPE_J  | FuType.alu   | ALUOpType.add | FuSrcType.pc  | FuSrcType.four |
| JALR | TYPE_I  | FuType.alu   | ALUOpType.add | FuSrcType.pc  | FuSrcType.four |
| BEQ  | TYPE_B  | FuType.bru   | ALUOpType.beq | FuSrcType.rfSrc1 | FuSrcType.rfSrc2 |
| BNE  | TYPE_B  | FuType.bru   | ALUOpType.bne | FuSrcType.rfSrc1 | FuSrcType.rfSrc2 |
| BLT  | TYPE_B  | FuType.bru   | ALUOpType.blt | FuSrcType.rfSrc1 | FuSrcType.rfSrc2 |
| BGE  | TYPE_B  | FuType.bru   | ALUOpType.bge | FuSrcType.rfSrc1 | FuSrcType.rfSrc2 |
| BLTU | TYPE_B  | FuType.bru   | ALUOpType.bltu | FuSrcType.rfSrc1 | FuSrcType.rfSrc2 |
| BGEU | TYPE_B  | FuType.bru   | ALUOpType.bgeu | FuSrcType.rfSrc1 | FuSrcType.rfSrc2 |

#### RV32I_LSUInst
**BitPat Table**
| Instruction  | BitPat Mode                     |
|-------|-------------------------------------|
| SB    | `b???????_?????_?????_000_?????_0100011` |
| SH    | `b???????_?????_?????_001_?????_0100011` |
| SW    | `b???????_?????_?????_010_?????_0100011` |
| LB    | `b????????????_?????_000_?????_0000011`  |
| LH    | `b????????????_?????_001_?????_0000011`  |
| LW    | `b????????????_?????_010_?????_0000011`  |
| LBU   | `b????????????_?????_100_?????_0000011`  |
| LHU   | `b????????????_?????_101_?????_0000011`  |


**MicroOp Table**

| Instruction | Type    | Functional unit type | Operation Type  | Source 1 Type  | Source 2 Type |
|-------|---------|--------------|-------------|---------------|---------------|
| SB    | TYPE_S  | FuType.lsu   | LSUOpType.sb | FuSrcType.rfSrc1 | FuSrcType.imm |
| SH    | TYPE_S  | FuType.lsu   | LSUOpType.sh | FuSrcType.rfSrc1 | FuSrcType.imm |
| SW    | TYPE_S  | FuType.lsu   | LSUOpType.sw | FuSrcType.rfSrc1 | FuSrcType.imm |
| LB    | TYPE_I  | FuType.lsu   | LSUOpType.lb | FuSrcType.rfSrc1 | FuSrcType.imm |
| LH    | TYPE_I  | FuType.lsu   | LSUOpType.lh | FuSrcType.rfSrc1 | FuSrcType.imm |
| LW    | TYPE_I  | FuType.lsu   | LSUOpType.lw | FuSrcType.rfSrc1 | FuSrcType.imm |
| LBU   | TYPE_I  | FuType.lsu   | LSUOpType.lbu | FuSrcType.rfSrc1 | FuSrcType.imm |
| LHU   | TYPE_I  | FuType.lsu   | LSUOpType.lhu | FuSrcType.rfSrc1 | FuSrcType.imm |



#### RVZicsrInst & Privileged
**BitPat Table**
| Instruction  | BitPat Mode                     |
|-------|-------------------------------------|
| CSRRW | `b????????????_?????_001_?????_1110011` |
| CSRRS | `b????????????_?????_010_?????_1110011` |

**MicroOp Table**
| Instruction | Type    | Functional unit type | Operation Type  | Source 1 Type  | Source 2 Type |
|-------|---------|--------------|-------------|---------------|---------------|
| CSRRW | TYPE_I  | FuType.csr   | CSROpType.wrt | FuSrcType.rfSrc1 | FuSrcType.imm |
| CSRRS | TYPE_I  | FuType.csr   | CSROpType.set | FuSrcType.rfSrc1 | FuSrcType.imm |


**BitPat Table**
| Instruction  | BitPat Mode                     |
|--------|-------------------------------------|
| ECALL  | `b000000000000_00000_000_00000_1110011` |
| EBREAK | `b000000000001_00000_000_00000_1110011` |
| MRET   | `b001100000010_00000_000_00000_1110011` |

**MicroOp Table**
| Instruction | Type    | Functional unit type | Operation Type  | Source 1 Type  | Source 2 Type |
|--------|---------|---------------|----------------|----------------|----------------|
| ECALL  | TYPE_I  | FuType.csr    | CSROpType.jmp  | FuSrcType.rfSrc1 | FuSrcType.imm  |
| EBREAK | TYPE_I  | FuType.csr    | CSROpType.jmp  | FuSrcType.rfSrc1 | FuSrcType.imm  |
| MRET   | TYPE_R  | FuType.csr    | CSROpType.jmp  | FuSrcType.rfSrc1 | FuSrcType.rfSrc2 |

```
Slice the `Internal logic` into several coding tasks.
### Task n: 
**Objective:**
**Step:**


## NOT Method s2-Modern HDL Gen

Please act as a professional Chisel designer. Give me the complete Chisel code.


```
## ISA

Introduction:
The following table summarizes the instructions of each part of the RISC-V instruction set, including its BitPat mode table and micro-operation code table (MicroOp).
The following content includes RISCV32I instructions, RV32I_ALUInst (instructions about operations), RV32I_BRUInst (instructions about jumps), RV32I_LSUInst (instructions about memory operations). In addition, there are RVZicsrInst (instructions about CSR) and Privileged (instructions about privileged levels).

It needs to be constructed according to the following example format based on the contents of the table:
object RV32I_ALUInst extends HasNPCParameter 
with TYPE_INST
{
    def ADDI    = BitPat("b????????????_?????_000_?????_0010011")
    def SLLI    = BitPat("b0000000?????_?????_001_?????_0010011")
    // ...
    val table = Array (
    ADDI    -> List(TYPE_I, FuType.alu, ALUOpType.add, FuSrcType.rfSrc1, FuSrcType.imm),
    SLLI    -> List(TYPE_I, FuType.alu, ALUOpType.sll, FuSrcType.rfSrc1, FuSrcType.imm),
    // ...
    )
}

#### RV32I_ALUInst
**BitPat Table**

| Instruction  | BitPat Mode                     |
|-------|-------------------------------------|
| ADDI  | `b????????????_?????_000_?????_0010011` |
| SLLI  | `b0000000?????_?????_001_?????_0010011` |
| SLTI  | `b????????????_?????_010_?????_0010011` |
| SLTIU | `b????????????_?????_011_?????_0010011` |
| XORI  | `b????????????_?????_100_?????_0010011` |
| SRLI  | `b0000000?????_?????_101_?????_0010011` |
| ORI   | `b????????????_?????_110_?????_0010011` |
| ANDI  | `b????????????_?????_111_?????_0010011` |
| SRAI  | `b0100000?????_?????_101_?????_0010011` |
| ADD   | `b0000000_?????_?????_000_?????_0110011` |
| SLL   | `b0000000_?????_?????_001_?????_0110011` |
| SLT   | `b0000000_?????_?????_010_?????_0110011` |
| SLTU  | `b0000000_?????_?????_011_?????_0110011` |
| XOR   | `b0000000_?????_?????_100_?????_0110011` |
| SRL   | `b0000000_?????_?????_101_?????_0110011` |
| OR    | `b0000000_?????_?????_110_?????_0110011` |
| AND   | `b0000000_?????_?????_111_?????_0110011` |
| SUB   | `b0100000_?????_?????_000_?????_0110011` |
| SRA   | `b0100000_?????_?????_101_?????_0110011` |
| AUIPC   | `b????????????????????_?????_0010111` |
| LUI   | `b????????????????????_?????_0110111` |

**MicroOp Table**
| Instruction | Type    | Functional unit type | Operation Type  | Source 1 Type  | Source 2 Type |
|-------|---------|--------------|-------------|---------------|---------------|
| ADDI  | TYPE_I  | FuType.alu   | ALUOpType.add | FuSrcType.rfSrc1 | FuSrcType.imm |
| SLLI  | TYPE_I  | FuType.alu   | ALUOpType.sll | FuSrcType.rfSrc1 | FuSrcType.imm |
| SLTI  | TYPE_I  | FuType.alu   | ALUOpType.slt | FuSrcType.rfSrc1 | FuSrcType.imm |
| SLTIU | TYPE_I  | FuType.alu   | ALUOpType.sltu | FuSrcType.rfSrc1 | FuSrcType.imm |
| XORI  | TYPE_I  | FuType.alu   | ALUOpType.xor | FuSrcType.rfSrc1 | FuSrcType.imm |
| SRLI  | TYPE_I  | FuType.alu   | ALUOpType.srl | FuSrcType.rfSrc1 | FuSrcType.imm |
| ORI   | TYPE_I  | FuType.alu   | ALUOpType.or | FuSrcType.rfSrc1 | FuSrcType.imm |
| ANDI  | TYPE_I  | FuType.alu   | ALUOpType.and | FuSrcType.rfSrc1 | FuSrcType.imm |
| SRAI  | TYPE_I  | FuType.alu   | ALUOpType.sra | FuSrcType.rfSrc1 | FuSrcType.imm |
| ADD   | TYPE_R  | FuType.alu   | ALUOpType.add | FuSrcType.rfSrc1 | FuSrcType.rfSrc2 |
| SLL   | TYPE_R  | FuType.alu   | ALUOpType.sll | FuSrcType.rfSrc1 | FuSrcType.rfSrc2 |
| SLT   | TYPE_R  | FuType.alu   | ALUOpType.slt | FuSrcType.rfSrc1 | FuSrcType.rfSrc2 |
| SLTU  | TYPE_R  | FuType.alu   | ALUOpType.sltu | FuSrcType.rfSrc1 | FuSrcType.rfSrc2 |
| XOR   | TYPE_R  | FuType.alu   | ALUOpType.xor | FuSrcType.rfSrc1 | FuSrcType.rfSrc2 |
| SRL   | TYPE_R  | FuType.alu   | ALUOpType.srl | FuSrcType.rfSrc1 | FuSrcType.rfSrc2 |
| OR    | TYPE_R  | FuType.alu   | ALUOpType.or | FuSrcType.rfSrc1 | FuSrcType.rfSrc2 |
| AND   | TYPE_R  | FuType.alu   | ALUOpType.and | FuSrcType.rfSrc1 | FuSrcType.rfSrc2 |
| SUB   | TYPE_R  | FuType.alu   | ALUOpType.sub | FuSrcType.rfSrc1 | FuSrcType.rfSrc2 |
| SRA   | TYPE_R  | FuType.alu   | ALUOpType.sra | FuSrcType.rfSrc1 | FuSrcType.rfSrc2 |
| AUIPC | TYPE_U  | FuType.alu   | ALUOpType.add | FuSrcType.pc | FuSrcType.imm |
| LUI   | TYPE_U  | FuType.alu   | ALUOpType.add | FuSrcType.zero | FuSrcType.imm |


#### RV32I_BRUInst
**BitPat Table**
| Instruction  | BitPat Mode                     |
|-------|-------------------------------------|
| JAL   | `b????????????????????_?????_1101111` |
| JALR  | `b????????????_?????_000_?????_1100111` |
| BEQ   | `b???????_?????_?????_000_?????_1100011` |
| BNE   | `b???????_?????_?????_001_?????_1100011` |
| BLT   | `b???????_?????_?????_100_?????_1100011` |
| BGE   | `b???????_?????_?????_101_?????_1100011` |
| BLTU  | `b???????_?????_?????_110_?????_1100011` |
| BGEU  | `b???????_?????_?????_111_?????_1100011` |

**MicroOp Table**
| Instruction | Type    | Functional unit type | Operation Type  | Source 1 Type  | Source 2 Type |
|------|---------|--------------|--------------|---------------|---------------|
| JAL  | TYPE_J  | FuType.alu   | ALUOpType.add | FuSrcType.pc  | FuSrcType.four |
| JALR | TYPE_I  | FuType.alu   | ALUOpType.add | FuSrcType.pc  | FuSrcType.four |
| BEQ  | TYPE_B  | FuType.bru   | ALUOpType.beq | FuSrcType.rfSrc1 | FuSrcType.rfSrc2 |
| BNE  | TYPE_B  | FuType.bru   | ALUOpType.bne | FuSrcType.rfSrc1 | FuSrcType.rfSrc2 |
| BLT  | TYPE_B  | FuType.bru   | ALUOpType.blt | FuSrcType.rfSrc1 | FuSrcType.rfSrc2 |
| BGE  | TYPE_B  | FuType.bru   | ALUOpType.bge | FuSrcType.rfSrc1 | FuSrcType.rfSrc2 |
| BLTU | TYPE_B  | FuType.bru   | ALUOpType.bltu | FuSrcType.rfSrc1 | FuSrcType.rfSrc2 |
| BGEU | TYPE_B  | FuType.bru   | ALUOpType.bgeu | FuSrcType.rfSrc1 | FuSrcType.rfSrc2 |

#### RV32I_LSUInst
**BitPat Table**
| Instruction  | BitPat Mode                     |
|-------|-------------------------------------|
| SB    | `b???????_?????_?????_000_?????_0100011` |
| SH    | `b???????_?????_?????_001_?????_0100011` |
| SW    | `b???????_?????_?????_010_?????_0100011` |
| LB    | `b????????????_?????_000_?????_0000011`  |
| LH    | `b????????????_?????_001_?????_0000011`  |
| LW    | `b????????????_?????_010_?????_0000011`  |
| LBU   | `b????????????_?????_100_?????_0000011`  |
| LHU   | `b????????????_?????_101_?????_0000011`  |


**MicroOp Table**

| Instruction | Type    | Functional unit type | Operation Type  | Source 1 Type  | Source 2 Type |
|-------|---------|--------------|-------------|---------------|---------------|
| SB    | TYPE_S  | FuType.lsu   | LSUOpType.sb | FuSrcType.rfSrc1 | FuSrcType.imm |
| SH    | TYPE_S  | FuType.lsu   | LSUOpType.sh | FuSrcType.rfSrc1 | FuSrcType.imm |
| SW    | TYPE_S  | FuType.lsu   | LSUOpType.sw | FuSrcType.rfSrc1 | FuSrcType.imm |
| LB    | TYPE_I  | FuType.lsu   | LSUOpType.lb | FuSrcType.rfSrc1 | FuSrcType.imm |
| LH    | TYPE_I  | FuType.lsu   | LSUOpType.lh | FuSrcType.rfSrc1 | FuSrcType.imm |
| LW    | TYPE_I  | FuType.lsu   | LSUOpType.lw | FuSrcType.rfSrc1 | FuSrcType.imm |
| LBU   | TYPE_I  | FuType.lsu   | LSUOpType.lbu | FuSrcType.rfSrc1 | FuSrcType.imm |
| LHU   | TYPE_I  | FuType.lsu   | LSUOpType.lhu | FuSrcType.rfSrc1 | FuSrcType.imm |



#### RVZicsrInst & Privileged
**BitPat Table**
| Instruction  | BitPat Mode                     |
|-------|-------------------------------------|
| CSRRW | `b????????????_?????_001_?????_1110011` |
| CSRRS | `b????????????_?????_010_?????_1110011` |

**MicroOp Table**
| Instruction | Type    | Functional unit type | Operation Type  | Source 1 Type  | Source 2 Type |
|-------|---------|--------------|-------------|---------------|---------------|
| CSRRW | TYPE_I  | FuType.csr   | CSROpType.wrt | FuSrcType.rfSrc1 | FuSrcType.imm |
| CSRRS | TYPE_I  | FuType.csr   | CSROpType.set | FuSrcType.rfSrc1 | FuSrcType.imm |


**BitPat Table**
| Instruction  | BitPat Mode                     |
|--------|-------------------------------------|
| ECALL  | `b000000000000_00000_000_00000_1110011` |
| EBREAK | `b000000000001_00000_000_00000_1110011` |
| MRET   | `b001100000010_00000_000_00000_1110011` |

**MicroOp Table**
| Instruction | Type    | Functional unit type | Operation Type  | Source 1 Type  | Source 2 Type |
|--------|---------|---------------|----------------|----------------|----------------|
| ECALL  | TYPE_I  | FuType.csr    | CSROpType.jmp  | FuSrcType.rfSrc1 | FuSrcType.imm  |
| EBREAK | TYPE_I  | FuType.csr    | CSROpType.jmp  | FuSrcType.rfSrc1 | FuSrcType.imm  |
| MRET   | TYPE_R  | FuType.csr    | CSROpType.jmp  | FuSrcType.rfSrc1 | FuSrcType.rfSrc2 |

```

Give me the complete Chisel code.


## NOT Method s2-Modern HDL Gen

Please act as a professional Chisel designer. Give me the complete Chisel code.
Notice the relation of tasks.



Give me the complete Chisel code.


## NOT-TAG Method s2-Modern HDL Gen

Please act as a professional Chisel designer. Give me the complete Chisel code.
Notice the relation of tasks.



Give me the complete Chisel code.



## Think Process

