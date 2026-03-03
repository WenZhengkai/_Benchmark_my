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

  // Stage 0: bits [15:0]
  val sum0 = RegInit(0.U(17.W))
  val carry0 = RegInit(0.U(1.W))
  
  when(io.i_en) {
    val temp_sum0 = io.adda(15, 0) +& io.addb(15, 0)
    sum0 := temp_sum0
    carry0 := temp_sum0(16)
  }.otherwise {
    sum0 := 0.U
    carry0 := 0.U
  }

  // Stage 1: bits [31:16]
  val sum1 = RegInit(0.U(17.W))
  val carry1 = RegInit(0.U(1.W))
  val sum0_reg = RegNext(sum0, 0.U)
  
  when(i_en_reg0) {
    val temp_sum1 = adda_reg0(31, 16) +& addb_reg0(31, 16) +& carry0
    sum1 := temp_sum1
    carry1 := temp_sum1(16)
  }.otherwise {
    sum1 := 0.U
    carry1 := 0.U
  }

  // Stage 2: bits [47:32]
  val sum2 = RegInit(0.U(17.W))
  val carry2 = RegInit(0.U(1.W))
  val sum1_reg = RegNext(sum1, 0.U)
  val sum0_reg2 = RegNext(sum0_reg, 0.U)
  
  when(i_en_reg1) {
    val temp_sum2 = adda_reg1(47, 32) +& addb_reg1(47, 32) +& carry1
    sum2 := temp_sum2
    carry2 := temp_sum2(16)
  }.otherwise {
    sum2 := 0.U
    carry2 := 0.U
  }

  // Stage 3: bits [63:48]
  val sum3 = RegInit(0.U(17.W))
  val sum2_reg = RegNext(sum2, 0.U)
  val sum1_reg2 = RegNext(sum1_reg, 0.U)
  val sum0_reg3 = RegNext(sum0_reg2, 0.U)
  
  when(i_en_reg2) {
    val temp_sum3 = adda_reg2(63, 48) +& addb_reg2(63, 48) +& carry2
    sum3 := temp_sum3
  }.otherwise {
    sum3 := 0.U
  }

  // Output result: Combine all partial sums
  io.result := Cat(sum3, sum2_reg(15, 0), sum1_reg2(15, 0), sum0_reg3(15, 0))
  
  // Output enable signal
  io.o_en := i_en_reg3
}

/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut, Array("--target-dir", "generated"))
}
*/
