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

  // Pipeline registers
  val regStage1_a = RegNext(io.adda(15, 0))
  val regStage1_b = RegNext(io.addb(15, 0))
  val regStage1_en = RegNext(io.i_en)
  
  val regStage2_sum = Reg(UInt(17.W))
  val regStage2_a = RegNext(io.adda(31, 16))
  val regStage2_b = RegNext(io.addb(31, 16))
  val regStage2_en = RegNext(regStage1_en)
  
  val regStage3_sum = Reg(UInt(33.W))
  val regStage3_a = RegNext(io.adda(47, 32))
  val regStage3_b = RegNext(io.addb(47, 32))
  val regStage3_en = RegNext(regStage2_en)
  
  val regStage4_sum = Reg(UInt(49.W))
  val regStage4_a = RegNext(io.adda(63, 48))
  val regStage4_b = RegNext(io.addb(63, 48))
  val regStage4_en = RegNext(regStage3_en)

  // Stage 1
  val stage1_sum = regStage1_a +& regStage1_b
  regStage2_sum := stage1_sum

  // Stage 2
  val stage2_sum = regStage2_a +& regStage2_b + regStage2_sum(16)
  regStage3_sum := Cat(stage2_sum, regStage2_sum(15, 0))

  // Stage 3
  val stage3_sum = regStage3_a +& regStage3_b + regStage3_sum(32)
  regStage4_sum := Cat(stage3_sum, regStage3_sum(31, 0))

  // Stage 4
  val final_sum = regStage4_a +& regStage4_b + regStage4_sum(48)
  io.result := Cat(final_sum, regStage4_sum(47, 0))
  io.o_en := regStage4_en
}

