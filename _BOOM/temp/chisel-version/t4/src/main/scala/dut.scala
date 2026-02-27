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

  // Create pipeline registers for enable signal
  val en_reg1 = RegInit(false.B)
  val en_reg2 = RegInit(false.B)
  val en_reg3 = RegInit(false.B)
  val en_reg4 = RegInit(false.B)

  // Create pipeline registers for input operands
  val adda_reg = RegInit(0.U(64.W))
  val addb_reg = RegInit(0.U(64.W))

  // Pipeline stage 1 - Process first 16 bits
  val sum1 = Wire(UInt(16.W))
  val carry1 = Wire(Bool())
  val adda1 = Wire(UInt(16.W))
  val addb1 = Wire(UInt(16.W))
  val stage1_result = Wire(UInt(17.W))
  
  // Pipeline stage 2 - Process second 16 bits
  val sum2 = RegInit(0.U(16.W))
  val carry2 = RegInit(false.B)
  val adda2 = RegInit(0.U(16.W))
  val addb2 = RegInit(0.U(16.W))
  val stage2_result = Wire(UInt(17.W))
  
  // Pipeline stage 3 - Process third 16 bits
  val sum3 = RegInit(0.U(16.W))
  val carry3 = RegInit(false.B)
  val adda3 = RegInit(0.U(16.W))
  val addb3 = RegInit(0.U(16.W))
  val stage3_result = Wire(UInt(17.W))
  
  // Pipeline stage 4 - Process last 16 bits
  val sum4 = RegInit(0.U(16.W))
  val carry4 = RegInit(false.B)
  val adda4 = RegInit(0.U(16.W))
  val addb4 = RegInit(0.U(16.W))
  val stage4_result = Wire(UInt(17.W))
  
  // Final result registers
  val final_sum = RegInit(0.U(65.W))
  
  // Update enable registers through the pipeline
  en_reg1 := io.i_en
  en_reg2 := en_reg1
  en_reg3 := en_reg2
  en_reg4 := en_reg3

  // Register input operands when enabled
  when (io.i_en) {
    adda_reg := io.adda
    addb_reg := io.addb
  }
  
  // Stage 1: Process first 16 bits
  adda1 := adda_reg(15, 0)
  addb1 := addb_reg(15, 0)
  stage1_result := adda1 +& addb1 // +& for addition with carry
  sum1 := stage1_result(15, 0)
  carry1 := stage1_result(16)
  
  // Stage 2: Register results from stage 1 and process second 16 bits
  when (en_reg1) {
    sum2 := sum1
    adda2 := adda_reg(31, 16)
    addb2 := addb_reg(31, 16)
    carry2 := carry1
  }
  stage2_result := adda2 +& addb2 +& carry2
  
  // Stage 3: Register results from stage 2 and process third 16 bits
  when (en_reg2) {
    sum3 := stage2_result(15, 0)
    adda3 := adda_reg(47, 32)
    addb3 := addb_reg(47, 32)
    carry3 := stage2_result(16)
  }
  stage3_result := adda3 +& addb3 +& carry3
  
  // Stage 4: Register results from stage 3 and process last 16 bits
  when (en_reg3) {
    sum4 := stage3_result(15, 0)
    adda4 := adda_reg(63, 48)
    addb4 := addb_reg(63, 48)
    carry4 := stage3_result(16)
  }
  stage4_result := adda4 +& addb4 +& carry4
  
  // Collect the final result
  when (en_reg4) {
    final_sum := Cat(stage4_result(16), stage4_result(15, 0), sum4, sum3, sum2)
  }
  
  // Connect outputs
  io.result := final_sum
  io.o_en := en_reg4
}
