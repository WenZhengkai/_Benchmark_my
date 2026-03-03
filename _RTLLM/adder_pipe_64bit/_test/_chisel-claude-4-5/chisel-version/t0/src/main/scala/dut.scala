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

  // Pipeline registers for operands
  val adda_reg0 = RegNext(io.adda, 0.U)
  val adda_reg1 = RegNext(adda_reg0, 0.U)
  val adda_reg2 = RegNext(adda_reg1, 0.U)
  
  val addb_reg0 = RegNext(io.addb, 0.U)
  val addb_reg1 = RegNext(addb_reg0, 0.U)
  val addb_reg2 = RegNext(addb_reg1, 0.U)

  // Pipeline registers for enable signal
  val i_en_reg0 = RegNext(io.i_en, false.B)
  val i_en_reg1 = RegNext(i_en_reg0, false.B)
  val i_en_reg2 = RegNext(i_en_reg1, false.B)
  val i_en_reg3 = RegNext(i_en_reg2, false.B)

  // Pipeline registers for partial sums and carry signals
  val sum_stage0 = RegInit(0.U(16.W))
  val sum_stage1 = RegInit(0.U(16.W))
  val sum_stage2 = RegInit(0.U(16.W))
  val sum_stage3 = RegInit(0.U(16.W))
  
  val carry_stage0 = RegInit(0.U(1.W))
  val carry_stage1 = RegInit(0.U(1.W))
  val carry_stage2 = RegInit(0.U(1.W))
  val carry_stage3 = RegInit(0.U(1.W))

  // Stage 0: Add bits [15:0] with carry_in = 0
  val stage0_a = io.adda(15, 0)
  val stage0_b = io.addb(15, 0)
  val stage0_sum = stage0_a +& stage0_b  // 17-bit result
  sum_stage0 := stage0_sum(15, 0)
  carry_stage0 := stage0_sum(16)

  // Stage 1: Add bits [31:16] with carry from stage 0
  val stage1_a = adda_reg0(31, 16)
  val stage1_b = addb_reg0(31, 16)
  val stage1_sum = stage1_a +& stage1_b +& carry_stage0  // 17-bit result
  sum_stage1 := stage1_sum(15, 0)
  carry_stage1 := stage1_sum(16)

  // Stage 2: Add bits [47:32] with carry from stage 1
  val stage2_a = adda_reg1(47, 32)
  val stage2_b = addb_reg1(47, 32)
  val stage2_sum = stage2_a +& stage2_b +& carry_stage1  // 17-bit result
  sum_stage2 := stage2_sum(15, 0)
  carry_stage2 := stage2_sum(16)

  // Stage 3: Add bits [63:48] with carry from stage 2
  val stage3_a = adda_reg2(63, 48)
  val stage3_b = addb_reg2(63, 48)
  val stage3_sum = stage3_a +& stage3_b +& carry_stage2  // 17-bit result
  sum_stage3 := stage3_sum(15, 0)
  carry_stage3 := stage3_sum(16)

  // Output result: Concatenate all partial sums and final carry
  io.result := Cat(carry_stage3, sum_stage3, sum_stage2, sum_stage1, sum_stage0)

  // Output enable signal
  io.o_en := i_en_reg3
}

/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut, Array("--target-dir", "generated"))
}
*/
