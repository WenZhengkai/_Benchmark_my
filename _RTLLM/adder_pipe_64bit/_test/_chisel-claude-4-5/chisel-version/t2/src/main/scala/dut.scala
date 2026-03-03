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
  val adda_reg1 = RegNext(io.adda, 0.U)
  val adda_reg2 = RegNext(adda_reg1, 0.U)
  val adda_reg3 = RegNext(adda_reg2, 0.U)
  
  val addb_reg1 = RegNext(io.addb, 0.U)
  val addb_reg2 = RegNext(addb_reg1, 0.U)
  val addb_reg3 = RegNext(addb_reg2, 0.U)

  // Pipeline registers for enable signal
  val i_en_reg1 = RegNext(io.i_en, false.B)
  val i_en_reg2 = RegNext(i_en_reg1, false.B)
  val i_en_reg3 = RegNext(i_en_reg2, false.B)
  val i_en_reg4 = RegNext(i_en_reg3, false.B)

  // Stage 1: Add bits [15:0]
  val sum1 = Wire(UInt(17.W))
  val carry1 = RegNext(0.U(1.W), 0.U)
  val partial_sum1 = RegNext(0.U(16.W), 0.U)
  
  sum1 := io.adda(15, 0) + io.addb(15, 0)
  partial_sum1 := sum1(15, 0)
  carry1 := sum1(16)

  // Stage 2: Add bits [31:16]
  val sum2 = Wire(UInt(17.W))
  val carry2 = RegNext(0.U(1.W), 0.U)
  val partial_sum2 = RegNext(0.U(16.W), 0.U)
  
  sum2 := adda_reg1(31, 16) + addb_reg1(31, 16) + carry1
  partial_sum2 := sum2(15, 0)
  carry2 := sum2(16)

  // Stage 3: Add bits [47:32]
  val sum3 = Wire(UInt(17.W))
  val carry3 = RegNext(0.U(1.W), 0.U)
  val partial_sum3 = RegNext(0.U(16.W), 0.U)
  
  sum3 := adda_reg2(47, 32) + addb_reg2(47, 32) + carry2
  partial_sum3 := sum3(15, 0)
  carry3 := sum3(16)

  // Stage 4: Add bits [63:48]
  val sum4 = Wire(UInt(17.W))
  val carry4 = RegNext(0.U(1.W), 0.U)
  val partial_sum4 = RegNext(0.U(16.W), 0.U)
  
  sum4 := adda_reg3(63, 48) + addb_reg3(63, 48) + carry3
  partial_sum4 := sum4(15, 0)
  carry4 := sum4(16)

  // Combine all partial sums and final carry to form the result
  io.result := Cat(carry4, partial_sum4, partial_sum3, partial_sum2, partial_sum1)
  
  // Output enable signal synchronized with pipeline
  io.o_en := i_en_reg4
}

/*
object dut extends App {
  println("Generating Verilog for 64-bit Ripple Carry Adder with Pipeline")
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(), Array("--target-dir", "generated"))
}
*/
