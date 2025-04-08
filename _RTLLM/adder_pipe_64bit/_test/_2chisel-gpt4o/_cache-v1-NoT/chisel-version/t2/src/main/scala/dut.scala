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

  // Pipeline stage registers
  val stage1_sum = Reg(UInt(17.W))
  val stage1_carry = Reg(Bool())
  val stage1_en = Reg(Bool())

  val stage2_sum = Reg(UInt(17.W))
  val stage2_carry = Reg(Bool())
  val stage2_en = Reg(Bool())

  val stage3_sum = Reg(UInt(17.W))
  val stage3_carry = Reg(Bool())
  val stage3_en = Reg(Bool())

  val stage4_sum = Reg(UInt(17.W))
  val o_en_reg = RegInit(false.B)

  // Implement pipelined stages
  when (io.i_en) {
    // Stage 1: Least significant 16 bits
    val stage1_result = io.adda(15, 0) +& io.addb(15, 0)
    stage1_sum := stage1_result
    stage1_carry := stage1_result(16)
    stage1_en := true.B
  }

  when (stage1_en) {
    // Stage 2: Next 16 bits
    val stage2_result = io.adda(31, 16) +& io.addb(31, 16) + stage1_carry
    stage2_sum := stage2_result
    stage2_carry := stage2_result(16)
    stage2_en := true.B
  }

  when (stage2_en) {
    // Stage 3: Third group of 16 bits
    val stage3_result = io.adda(47, 32) +& io.addb(47, 32) + stage2_carry
    stage3_sum := stage3_result
    stage3_carry := stage3_result(16)
    stage3_en := true.B
  }

  when (stage3_en) {
    // Stage 4: Most significant 16 bits
    val stage4_result = io.adda(63, 48) +& io.addb(63, 48) + stage3_carry
    stage4_sum := stage4_result
    o_en_reg := true.B
  }

  // Output logic
  io.result := Cat(stage4_sum, stage3_sum(15, 0), stage2_sum(15, 0), stage1_sum(15, 0))
  io.o_en := o_en_reg
}
