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

  // Define registers for the pipeline stages
  val stage1_en = RegNext(io.i_en, init = false.B)
  val stage1_adda = RegNext(io.adda, init = 0.U(64.W))
  val stage1_addb = RegNext(io.addb, init = 0.U(64.W))

  val stage2_en = RegNext(stage1_en, init = false.B)
  val stage2_sum = RegInit(0.U(17.W)) // 16 bits of sum plus potential carry out

  val stage3_en = RegNext(stage2_en, init = false.B)
  val stage3_sum = RegInit(0.U(33.W)) // 32 bits of sum plus carry

  val stage4_en = RegNext(stage3_en, init = false.B)
  val stage4_sum = RegInit(0.U(49.W)) // 48 bits of sum plus carry

  val finalResult = RegInit(0.U(65.W))
  val finalEn = RegNext(stage4_en, init = false.B)

  // Stage 1: Add the least significant 16 bits
  val stage1_sum = stage1_adda(15, 0) +& stage1_addb(15, 0)

  // Stage 2: Add the next 16 bits, including carry from stage 1
  val stage2_sum_temp = stage1_adda(31, 16) +& stage1_addb(31, 16) + stage1_sum(16)
  when(stage2_en) {
    stage2_sum := Cat(stage2_sum_temp(16), stage1_sum(15,0)) // Capture carry and sum
  }

  // Stage 3: Add the next 16 bits, including carry from stage 2
  val stage3_sum_temp = stage1_adda(47, 32) +& stage1_addb(47, 32) + stage2_sum(16)
  when(stage3_en) {
    stage3_sum := Cat(stage3_sum_temp(16), stage2_sum(15,0)) // Capture carry and sum
  }

  // Stage 4: Add the most significant 16 bits, including carry from stage 3
  val stage4_sum_temp = stage1_adda(63, 48) +& stage1_addb(63, 48) + stage3_sum(16)
  when(stage4_en) {
    stage4_sum := Cat(stage4_sum_temp(16), stage3_sum(15,0)) // Capture carry and sum
  }

  // Final result capturing all sums and carry
  when(finalEn) {
    finalResult := Cat(stage4_sum(16), stage4_sum(15,0)) // Final carry and sum
  }

  // Connecting output
  io.result := finalResult
  io.o_en := finalEn
}


