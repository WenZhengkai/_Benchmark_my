import chisel3._

class dut extends Module {
  val io = IO(new Bundle {
    val i_en = Input(Bool())
    val adda = Input(UInt(64.W))
    val addb = Input(UInt(64.W))
    val result = Output(UInt(65.W))
    val o_en = Output(Bool())
  })

  // Pipeline registers
  val en_stage1 = RegInit(false.B)
  val en_stage2 = RegInit(false.B)
  val en_stage3 = RegInit(false.B)
  val en_stage4 = RegInit(false.B)

  val sum_stage1 = RegInit(0.U(17.W))
  val sum_stage2 = RegInit(0.U(17.W))
  val sum_stage3 = RegInit(0.U(17.W))
  val sum_stage4 = RegInit(0.U(17.W))

  val carry_out_stage1 = RegInit(0.U(1.W))
  val carry_out_stage2 = RegInit(0.U(1.W))
  val carry_out_stage3 = RegInit(0.U(1.W))
  
  when(io.i_en) {
    // Task 3: First stage - 16 LSB
    val sum1 = io.adda(15, 0) + io.addb(15, 0)
    sum_stage1 := sum1
    carry_out_stage1 := sum1(16)
    en_stage1 := io.i_en

    // Task 4: Second stage - next 16 bits
    val sum2 = io.adda(31, 16) + io.addb(31, 16) + carry_out_stage1
    sum_stage2 := sum2
    carry_out_stage2 := sum2(16)
    en_stage2 := en_stage1

    // Task 5: Third stage - third 16 bits
    val sum3 = io.adda(47, 32) + io.addb(47, 32) + carry_out_stage2
    sum_stage3 := sum3
    carry_out_stage3 := sum3(16)
    en_stage3 := en_stage2

    // Task 6: Fourth stage - final 16 MSB
    val sum4 = io.adda(63, 48) + io.addb(63, 48) + carry_out_stage3
    sum_stage4 := sum4
    en_stage4 := en_stage3
  }

  // Task 7: Handle output enable signal
  io.o_en := en_stage4

  // Task 8: Combine results
  io.result := Cat(sum_stage4(16, 0), sum_stage3(15, 0), sum_stage2(15, 0), sum_stage1(15, 0))
}
