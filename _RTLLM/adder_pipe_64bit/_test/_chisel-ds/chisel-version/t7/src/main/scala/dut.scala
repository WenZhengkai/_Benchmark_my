import chisel3._
import chisel3.util._

class RippleCarryAdderPipeline extends Module {
  val io = IO(new Bundle {
    val i_en = Input(Bool())
    val adda = Input(UInt(64.W))
    val addb = Input(UInt(64.W))
    val result = Output(UInt(65.W))
    val o_en = Output(Bool())
  })

  // Pipeline registers
  val stage1_a = RegInit(0.U(16.W))
  val stage1_b = RegInit(0.U(16.W))
  val stage1_carry = RegInit(0.U(1.W))
  val stage1_en = RegInit(false.B)

  val stage2_a = RegInit(0.U(16.W))
  val stage2_b = RegInit(0.U(16.W))
  val stage2_carry = RegInit(0.U(1.W))
  val stage2_en = RegInit(false.B)

  val stage3_a = RegInit(0.U(16.W))
  val stage3_b = RegInit(0.U(16.W))
  val stage3_carry = RegInit(0.U(1.W))
  val stage3_en = RegInit(false.B)

  val stage4_a = RegInit(0.U(16.W))
  val stage4_b = RegInit(0.U(16.W))
  val stage4_carry = RegInit(0.U(1.W))
  val stage4_en = RegInit(false.B)

  // Partial sums and carries
  val sum1 = Wire(UInt(16.W))
  val carry1 = Wire(UInt(1.W))
  val sum2 = Wire(UInt(16.W))
  val carry2 = Wire(UInt(1.W))
  val sum3 = Wire(UInt(16.W))
  val carry3 = Wire(UInt(1.W))
  val sum4 = Wire(UInt(16.W))
  val carry4 = Wire(UInt(1.W))

  // Pipeline stage 1
  when(io.i_en) {
    stage1_a := io.adda(15, 0)
    stage1_b := io.addb(15, 0)
    stage1_carry := 0.U
    stage1_en := true.B
  }.otherwise {
    stage1_en := false.B
  }

  sum1 := stage1_a + stage1_b + stage1_carry
  carry1 := (stage1_a + stage1_b + stage1_carry)(16)

  // Pipeline stage 2
  stage2_a := io.adda(31, 16)
  stage2_b := io.addb(31, 16)
  stage2_carry := carry1
  stage2_en := stage1_en

  sum2 := stage2_a + stage2_b + stage2_carry
  carry2 := (stage2_a + stage2_b + stage2_carry)(16)

  // Pipeline stage 3
  stage3_a := io.adda(47, 32)
  stage3_b := io.addb(47, 32)
  stage3_carry := carry2
  stage3_en := stage2_en

  sum3 := stage3_a + stage3_b + stage3_carry
  carry3 := (stage3_a + stage3_b + stage3_carry)(16)

  // Pipeline stage 4
  stage4_a := io.adda(63, 48)
  stage4_b := io.addb(63, 48)
  stage4_carry := carry3
  stage4_en := stage3_en

  sum4 := stage4_a + stage4_b + stage4_carry
  carry4 := (stage4_a + stage4_b + stage4_carry)(16)

  // Output result
  io.result := Cat(carry4, sum4, sum3, sum2, sum1)
  io.o_en := stage4_en
}

/*
object RippleCarryAdderPipeline extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new RippleCarryAdderPipeline, Array("--target-dir", "generated"))
}
*/
