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
  val stage0_sum = Reg(UInt(17.W)) // 16 bits sum + carry out
  val stage1_sum = Reg(UInt(33.W)) // 32 bits sum + carry out
  val stage2_sum = Reg(UInt(49.W)) // 48 bits sum + carry out
  val stage3_sum = Reg(UInt(65.W)) // 64 bits sum + carry out

  val stage0_en = RegInit(false.B)
  val stage1_en = RegInit(false.B)
  val stage2_en = RegInit(false.B)
  val stage3_en = RegInit(false.B)

  // Stage 0: Add lower 16 bits with carry
  when(io.i_en) {
    val part0_sum = io.adda(15, 0) +& io.addb(15, 0)
    stage0_sum := part0_sum
    stage0_en := io.i_en
  } .otherwise {
    stage0_en := false.B
  }

  // Stage 1: Add next 16 bits with carry from stage 0
  when(stage0_en) {
    val part1_sum = io.adda(31, 16) +& io.addb(31, 16) + stage0_sum(16)
    stage1_sum := Cat(part1_sum, stage0_sum(15, 0))
    stage1_en := stage0_en
  } .otherwise {
    stage1_en := false.B
  }

  // Stage 2: Add next 16 bits with carry from stage 1
  when(stage1_en) {
    val part2_sum = io.adda(47, 32) +& io.addb(47, 32) + stage1_sum(32)
    stage2_sum := Cat(part2_sum, stage1_sum(31, 0))
    stage2_en := stage1_en
  } .otherwise {
    stage2_en := false.B
  }

  // Stage 3: Add upper 16 bits with carry from stage 2
  when(stage2_en) {
    val part3_sum = io.adda(63, 48) +& io.addb(63, 48) + stage2_sum(48)
    stage3_sum := Cat(part3_sum, stage2_sum(47, 0))
    stage3_en := stage2_en
  } .otherwise {
    stage3_en := false.B
  }

  // Output results
  io.result := stage3_sum
  io.o_en := stage3_en
}

