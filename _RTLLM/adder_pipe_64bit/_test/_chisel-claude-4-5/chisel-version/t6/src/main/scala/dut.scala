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
  val adda_reg0 = RegNext(io.adda, 0.U(64.W))
  val adda_reg1 = RegNext(adda_reg0, 0.U(64.W))
  val adda_reg2 = RegNext(adda_reg1, 0.U(64.W))
  
  val addb_reg0 = RegNext(io.addb, 0.U(64.W))
  val addb_reg1 = RegNext(addb_reg0, 0.U(64.W))
  val addb_reg2 = RegNext(addb_reg1, 0.U(64.W))

  // Pipeline registers for enable signal
  val i_en_reg0 = RegNext(io.i_en, false.B)
  val i_en_reg1 = RegNext(i_en_reg0, false.B)
  val i_en_reg2 = RegNext(i_en_reg1, false.B)
  val i_en_reg3 = RegNext(i_en_reg2, false.B)

  // Stage 0: Add bits [15:0]
  val sum0 = WireDefault(0.U(17.W))
  val carry0 = RegNext(0.U(1.W), 0.U(1.W))
  val sum0_reg = RegNext(0.U(16.W), 0.U(16.W))
  
  sum0 := io.adda(15, 0) +& io.addb(15, 0)
  sum0_reg := sum0(15, 0)
  carry0 := sum0(16)

  // Stage 1: Add bits [31:16]
  val sum1 = WireDefault(0.U(17.W))
  val carry1 = RegNext(0.U(1.W), 0.U(1.W))
  val sum1_reg = RegNext(0.U(16.W), 0.U(16.W))
  
  sum1 := adda_reg0(31, 16) +& addb_reg0(31, 16) +& carry0
  sum1_reg := sum1(15, 0)
  carry1 := sum1(16)

  // Stage 2: Add bits [47:32]
  val sum2 = WireDefault(0.U(17.W))
  val carry2 = RegNext(0.U(1.W), 0.U(1.W))
  val sum2_reg = RegNext(0.U(16.W), 0.U(16.W))
  
  sum2 := adda_reg1(47, 32) +& addb_reg1(47, 32) +& carry1
  sum2_reg := sum2(15, 0)
  carry2 := sum2(16)

  // Stage 3: Add bits [63:48]
  val sum3 = WireDefault(0.U(17.W))
  val carry3 = RegNext(0.U(1.W), 0.U(1.W))
  val sum3_reg = RegNext(0.U(16.W), 0.U(16.W))
  
  sum3 := adda_reg2(63, 48) +& addb_reg2(63, 48) +& carry2
  sum3_reg := sum3(15, 0)
  carry3 := sum3(16)

  // Pipeline registers for partial sums
  val sum0_reg_stage1 = RegNext(sum0_reg, 0.U(16.W))
  val sum0_reg_stage2 = RegNext(sum0_reg_stage1, 0.U(16.W))
  val sum0_reg_stage3 = RegNext(sum0_reg_stage2, 0.U(16.W))
  
  val sum1_reg_stage2 = RegNext(sum1_reg, 0.U(16.W))
  val sum1_reg_stage3 = RegNext(sum1_reg_stage2, 0.U(16.W))
  
  val sum2_reg_stage3 = RegNext(sum2_reg, 0.U(16.W))

  // Assemble final result
  io.result := Cat(carry3, sum3_reg, sum2_reg_stage3, sum1_reg_stage3, sum0_reg_stage3)
  
  // Output enable signal
  io.o_en := i_en_reg3
}

/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(), Array("--target-dir", "generated"))
}
*/
