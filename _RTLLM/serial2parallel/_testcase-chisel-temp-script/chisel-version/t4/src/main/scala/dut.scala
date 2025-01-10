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

  // Pipeline Registers for Enable signals
  val en_reg1 = RegNext(io.i_en, init = false.B)
  val en_reg2 = RegNext(en_reg1, init = false.B)
  val en_reg3 = RegNext(en_reg2, init = false.B)
  val en_reg4 = RegNext(en_reg3, init = false.B)

  // Pipeline Registers for Operand Segments and Carry signals
  val adda_Reg0 = io.adda(15, 0)
  val addb_Reg0 = io.addb(15, 0)

  // First Stage
  val (sum0, carry0) = if (en_reg1) adda_Reg0 +& addb_Reg0 else (0.U(16.W), 0.U(1.W))

  val sum0_Reg = RegNext(sum0)
  val carry0_Reg = RegNext(carry0(0))

  // Second Stage
  val adda_Reg1 = io.adda(31, 16)
  val addb_Reg1 = io.addb(31, 16)

  val (sum1, carry1) = if (en_reg2) adda_Reg1 +& addb_Reg1 + carry0_Reg else (0.U(16.W), 0.U(1.W))

  val sum1_Reg = RegNext(sum1)
  val carry1_Reg = RegNext(carry1(0))

  // Third Stage
  val adda_Reg2 = io.adda(47, 32)
  val addb_Reg2 = io.addb(47, 32)

  val (sum2, carry2) = if (en_reg3) adda_Reg2 +& addb_Reg2 + carry1_Reg else (0.U(16.W), 0.U(1.W))

  val sum2_Reg = RegNext(sum2)
  val carry2_Reg = RegNext(carry2(0))

  // Fourth Stage
  val adda_Reg3 = io.adda(63, 48)
  val addb_Reg3 = io.addb(63, 48)

  val (sum3, carry3) = if (en_reg4) adda_Reg3 +& addb_Reg3 + carry2_Reg else (0.U(16.W), 0.U(1.W))

  // Result construction
  io.result := Cat(carry3, sum3_Reg, sum2_Reg, sum1_Reg, sum0_Reg)
  io.o_en := en_reg4
}

