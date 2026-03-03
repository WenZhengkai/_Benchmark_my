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
  val en_reg0 = RegNext(io.i_en, false.B)
  val en_reg1 = RegNext(en_reg0, false.B)
  val en_reg2 = RegNext(en_reg1, false.B)
  val en_reg3 = RegNext(en_reg2, false.B)

  // Carry registers for each stage
  val carry0 = RegInit(0.U(1.W))
  val carry1 = RegInit(0.U(1.W))
  val carry2 = RegInit(0.U(1.W))
  val carry3 = RegInit(0.U(1.W))

  // Sum registers for each stage
  val sum0 = RegInit(0.U(16.W))
  val sum1 = RegInit(0.U(16.W))
  val sum2 = RegInit(0.U(16.W))
  val sum3 = RegInit(0.U(16.W))

  // Stage 0: Add bits [15:0] with carry_in = 0
  val stage0_sum = io.adda(15, 0) +& io.addb(15, 0)
  when(io.i_en) {
    sum0   := stage0_sum(15, 0)
    carry0 := stage0_sum(16)
  }.otherwise {
    sum0   := 0.U
    carry0 := 0.U
  }

  // Stage 1: Add bits [31:16] with carry from stage 0
  val stage1_sum = adda_reg0(31, 16) +& addb_reg0(31, 16) +& carry0
  when(en_reg0) {
    sum1   := stage1_sum(15, 0)
    carry1 := stage1_sum(16)
  }.otherwise {
    sum1   := 0.U
    carry1 := 0.U
  }

  // Stage 2: Add bits [47:32] with carry from stage 1
  val stage2_sum = adda_reg1(47, 32) +& addb_reg1(47, 32) +& carry1
  when(en_reg1) {
    sum2   := stage2_sum(15, 0)
    carry2 := stage2_sum(16)
  }.otherwise {
    sum2   := 0.U
    carry2 := 0.U
  }

  // Stage 3: Add bits [63:48] with carry from stage 2
  val stage3_sum = adda_reg2(63, 48) +& addb_reg2(63, 48) +& carry2
  when(en_reg2) {
    sum3   := stage3_sum(15, 0)
    carry3 := stage3_sum(16)
  }.otherwise {
    sum3   := 0.U
    carry3 := 0.U
  }

  // Combine all partial sums to form the final result
  io.result := Cat(carry3, sum3, sum2, sum1, sum0)
  
  // Output enable signal
  io.o_en := en_reg3
}

/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut, Array("--target-dir", "generated"))
}
*/
