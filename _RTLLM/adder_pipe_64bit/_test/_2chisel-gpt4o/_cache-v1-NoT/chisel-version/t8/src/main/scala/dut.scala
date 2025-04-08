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

  // Task 2: create registers for pipeline stages
  val stage1_sum = RegInit(0.U(17.W))
  val stage2_sum = RegInit(0.U(17.W))
  val stage3_sum = RegInit(0.U(17.W))
  val stage4_sum = RegInit(0.U(17.W))

  // Task 2: create registers for enable signal through pipeline
  val en_stage1 = RegNext(io.i_en, init = false.B)
  val en_stage2 = RegNext(en_stage1, init = false.B)
  val en_stage3 = RegNext(en_stage2, init = false.B)
  val en_stage4 = RegNext(en_stage3, init = false.B)

  // Task 3: Implement the first pipeline stage
  when(io.i_en) {
    val sum0 = io.adda(15, 0) +& io.addb(15, 0)
    stage1_sum := sum0
  }

  // Task 4: Implement the second pipeline stage
  when(en_stage1) {
    val sum1 = io.adda(31, 16) +& io.addb(31, 16) + stage1_sum(16)
    stage2_sum := sum1
  }

  // Task 5: Implement the third pipeline stage
  when(en_stage2) {
    val sum2 = io.adda(47, 32) +& io.addb(47, 32) + stage2_sum(16)
    stage3_sum := sum2
  }

  // Task 6: Implement the fourth pipeline stage
  when(en_stage3) {
    val sum3 = io.adda(63, 48) +& io.addb(63, 48) + stage3_sum(16)
    stage4_sum := sum3
  }

  // Task 7: Update o_en signal
  io.o_en := en_stage4

  // Task 8: Connect pipeline outputs to the module's output ports
  io.result := Cat(stage4_sum(16), stage4_sum(15, 0), stage3_sum(15, 0), stage2_sum(15, 0), stage1_sum(15, 0))
}
