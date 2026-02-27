import chisel3._

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

  // ===== Constants Definitions =====
  // Opcode definitions
  val OP_RTYPE      = "b0110011".U(7.W)
  val OP_ITYPE_ARITH = "b0010011".U(7.W)
  val OP_LOAD       = "b0000011".U(7.W)
  val OP_STORE      = "b0100011".U(7.W)
  val OP_BRANCH     = "b1100011".U(7.W)
  val OP_JAL        = "b1101111".U(7.W)
  val OP_JALR       = "b1100111".U(7.W)
  val OP_LUI        = "b0110111".U(7.W)
  val OP_AUIPC      = "b0010111".U(7.W)

  // funct3 definitions
  val F3_ADD   = "b000".U(3.W)
  val F3_SLL   = "b001".U(3.W)
  val F3_SLT   = "b010".U(3.W)
  val F3_SLTU  = "b011".U(3.W)
  val F3_XOR   = "b100".U(3.W)
  val F3_OR    = "b110".U(3.W)
  val F3_AND   = "b111".U(3.W)
  val F3_SR    = "b101".U(3.W)
  val F3_BEQ   = "b000".U(3.W)
  val F3_BNE   = "b001".U(3.W)
  val F3_BLT   = "b100".U(3.W)
  val F3_BGE   = "b101".U(3.W)
  val F3_BLTU  = "b110".U(3.W)
  val F3_BGEU  = "b111".U(3.W)

  // funct7 definitions
  val F7_SUB   = "b0100000".U(7.W)
  val F7_SRA   = "b0100000".U(7.W)
  val F7_ADD   = "b0000000".U(7.W)

  // ALU operation codes
  val ALU_ADD  = "b0000".U(4.W)
  val ALU_SUB  = "b0001".U(4.W)
  val ALU_XOR  = "b0010".U(4.W)
  val ALU_OR   = "b0011".U(4.W)
  val ALU_AND  = "b0100".U(4.W)
  val ALU_SLL  = "b0101".U(4.W)
  val ALU_SRL  = "b0110".U(4.W)
  val ALU_SRA  = "b0111".U(4.W)
  val ALU_SLT  = "b1000".U(4.W)
  val ALU_SLTU = "b1001".U(4.W)

  // memtoreg values
  val MEMTOREG_MEM = "b01".U(2.W)
  val MEMTOREG_ALU = "b10".U(2.W)

  // ===== Default Outputs =====
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

  // ===== Instruction Decoding =====
  when(io.opcode === OP_RTYPE) {
    io.immsrc := 0.U
    io.regwrite := 1.U
    io.memtoreg := MEMTOREG_ALU
    switch(io.funct3) {
      is(F3_ADD) {
        when(io.funct7 === F7_SUB) { io.aluop := ALU_SUB }
          .otherwise { io.aluop := ALU_ADD }
      }
      is(F3_SLL) { io.aluop := ALU_SLL }
      is(F3_XOR) { io.aluop := ALU_XOR }
      is(F3_OR)  { io.aluop := ALU_OR }
      is(F3_AND) { io.aluop := ALU_AND }
      is(F3_SR) {
        when(io.funct7 === F7_SRA) { io.aluop := ALU_SRA }
          .otherwise { io.aluop := ALU_SRL }
      }
      is(F3_SLT) { io.aluop := ALU_SLT }
      is(F3_SLTU) { io.aluop := ALU_SLTU }
    }
  }.elsewhen(io.opcode === OP_ITYPE_ARITH) {
    io.immsrc := 1.U
    io.regwrite := 1.U
    io.memtoreg := MEMTOREG_ALU
    switch(io.funct3) {
      is(F3_SLL) { io.aluop := ALU_SLL }
      is(F3_SR) {
        when(io.funct7 === F7_SRA) { io.aluop := ALU_SRA }
          .otherwise { io.aluop := ALU_SRL }
      }
      is(F3_ADD) { io.aluop := ALU_ADD }
      is(F3_XOR) { io.aluop := ALU_XOR }
      is(F3_OR)  { io.aluop := ALU_OR }
      is(F3_AND) { io.aluop := ALU_AND }
      is(F3_SLT) { io.aluop := ALU_SLT }
      is(F3_SLTU) { io.aluop := ALU_SLTU }
    }
  }.elsewhen(io.opcode === OP_LOAD) {
    io.aluop := ALU_ADD
    io.immsrc := 1.U
    io.memread := 1.U
    io.regwrite := 1.U
    io.memtoreg := MEMTOREG_MEM
  }.elsewhen(io.opcode === OP_STORE) {
    io.aluop := ALU_ADD
    io.immsrc := 1.U
    io.memwrite := 1.U
  }.elsewhen(io.opcode === OP_BRANCH) {
    io.isbranch := 1.U
    io.aluop := Mux(io.funct3(2), ALU_SLTU, ALU_SLT)  // ALU_SLT or ALU_SLTU based on funct3
  }.elsewhen(io.opcode === OP_JAL) {
    io.isjump := 1.U
    io.immsrc := 1.U
    io.regwrite := 1.U
  }.elsewhen(io.opcode === OP_JALR) {
    io.isjump := 1.U
    io.pcsel := 1.U
    io.immsrc := 1.U
    io.regwrite := 1.U
  }.elsewhen(io.opcode === OP_LUI) {
    io.isupper := 1.U
    io.islui := 1.U
    io.immsrc := 1.U
    io.regwrite := 1.U
  }.elsewhen(io.opcode === OP_AUIPC) {
    io.isupper := 1.U
    io.rdsel := 1.U
    io.immsrc := 1.U
    io.regwrite := 1.U
  }
}

/*
object dutDriver extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut)
}
*/
