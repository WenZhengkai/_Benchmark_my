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

  // Pipeline registers for operands
  val adda_stage1 = RegNext(io.adda, 0.U)
  val addb_stage1 = RegNext(io.addb, 0.U)
  
  val adda_stage2 = RegNext(adda_stage1, 0.U)
  val addb_stage2 = RegNext(addb_stage1, 0.U)
  
  val adda_stage3 = RegNext(adda_stage2, 0.U)
  val addb_stage3 = RegNext(addb_stage2, 0.U)

  // Pipeline registers for enable signal
  val en_stage1 = RegNext(io.i_en, false.B)
  val en_stage2 = RegNext(en_stage1, false.B)
  val en_stage3 = RegNext(en_stage2, false.B)
  val en_stage4 = RegNext(en_stage3, false.B)

  // Stage 1: Add bits [15:0]
  val sum_stage1 = Wire(UInt(17.W))
  val carry_stage1 = RegNext(0.U(1.W), 0.U)
  
  sum_stage1 := adda_stage1(15, 0) + addb_stage1(15, 0)
  carry_stage1 := sum_stage1(16)
  
  val partial_sum1 = RegNext(sum_stage1(15, 0), 0.U)

  // Stage 2: Add bits [31:16] with carry from stage 1
  val sum_stage2 = Wire(UInt(17.W))
  val carry_stage2 = RegNext(0.U(1.W), 0.U)
  
  sum_stage2 := adda_stage2(31, 16) + addb_stage2(31, 16) + carry_stage1
  carry_stage2 := sum_stage2(16)
  
  val partial_sum2 = RegNext(sum_stage2(15, 0), 0.U)

  // Stage 3: Add bits [47:32] with carry from stage 2
  val sum_stage3 = Wire(UInt(17.W))
  val carry_stage3 = RegNext(0.U(1.W), 0.U)
  
  sum_stage3 := adda_stage3(47, 32) + addb_stage3(47, 32) + carry_stage2
  carry_stage3 := sum_stage3(16)
  
  val partial_sum3 = RegNext(sum_stage3(15, 0), 0.U)

  // Pipeline registers to align partial sums
  val partial_sum1_stage2 = RegNext(partial_sum1, 0.U)
  val partial_sum1_stage3 = RegNext(partial_sum1_stage2, 0.U)
  
  val partial_sum2_stage3 = RegNext(partial_sum2, 0.U)

  // Stage 4: Add bits [63:48] with carry from stage 3
  val sum_stage4 = Wire(UInt(17.W))
  val adda_stage4 = RegNext(adda_stage3, 0.U)
  val addb_stage4 = RegNext(addb_stage3, 0.U)
  
  sum_stage4 := adda_stage4(63, 48) + addb_stage4(63, 48) + carry_stage3
  
  val partial_sum4 = sum_stage4(15, 0)
  val final_carry = sum_stage4(16)

  // Combine all partial sums to form the final result
  io.result := Cat(final_carry, partial_sum4, partial_sum3, partial_sum2_stage3, partial_sum1_stage3)

  // Output enable signal
  io.o_en := en_stage4
}

/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut, Array("--target-dir", "generated"))
}
*/
