import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val i_en  = Input(Bool())       // Enable signal for addition operation
    val adda  = Input(UInt(64.W))   // 64-bit input operand A
    val addb  = Input(UInt(64.W))   // 64-bit input operand B
    val result = Output(UInt(65.W)) // 65-bit output representing the sum of adda and addb
    val o_en  = Output(Bool())      // Output enable signal
  })

  // Registers for pipeline stages
  val stage1_sum  = RegInit(0.U(17.W))
  val stage1_carry = RegInit(false.B)
  val stage2_sum  = RegInit(0.U(33.W))
  val stage2_carry = RegInit(false.B)
  val stage3_sum  = RegInit(0.U(49.W))
  val stage3_carry = RegInit(false.B)
  val stage4_sum  = RegInit(0.U(65.W))
  val stage4_carry = RegInit(false.B)

  // Pipeline enable signals
  val stage1_en = RegInit(false.B)
  val stage2_en = RegInit(false.B)
  val stage3_en = RegInit(false.B)
  val stage4_en = RegInit(false.B)

  // Pipeline logic
  when(io.i_en) {
    // Stage 1: Add first 16 bits
    val sum1 = io.adda(15, 0) + io.addb(15, 0)
    stage1_sum := sum1
    stage1_carry := sum1(16)
    stage1_en := true.B
  }.otherwise {
    stage1_en := false.B
  }

  when(stage1_en) {
    // Stage 2: Add next 16 bits with carry from stage 1
    val sum2 = io.adda(31, 16) + io.addb(31, 16) + stage1_carry.asUInt
    stage2_sum := Cat(sum2, stage1_sum(15, 0))
    stage2_carry := sum2(16)
    stage2_en := true.B
  }.otherwise {
    stage2_en := false.B
  }

  when(stage2_en) {
    // Stage 3: Add next 16 bits with carry from stage 2
    val sum3 = io.adda(47, 32) + io.addb(47, 32) + stage2_carry.asUInt
    stage3_sum := Cat(sum3, stage2_sum(31, 0))
    stage3_carry := sum3(16)
    stage3_en := true.B
  }.otherwise {
    stage3_en := false.B
  }

  when(stage3_en) {
    // Stage 4: Add last 16 bits with carry from stage 3
    val sum4 = io.adda(63, 48) + io.addb(63, 48) + stage3_carry.asUInt
    stage4_sum := Cat(sum4, stage3_sum(47, 0))
    stage4_carry := sum4(16)
    stage4_en := true.B
  }.otherwise {
    stage4_en := false.B
  }

  // Output logic
  io.result := stage4_sum
  io.o_en := stage4_en
}

// Generate Verilog
/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut)
}
*/
