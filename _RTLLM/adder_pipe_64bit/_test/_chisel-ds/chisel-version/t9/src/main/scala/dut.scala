import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val i_en = Input(Bool())
    val adda = Input(UInt(64.W))
    val addb = Input(UInt(64.W))
    val result = Output(UInt(65.W))
    val o_en = Output(Bool())
  })

  // Pipeline registers
  val stage1Reg = RegInit(0.U(16.W))
  val stage2Reg = RegInit(0.U(16.W))
  val stage3Reg = RegInit(0.U(16.W))
  val stage4Reg = RegInit(0.U(16.W))
  val carryReg = RegInit(0.U(1.W))
  val resultReg = RegInit(0.U(65.W))
  val enableReg = RegInit(VecInit(Seq.fill(4)(false.B)))

  // Pipeline stages
  when(io.i_en) {
    // Stage 1: Add lower 16 bits
    val sum1 = io.adda(15, 0) + io.addb(15, 0)
    stage1Reg := sum1(15, 0)
    carryReg := sum1(16)

    // Stage 2: Add next 16 bits with carry
    val sum2 = io.adda(31, 16) + io.addb(31, 16) + carryReg
    stage2Reg := sum2(15, 0)
    carryReg := sum2(16)

    // Stage 3: Add next 16 bits with carry
    val sum3 = io.adda(47, 32) + io.addb(47, 32) + carryReg
    stage3Reg := sum3(15, 0)
    carryReg := sum3(16)

    // Stage 4: Add upper 16 bits with carry
    val sum4 = io.adda(63, 48) + io.addb(63, 48) + carryReg
    stage4Reg := sum4(15, 0)
    carryReg := sum4(16)

    // Combine results
    resultReg := Cat(carryReg, stage4Reg, stage3Reg, stage2Reg, stage1Reg)
  }

  // Output enable signal pipeline
  enableReg(0) := io.i_en
  for (i <- 1 until 4) {
    enableReg(i) := enableReg(i - 1)
  }
  io.o_en := enableReg(3)

  // Output result
  io.result := resultReg
}

/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(), Array("--target-dir", "generated"))
}
*/
