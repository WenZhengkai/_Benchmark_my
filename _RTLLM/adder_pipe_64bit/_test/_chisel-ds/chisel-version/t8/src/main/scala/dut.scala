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
  val stage1_sum = Reg(UInt(16.W))
  val stage1_carry = Reg(Bool())
  val stage1_en = Reg(Bool())

  val stage2_sum = Reg(UInt(16.W))
  val stage2_carry = Reg(Bool())
  val stage2_en = Reg(Bool())

  val stage3_sum = Reg(UInt(16.W))
  val stage3_carry = Reg(Bool())
  val stage3_en = Reg(Bool())

  val stage4_sum = Reg(UInt(16.W))
  val stage4_carry = Reg(Bool())
  val stage4_en = Reg(Bool())

  // Pipeline enable signals
  val pipeline_en = RegInit(VecInit(Seq.fill(4)(false.B)))

  // Pipeline stages
  when(io.i_en) {
    // Stage 1: Add bits [15:0]
    val sum1 = io.adda(15, 0) + io.addb(15, 0)
    stage1_sum := sum1(15, 0)
    stage1_carry := sum1(16)
    stage1_en := true.B

    // Stage 2: Add bits [31:16] with carry from stage 1
    val sum2 = io.adda(31, 16) + io.addb(31, 16) + stage1_carry
    stage2_sum := sum2(15, 0)
    stage2_carry := sum2(16)
    stage2_en := stage1_en

    // Stage 3: Add bits [47:32] with carry from stage 2
    val sum3 = io.adda(47, 32) + io.addb(47, 32) + stage2_carry
    stage3_sum := sum3(15, 0)
    stage3_carry := sum3(16)
    stage3_en := stage2_en

    // Stage 4: Add bits [63:48] with carry from stage 3
    val sum4 = io.adda(63, 48) + io.addb(63, 48) + stage3_carry
    stage4_sum := sum4(15, 0)
    stage4_carry := sum4(16)
    stage4_en := stage3_en
  }.otherwise {
    // Reset pipeline stages when i_en is low
    stage1_sum := 0.U
    stage1_carry := false.B
    stage1_en := false.B

    stage2_sum := 0.U
    stage2_carry := false.B
    stage2_en := false.B

    stage3_sum := 0.U
    stage3_carry := false.B
    stage3_en := false.B

    stage4_sum := 0.U
    stage4_carry := false.B
    stage4_en := false.B
  }

  // Output result and enable signal
  io.result := Cat(stage4_carry, stage4_sum, stage3_sum, stage2_sum, stage1_sum)
  io.o_en := stage4_en
}

// Generate Verilog
/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(), Array("--target-dir", "generated"))
}
*/
