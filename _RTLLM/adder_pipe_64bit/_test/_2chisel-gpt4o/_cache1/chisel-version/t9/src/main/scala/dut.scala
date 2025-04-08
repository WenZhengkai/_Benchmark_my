
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
  val stage1_sum = RegInit(0.U(17.W)) // 16 bits + carry
  val stage2_sum = RegInit(0.U(17.W))
  val stage3_sum = RegInit(0.U(17.W))
  val stage4_sum = RegInit(0.U(17.W))
  
  val stage1_en = RegInit(false.B)
  val stage2_en = RegInit(false.B)
  val stage3_en = RegInit(false.B)
  val stage4_en = RegInit(false.B)

  // Split inputs into 16-bit segments
  val partsA = io.adda.asTypeOf(Vec(4, UInt(16.W)))
  val partsB = io.addb.asTypeOf(Vec(4, UInt(16.W)))

  // Stage 1
  when(io.i_en) {
    val (sum0, carry0) = partsA(0) +& partsB(0)
    stage1_sum := Cat(carry0, sum0)
    stage1_en := true.B
  }.otherwise {
    stage1_en := false.B
  }

  // Stage 2
  when(stage1_en) {
    val (sum1, carry1) = partsA(1) +& partsB(1) + stage1_sum(16)
    stage2_sum := Cat(carry1, sum1)
    stage2_en := true.B
  }.otherwise {
    stage2_en := false.B
  }

  // Stage 3
  when(stage2_en) {
    val (sum2, carry2) = partsA(2) +& partsB(2) + stage2_sum(16)
    stage3_sum := Cat(carry2, sum2)
    stage3_en := true.B
  }.otherwise {
    stage3_en := false.B
  }

  // Stage 4
  when(stage3_en) {
    val (sum3, carry3) = partsA(3) +& partsB(3) + stage3_sum(16)
    stage4_sum := Cat(carry3, sum3)
    stage4_en := true.B
  }.otherwise {
    stage4_en := false.B
  }

  // Final result and output enable
  io.result := Cat(stage4_sum(16), stage4_sum(15,0), stage3_sum(15,0), stage2_sum(15,0), stage1_sum(15,0))
  io.o_en := stage4_en
}
