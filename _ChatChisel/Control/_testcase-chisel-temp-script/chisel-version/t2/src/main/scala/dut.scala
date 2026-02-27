import chisel3._
import chisel3.util._

class dut extends Module {
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

  // Default Signals
  io.aluop := 0.U
  io.immsrc := 0.U
  io.isbranch := 0.U
  io.memread := 0.U
  io.memwrite := 0.U
  io.regwrite := 0.U
  io.memtoreg := 0.U
  io.pcsel := 0.U
  io.rdsel := 0.U
  io.isjump := 0.U
  io.isupper := 0.U
  io.islui := 0.U

  // Define opcode constants
  val OP_RTYPE     = "b0110011".U(7.W)
  val OP_ITYPE_ARITH = "b0010011".U(7.W)
  val OP_LOAD      = "b0000011".U(7.W)
  val OP_STORE     = "b0100011".U(7.W)
  val OP_BRANCH    = "b1100011".U(7.W)
  val OP_JAL       = "b1101111".U(7.W)
  val OP_JALR      = "b1100111".U(7.W)
  val OP_LUI       = "b0110111".U(7.W)
  val OP_AUIPC     = "b0010111".U(7.W)

  // Define funct3 constants
  val F3_ADD    = "b000".U(3.W)
  val F3_SLL    = "b001".U(3.W)
  val F3_SLT    = "b010".U(3.W)
  val F3_SLTI   = "b010".U(3.W)
  val F3_SLTU   = "b011".U(3.W)
  val F3_SLTIU  = "b011".U(3.W)
  val F3_XOR    = "b100".U(3.W)
  val F3_OR     = "b110".U(3.W)
  val F3_AND    = "b111".U(3.W)
  val F3_BEQ    = "b000".U(3.W)
  val F3_BNE    = "b001".U(3.W)
  val F3_BLT    = "b100".U(3.W)
  val F3_BGE    = "b101".U(3.W)
  val F3_BLTU   = "b110".U(3.W)
  val F3_BGEU   = "b111".U(3.W)

  // Define funct7 constants
  val F7_SUB    = "b0100000".U(7.W)
  val F7_SRA    = "b0100000".U(7.W)
  val F7_NORMAL = "b0000000".U(7.W)

  // Define ALU operation codes
  val ALU_ADD    = "b0000".U(4.W)
  val ALU_SUB    = "b0001".U(4.W)
  val ALU_XOR    = "b0010".U(4.W)
  val ALU_OR     = "b0011".U(4.W)
  val ALU_AND    = "b0100".U(4.W)
  val ALU_SLL    = "b0101".U(4.W)
  val ALU_SRL    = "b0110".U(4.W)
  val ALU_SRA    = "b0111".U(4.W)
  val ALU_SLT    = "b1000".U(4.W)
  val ALU_SLTU   = "b1001".U(4.W)

  // Define MemToReg values
  val MEMTOREG_ALU = "b10".U(2.W)
  val MEMTOREG_MEM = "b01".U(2.W)
  val MEMTOREG_PC  = "b00".U(2.W)

  // Control Logic for opcode decoding
  switch(io.opcode) {
    // R-Type Instructions
    is(OP_RTYPE) {
      io.immsrc := 0.U
      io.regwrite := 1.U
      io.memtoreg := MEMTOREG_ALU

      switch(io.funct3) {
        is(F3_ADD) {
          io.aluop := Mux(io.funct7 === F7_SUB, ALU_SUB, ALU_ADD)
        }
        is(F3_SLL) { io.aluop := ALU_SLL }
        is(F3_SLT) { io.aluop := ALU_SLT }
        is(F3_SLTU) { io.aluop := ALU_SLTU }
        is(F3_XOR) { io.aluop := ALU_XOR }
        is(F3_OR) { io.aluop := ALU_OR }
        is(F3_AND) { io.aluop := ALU_AND }
        is(F3_BEQ) { io.aluop := ALU_SRL }
      }
    }

    // I-Type Arithmetic Instructions
    is(OP_ITYPE_ARITH) {
      io.immsrc := 1.U
      io.regwrite := 1.U
      io.memtoreg := MEMTOREG_ALU

      switch(io.funct3) {
        is(F3_SLL) {
          io.aluop := Mux(io.funct7 === F7_SRA, ALU_SRA, ALU_SLL)
        }
        is(F3_XOR) { io.aluop := ALU_XOR }
        is(F3_OR) { io.aluop := ALU_OR }
        is(F3_AND) { io.aluop := ALU_AND }
        is(F3_ADD) { io.aluop := ALU_ADD }
        is(F3_SLTI) { io.aluop := ALU_SLT }
        is(F3_SLTIU) { io.aluop := ALU_SLTU }
      }
    }

    // Load Instructions
    is(OP_LOAD) {
      io.immsrc := 1.U
      io.memread := 1.U
      io.regwrite := 1.U
      io.memtoreg := MEMTOREG_MEM
    }

    // Store Instructions
    is(OP_STORE) {
      io.immsrc := 1.U
      io.memwrite := 1.U
    }

    // Branch Instructions
    is(OP_BRANCH) {
      io.isbranch := 1.U
      io.aluop := Mux(io.funct3 === F3_BGEU || io.funct3 === F3_BLTU, ALU_SLTU, ALU_SLT)
    }

    // JAL Instruction
    is(OP_JAL) {
      io.isjump := 1.U
      io.regwrite := 1.U
      io.immsrc := 1.U
    }

    // JALR Instruction
    is(OP_JALR) {
      io.isjump := 1.U
      io.pcsel := 1.U
      io.regwrite := 1.U
      io.immsrc := 1.U
    }

    // LUI Instruction
    is(OP_LUI) {
      io.isupper := 1.U
      io.islui := 1.U
      io.regwrite := 1.U
      io.immsrc := 1.U
    }

    // AUIPC Instruction
    is(OP_AUIPC) {
      io.isupper := 1.U
      io.rdsel := 1.U
      io.regwrite := 1.U
      io.immsrc := 1.U
    }
  }
}

/*
object dutMain extends App {
  chisel3.Driver.execute(Array[String](), () => new dut)
}
*/
