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
  val adda_reg1 = RegNext(io.adda, 0.U(64.W))
  val adda_reg2 = RegNext(adda_reg1, 0.U(64.W))
  val adda_reg3 = RegNext(adda_reg2, 0.U(64.W))
  
  val addb_reg1 = RegNext(io.addb, 0.U(64.W))
  val addb_reg2 = RegNext(addb_reg1, 0.U(64.W))
  val addb_reg3 = RegNext(addb_reg2, 0.U(64.W))

  // Pipeline registers for enable signal
  val i_en_reg1 = RegNext(io.i_en, false.B)
  val i_en_reg2 = RegNext(i_en_reg1, false.B)
  val i_en_reg3 = RegNext(i_en_reg2, false.B)
  val i_en_reg4 = RegNext(i_en_reg3, false.B)

  // Stage 1: Add bits [15:0]
  val sum1 = Wire(UInt(17.W))
  val carry1 = Wire(UInt(1.W))
  sum1 := io.adda(15, 0) +& io.addb(15, 0)
  carry1 := sum1(16)
  
  val sum1_reg = RegNext(sum1(15, 0), 0.U(16.W))
  val carry1_reg = RegNext(carry1, 0.U(1.W))

  // Stage 2: Add bits [31:16]
  val sum2 = Wire(UInt(17.W))
  val carry2 = Wire(UInt(1.W))
  sum2 := adda_reg1(31, 16) +& addb_reg1(31, 16) +& carry1_reg
  carry2 := sum2(16)
  
  val sum2_reg = RegNext(sum2(15, 0), 0.U(16.W))
  val carry2_reg = RegNext(carry2, 0.U(1.W))
  val sum1_reg2 = RegNext(sum1_reg, 0.U(16.W))

  // Stage 3: Add bits [47:32]
  val sum3 = Wire(UInt(17.W))
  val carry3 = Wire(UInt(1.W))
  sum3 := adda_reg2(47, 32) +& addb_reg2(47, 32) +& carry2_reg
  carry3 := sum3(16)
  
  val sum3_reg = RegNext(sum3(15, 0), 0.U(16.W))
  val carry3_reg = RegNext(carry3, 0.U(1.W))
  val sum2_reg2 = RegNext(sum2_reg, 0.U(16.W))
  val sum1_reg3 = RegNext(sum1_reg2, 0.U(16.W))

  // Stage 4: Add bits [63:48]
  val sum4 = Wire(UInt(17.W))
  sum4 := adda_reg3(63, 48) +& addb_reg3(63, 48) +& carry3_reg
  
  val sum4_reg = RegNext(sum4, 0.U(17.W))
  val sum3_reg2 = RegNext(sum3_reg, 0.U(16.W))
  val sum2_reg3 = RegNext(sum2_reg2, 0.U(16.W))
  val sum1_reg4 = RegNext(sum1_reg3, 0.U(16.W))

  // Concatenate final result
  io.result := Cat(sum4_reg, sum3_reg2, sum2_reg3, sum1_reg4)
  
  // Output enable signal
  io.o_en := i_en_reg4
}

/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut, Array("--target-dir", "generated"))
}
*/
