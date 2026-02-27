// package adder

import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    // Input ports
    val i_en = Input(Bool())
    val adda = Input(UInt(64.W))
    val addb = Input(UInt(64.W))
    
    // Output ports
    val result = Output(UInt(65.W))
    val o_en = Output(Bool())
  })
  
  // Pipeline stage registers for enable signal
  val en_reg1 = RegInit(false.B)
  val en_reg2 = RegInit(false.B)
  val en_reg3 = RegInit(false.B)
  val en_reg4 = RegInit(false.B)
  
  // Pipeline registers for operands
  val adda_reg = RegInit(0.U(64.W))
  val addb_reg = RegInit(0.U(64.W))
  
  // Register input data when enabled
  when(io.i_en) {
    adda_reg := io.adda
    addb_reg := io.addb
    en_reg1 := true.B
  }.otherwise {
    en_reg1 := false.B
  }
  
  // Divide the 64-bit addition into 4 parts (16 bits each)
  val segment_width = 16
  
  // Stage 1 - First 16 bits
  val sum1 = Wire(UInt(16.W))
  val carry1 = Wire(Bool())
  val stage1_result = Cat(carry1, sum1)
  val stage1_value = adda_reg(15, 0) +& addb_reg(15, 0)
  sum1 := stage1_value(15, 0)
  carry1 := stage1_value(16)
  
  // Stage 1 pipeline registers
  val stage1_reg = RegInit(0.U(17.W))
  val adda_high1_reg = RegInit(0.U(48.W))
  val addb_high1_reg = RegInit(0.U(48.W))
  
  when(en_reg1) {
    stage1_reg := stage1_result
    adda_high1_reg := adda_reg(63, 16)
    addb_high1_reg := addb_reg(63, 16)
    en_reg2 := true.B
  }.otherwise {
    en_reg2 := false.B
  }
  
  // Stage 2 - Second 16 bits
  val sum2 = Wire(UInt(16.W))
  val carry2 = Wire(Bool())
  val stage2_result = Cat(carry2, sum2)
  val stage2_value = adda_high1_reg(15, 0) +& addb_high1_reg(15, 0) + stage1_reg(16)
  sum2 := stage2_value(15, 0)
  carry2 := stage2_value(16)
  
  // Stage 2 pipeline registers
  val stage1_2_reg = RegInit(0.U(16.W)) // Store sum1
  val stage2_reg = RegInit(0.U(17.W))
  val adda_high2_reg = RegInit(0.U(32.W))
  val addb_high2_reg = RegInit(0.U(32.W))
  
  when(en_reg2) {
    stage1_2_reg := stage1_reg(15, 0)
    stage2_reg := stage2_result
    adda_high2_reg := adda_high1_reg(47, 16)
    addb_high2_reg := addb_high1_reg(47, 16)
    en_reg3 := true.B
  }.otherwise {
    en_reg3 := false.B
  }
  
  // Stage 3 - Third 16 bits
  val sum3 = Wire(UInt(16.W))
  val carry3 = Wire(Bool())
  val stage3_result = Cat(carry3, sum3)
  val stage3_value = adda_high2_reg(15, 0) +& addb_high2_reg(15, 0) + stage2_reg(16)
  sum3 := stage3_value(15, 0)
  carry3 := stage3_value(16)
  
  // Stage 3 pipeline registers
  val stage1_3_reg = RegInit(0.U(16.W))
  val stage2_3_reg = RegInit(0.U(16.W))
  val stage3_reg = RegInit(0.U(17.W))
  val adda_high3_reg = RegInit(0.U(16.W))
  val addb_high3_reg = RegInit(0.U(16.W))
  
  when(en_reg3) {
    stage1_3_reg := stage1_2_reg
    stage2_3_reg := stage2_reg(15, 0)
    stage3_reg := stage3_result
    adda_high3_reg := adda_high2_reg(31, 16)
    addb_high3_reg := addb_high2_reg(31, 16)
    en_reg4 := true.B
  }.otherwise {
    en_reg4 := false.B
  }
  
  // Stage 4 - Fourth 16 bits
  val sum4 = Wire(UInt(16.W))
  val carry4 = Wire(Bool())
  val stage4_result = Cat(carry4, sum4)
  val stage4_value = adda_high3_reg +& addb_high3_reg + stage3_reg(16)
  sum4 := stage4_value(15, 0)
  carry4 := stage4_value(16)
  
  // Final result
  val final_result = RegInit(0.U(65.W))
  val o_en_reg = RegInit(false.B)
  
  when(en_reg4) {
    final_result := Cat(stage4_result, stage3_reg(15, 0), stage2_3_reg, stage1_3_reg)
    o_en_reg := true.B
  }.otherwise {
    o_en_reg := false.B
  }
  
  // Connect output ports
  io.result := final_result
  io.o_en := o_en_reg
}
