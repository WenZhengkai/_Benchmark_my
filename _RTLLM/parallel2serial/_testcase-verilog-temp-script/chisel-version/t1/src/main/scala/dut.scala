import chisel3._

class dut extends Module {
  val io = IO(new Bundle {
    val i_en = Input(Bool())
    val adda = Input(UInt(64.W))
    val addb = Input(UInt(64.W))
    val result = Output(UInt(65.W))
    val o_en = Output(Bool())
  })

  // Pipeline registers to hold intermediate results
  val stage1_en = RegNext(io.i_en, init = false.B)
  val stage2_en = RegNext(stage1_en, init = false.B)
  val stage3_en = RegNext(stage2_en, init = false.B)
  val stage4_en = RegNext(stage3_en, init = false.B)
  
  val stage1_sum = RegInit(0.U(17.W))
  val stage2_sum = RegInit(0.U(33.W))
  val stage3_sum = RegInit(0.U(49.W))
  val stage4_sum = RegInit(0.U(65.W))
  
  when(io.i_en) {
    // Stage 1
    val part1_a = io.adda(15, 0)
    val part1_b = io.addb(15, 0)
    val part1_res = part1_a +& part1_b
    stage1_sum := part1_res

    // Stage 2
    val part2_a = io.adda(31, 16)
    val part2_b = io.addb(31, 16)
    val part2_res = part2_a +& part2_b + stage1_sum(16)
    stage2_sum := Cat(part2_res, stage1_sum(15, 0))

    // Stage 3
    val part3_a = io.adda(47, 32)
    val part3_b = io.addb(47, 32)
    val part3_res = part3_a +& part3_b + stage2_sum(32)
    stage3_sum := Cat(part3_res, stage2_sum(31, 0))

    // Stage 4
    val part4_a = io.adda(63, 48)
    val part4_b = io.addb(63, 48)
    val part4_res = part4_a +& part4_b + stage3_sum(48)
    stage4_sum := Cat(part4_res, stage3_sum(47, 0))
  }

  // Output logic
  io.result := stage4_sum
  io.o_en := stage4_en
}
