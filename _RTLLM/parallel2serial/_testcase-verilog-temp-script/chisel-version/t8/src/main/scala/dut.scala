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

  // Define registers for pipelining
  val stage1_reg = RegInit(0.U(16.W))
  val stage1_carry_reg = RegInit(0.U(1.W))
  
  val stage2_reg = RegInit(0.U(16.W))
  val stage2_carry_reg = RegInit(0.U(1.W))
  
  val stage3_reg = RegInit(0.U(16.W))
  val stage3_carry_reg = RegInit(0.U(1.W))
  
  val stage4_reg = RegInit(0.U(16.W))
  val final_carry = RegInit(0.U(1.W))
  
  val enable_pipeline = RegInit(false.B)
  val stage1_en = enable_pipeline && io.i_en
  val stage2_en = RegNext(stage1_en)
  val stage3_en = RegNext(stage2_en)
  val stage4_en = RegNext(stage3_en)
  io.o_en := stage4_en

  when(io.i_en) {
    enable_pipeline := true.B
  }.otherwise {
    enable_pipeline := false.B
  }
  
  // Stage 1: Add lower 16 bits
  when(stage1_en) {
    val (sum0, carry0) = (io.adda(15, 0) +& io.addb(15, 0)).asUInt.splitAt(16)
    stage1_reg := sum0
    stage1_carry_reg := carry0
  }

  // Stage 2: Add next 16 bits with carry from stage 1
  when(stage2_en) {
    val (sum1, carry1) = (io.adda(31, 16) +& io.addb(31, 16) + stage1_carry_reg).asUInt.splitAt(16)
    stage2_reg := sum1
    stage2_carry_reg := carry1
  }

  // Stage 3: Add next 16 bits with carry from stage 2
  when(stage3_en) {
    val (sum2, carry2) = (io.adda(47, 32) +& io.addb(47, 32) + stage2_carry_reg).asUInt.splitAt(16)
    stage3_reg := sum2
    stage3_carry_reg := carry2
  }

  // Stage 4: Add upper 16 bits with carry from stage 3
  when(stage4_en) {
    val (sum3, carry3) = (io.adda(63, 48) +& io.addb(63, 48) + stage3_carry_reg).asUInt.splitAt(16)
    stage4_reg := sum3
    final_carry := carry3
  }

  // Construct the 65-bit result
  io.result := Cat(final_carry, stage4_reg, stage3_reg, stage2_reg, stage1_reg)
}

