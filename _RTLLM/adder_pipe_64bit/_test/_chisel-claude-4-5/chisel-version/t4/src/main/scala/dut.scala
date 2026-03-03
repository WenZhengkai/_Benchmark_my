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
  val adda_reg0 = RegInit(0.U(64.W))
  val adda_reg1 = RegInit(0.U(64.W))
  val adda_reg2 = RegInit(0.U(64.W))
  val adda_reg3 = RegInit(0.U(64.W))
  
  val addb_reg0 = RegInit(0.U(64.W))
  val addb_reg1 = RegInit(0.U(64.W))
  val addb_reg2 = RegInit(0.U(64.W))
  val addb_reg3 = RegInit(0.U(64.W))

  // Pipeline registers for carry
  val carry_reg0 = RegInit(0.U(1.W))
  val carry_reg1 = RegInit(0.U(1.W))
  val carry_reg2 = RegInit(0.U(1.W))
  val carry_reg3 = RegInit(0.U(1.W))

  // Pipeline registers for partial sums
  val sum_reg0 = RegInit(0.U(16.W))
  val sum_reg1 = RegInit(0.U(16.W))
  val sum_reg2 = RegInit(0.U(16.W))
  val sum_reg3 = RegInit(0.U(16.W))

  // Pipeline registers for enable signal
  val en_reg0 = RegInit(false.B)
  val en_reg1 = RegInit(false.B)
  val en_reg2 = RegInit(false.B)
  val en_reg3 = RegInit(false.B)

  // Stage 0: Process bits [15:0]
  adda_reg0 := io.adda
  addb_reg0 := io.addb
  en_reg0 := io.i_en
  
  val sum0_temp = adda_reg0(15, 0) + addb_reg0(15, 0)
  sum_reg0 := sum0_temp(15, 0)
  carry_reg0 := sum0_temp(16)

  // Stage 1: Process bits [31:16]
  adda_reg1 := adda_reg0
  addb_reg1 := addb_reg0
  en_reg1 := en_reg0
  
  val sum1_temp = adda_reg1(31, 16) + addb_reg1(31, 16) + carry_reg0
  sum_reg1 := sum1_temp(15, 0)
  carry_reg1 := sum1_temp(16)

  // Stage 2: Process bits [47:32]
  adda_reg2 := adda_reg1
  addb_reg2 := addb_reg1
  en_reg2 := en_reg1
  
  val sum2_temp = adda_reg2(47, 32) + addb_reg2(47, 32) + carry_reg1
  sum_reg2 := sum2_temp(15, 0)
  carry_reg2 := sum2_temp(16)

  // Stage 3: Process bits [63:48]
  adda_reg3 := adda_reg2
  addb_reg3 := addb_reg2
  en_reg3 := en_reg2
  
  val sum3_temp = adda_reg3(63, 48) + addb_reg3(63, 48) + carry_reg2
  sum_reg3 := sum3_temp(15, 0)
  carry_reg3 := sum3_temp(16)

  // Output: Concatenate all partial sums and final carry
  io.result := Cat(carry_reg3, sum_reg3, sum_reg2, sum_reg1, sum_reg0)
  io.o_en := en_reg3
}

/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(), Array("--target-dir", "generated"))
}
*/
