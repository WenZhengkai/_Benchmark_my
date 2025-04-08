
import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val i_en   = Input(Bool())
    val adda   = Input(UInt(64.W))
    val addb   = Input(UInt(64.W))
    val result = Output(UInt(65.W))
    val o_en   = Output(Bool())
  })

  val stage1_out_sum = RegInit(0.U(17.W))
  val stage2_out_sum = RegInit(0.U(33.W))
  val stage3_out_sum = RegInit(0.U(49.W))
  val stage4_out_sum = RegInit(0.U(65.W))

  val stage1_en = RegNext(io.i_en, init = false.B)
  val stage2_en = RegNext(stage1_en, init = false.B)
  val stage3_en = RegNext(stage2_en, init = false.B)
  val stage4_en = RegNext(stage3_en, init = false.B)

  val stage1_sum = io.adda(15, 0) +& io.addb(15, 0)
  val stage2_sum = io.adda(31, 16) +& io.addb(31, 16) + stage1_out_sum(16)
  val stage3_sum = io.adda(47, 32) +& io.addb(47, 32) + stage2_out_sum(32)
  val stage4_sum = io.adda(63, 48) +& io.addb(63, 48) + stage3_out_sum(48)

  when(io.i_en) {
    stage1_out_sum := stage1_sum
  }

  when(stage1_en) {
    stage2_out_sum := Cat(stage2_sum(16, 0), stage1_out_sum(15, 0))
  }

  when(stage2_en) {
    stage3_out_sum := Cat(stage3_sum(16, 0), stage2_out_sum(31, 0))
  }

  when(stage3_en) {
    stage4_out_sum := Cat(stage4_sum(16, 0), stage3_out_sum(47, 0))
  }

  io.result := stage4_out_sum
  io.o_en   := stage4_en
}

