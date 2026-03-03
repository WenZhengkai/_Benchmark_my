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
  val addb_reg0 = RegNext(io.addb, 0.U)
  
  val adda_reg1 = RegNext(adda_reg0, 0.U)
  val addb_reg1 = RegNext(addb_reg0, 0.U)
  
  val adda_reg2 = RegNext(adda_reg1, 0.U)
  val addb_reg2 = RegNext(addb_reg1, 0.U)

  // Pipeline registers for enable signal
  val i_en_reg0 = RegNext(io.i_en, false.B)
  val i_en_reg1 = RegNext(i_en_reg0, false.B)
  val i_en_reg2 = RegNext(i_en_reg1, false.B)
  val i_en_reg3 = RegNext(i_en_reg2, false.B)

  // Stage 0: Add bits [15:0]
  val sum0 = Wire(UInt(17.W))
  val carry0 = Wire(UInt(1.W))
  val temp0 = io.adda(15, 0) +& io.addb(15, 0)
  sum0 := temp0
  carry0 := temp0(16)
  
  val sum0_reg = RegNext(sum0(15, 0), 0.U)
  val carry0_reg = RegNext(carry0, 0.U)

  // Stage 1: Add bits [31:16]
  val sum1 = Wire(UInt(17.W))
  val carry1 = Wire(UInt(1.W))
  val temp1 = adda_reg0(31, 16) +& addb_reg0(31, 16) +& carry0_reg
  sum1 := temp1
  carry1 := temp1(16)
  
  val sum1_reg = RegNext(sum1(15, 0), 0.U)
  val carry1_reg = RegNext(carry1, 0.U)
  val sum0_reg1 = RegNext(sum0_reg, 0.U)

  // Stage 2: Add bits [47:32]
  val sum2 = Wire(UInt(17.W))
  val carry2 = Wire(UInt(1.W))
  val temp2 = adda_reg1(47, 32) +& addb_reg1(47, 32) +& carry1_reg
  sum2 := temp2
  carry2 := temp2(16)
  
  val sum2_reg = RegNext(sum2(15, 0), 0.U)
  val carry2_reg = RegNext(carry2, 0.U)
  val sum1_reg1 = RegNext(sum1_reg, 0.U)
  val sum0_reg2 = RegNext(sum0_reg1, 0.U)

  // Stage 3: Add bits [63:48]
  val sum3 = Wire(UInt(17.W))
  val temp3 = adda_reg2(63, 48) +& addb_reg2(63, 48) +& carry2_reg
  sum3 := temp3
  
  val sum3_reg = RegNext(sum3, 0.U)
  val sum2_reg1 = RegNext(sum2_reg, 0.U)
  val sum1_reg2 = RegNext(sum1_reg1, 0.U)
  val sum0_reg3 = RegNext(sum0_reg2, 0.U)

  // Combine all partial sums to form final result
  io.result := Cat(sum3_reg, sum2_reg1, sum1_reg2, sum0_reg3)

  // Output enable signal
  io.o_en := i_en_reg3
}

// Generate Verilog
/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(), Array("--target-dir", "generated"))
}
*/
