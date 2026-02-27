import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val i_en = Input(Bool()) // Enable signal for addition operation
    val adda = Input(UInt(64.W)) // 64-bit input operand A
    val addb = Input(UInt(64.W)) // 64-bit input operand B
    val result = Output(UInt(65.W)) // 65-bit output representing the sum of adda and addb
    val o_en = Output(Bool()) // Output enable signal
  })

  // Pipeline registers for 4 stages
  val stageRegs = RegInit(VecInit(Seq.fill(4)(0.U(65.W))))
  val enableRegs = RegInit(VecInit(Seq.fill(4)(false.B)))

  // Split the 64-bit inputs into 4 parts (16 bits each)
  val addaParts = Wire(Vec(4, UInt(16.W)))
  val addbParts = Wire(Vec(4, UInt(16.W)))

  for (i <- 0 until 4) {
    addaParts(i) := io.adda(16 * (i + 1) - 1, 16 * i)
    addbParts(i) := io.addb(16 * (i + 1) - 1, 16 * i)
  }

  // Carry signals for each stage
  val carry = Wire(Vec(5, UInt(1.W)))
  carry(0) := 0.U // Initial carry is 0

  // Pipeline stages
  for (i <- 0 until 4) {
    val sum = addaParts(i) +& addbParts(i) + carry(i) // 17-bit result (16-bit sum + 1-bit carry)
    stageRegs(i) := sum
    carry(i + 1) := sum(16) // Carry out for the next stage
  }

  // Pipeline the enable signal
  enableRegs(0) := io.i_en
  for (i <- 1 until 4) {
    enableRegs(i) := enableRegs(i - 1)
  }

  // Combine the results from all stages
  val finalResult = stageRegs(3)(15, 0) ## stageRegs(2)(15, 0) ## stageRegs(1)(15, 0) ## stageRegs(0)(15, 0)
  io.result := finalResult + (carry(4) << 64) // 65-bit result with final carry

  // Output enable signal
  io.o_en := enableRegs(3)
}

/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(), Array("--target-dir", "generated"))
}
*/
