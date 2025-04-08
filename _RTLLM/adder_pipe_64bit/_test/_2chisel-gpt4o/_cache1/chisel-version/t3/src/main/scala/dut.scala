
import chisel3._
import chisel3.util._

// Define the adder with pipeline stages
class dut extends Module {
  val io = IO(new Bundle {
    val i_en = Input(Bool())
    val adda = Input(UInt(64.W))
    val addb = Input(UInt(64.W))
    val result = Output(UInt(65.W))
    val o_en = Output(Bool())
  })

  // Define the pipeline registers
  val stage1_sum = Reg(UInt(17.W))
  val stage1_carry = Reg(UInt(1.W))

  val stage2_sum = Reg(UInt(17.W))
  val stage2_carry = Reg(UInt(1.W))

  val stage3_sum = Reg(UInt(17.W))
  val stage3_carry = Reg(UInt(1.W))

  val stage4_sum = Reg(UInt(17.W))
  val stage4_carry = Reg(UInt(1.W))

  // Output enable register
  val o_en_reg = RegInit(false.B)

  // Stage 1 - Add the least significant 16 bits
  when (io.i_en) {
    val (s1, c1) = (io.adda(15, 0) +& io.addb(15, 0))
    stage1_sum := s1
    stage1_carry := c1
  }

  // Stage 2 - Add bit 16 to 31 with carry from stage 1
  val stage1_carry_ext = stage1_carry.asUInt
  when (RegNext(io.i_en)) {
    val (s2, c2) = (io.adda(31, 16) +& io.addb(31, 16) + stage1_carry_ext)
    stage2_sum := s2
    stage2_carry := c2
  }

  // Stage 3 - Add bit 32 to 47 with carry from stage 2
  val stage2_carry_ext = stage2_carry.asUInt
  when (RegNext(RegNext(io.i_en))) {
    val (s3, c3) = (io.adda(47, 32) +& io.addb(47, 32) + stage2_carry_ext)
    stage3_sum := s3
    stage3_carry := c3
  }

  // Stage 4 - Add bit 48 to 63 with carry from stage 3
  val stage3_carry_ext = stage3_carry.asUInt
  when (RegNext(RegNext(RegNext(io.i_en)))) {
    val (s4, c4) = (io.adda(63, 48) +& io.addb(63, 48) + stage3_carry_ext)
    stage4_sum := s4
    stage4_carry := c4
    o_en_reg := true.B
  } .otherwise {
    o_en_reg := false.B
  }

  // Construct the final result from all sum parts and the carry out
  io.result := Cat(stage4_carry, stage4_sum, stage3_sum(15, 0), stage2_sum(15, 0), stage1_sum(15, 0))
  io.o_en := o_en_reg
}

