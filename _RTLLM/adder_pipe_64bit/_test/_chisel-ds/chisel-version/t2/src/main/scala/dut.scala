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

  // Pipeline registers for partial sums and carries
  val stage1_sum = Reg(UInt(17.W))
  val stage1_carry = Reg(Bool())
  val stage2_sum = Reg(UInt(33.W))
  val stage2_carry = Reg(Bool())
  val stage3_sum = Reg(UInt(49.W))
  val stage3_carry = Reg(Bool())
  val stage4_sum = Reg(UInt(65.W))

  // Pipeline registers for enable signal
  val stage1_en = RegNext(io.i_en, false.B)
  val stage2_en = RegNext(stage1_en, false.B)
  val stage3_en = RegNext(stage2_en, false.B)
  val stage4_en = RegNext(stage3_en, false.B)

  // Stage 1: Add first 16 bits
  when(io.i_en) {
    val sum = io.adda(15, 0) +& io.addb(15, 0)
    stage1_sum := sum(15, 0)
    stage1_carry := sum(16)
  }

  // Stage 2: Add next 16 bits with carry from stage 1
  when(stage1_en) {
    val sum = io.adda(31, 16) +& io.addb(31, 16) + stage1_carry
    stage2_sum := Cat(sum(15, 0), stage1_sum)
    stage2_carry := sum(16)
  }

  // Stage 3: Add next 16 bits with carry from stage 2
  when(stage2_en) {
    val sum = io.adda(47, 32) +& io.addb(47, 32) + stage2_carry
    stage3_sum := Cat(sum(15, 0), stage2_sum)
    stage3_carry := sum(16)
  }

  // Stage 4: Add last 16 bits with carry from stage 3
  when(stage3_en) {
    val sum = io.adda(63, 48) +& io.addb(63, 48) + stage3_carry
    stage4_sum := Cat(sum(16, 0), stage3_sum)
  }

  // Output result and enable signal
  io.result := stage4_sum
  io.o_en := stage4_en
}

/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(), Array("--target-dir", "generated"))
}
*/
