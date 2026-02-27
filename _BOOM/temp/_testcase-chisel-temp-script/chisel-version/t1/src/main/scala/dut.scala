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

  // Pipeline registers for enable signal
  val en_reg = RegInit(false.B)
  val en_reg2 = RegInit(false.B)
  val en_reg3 = RegInit(false.B)
  val en_reg4 = RegInit(false.B)

  // Synchronize enable signal through pipeline
  en_reg := io.i_en
  en_reg2 := en_reg
  en_reg3 := en_reg2
  en_reg4 := en_reg3
  
  // Set output enable signal
  io.o_en := en_reg4
  
  // Input operand registers
  val adda_reg = RegInit(0.U(64.W))
  val addb_reg = RegInit(0.U(64.W))
  
  when(io.i_en) {
    adda_reg := io.adda
    addb_reg := io.addb
  }
  
  // Split the 64-bit addition into 4 parts, each with 16 bits
  // Pipeline stage registers for carries
  val carry1 = RegInit(0.U(1.W))
  val carry2 = RegInit(0.U(1.W))
  val carry3 = RegInit(0.U(1.W))
  
  // Pipeline stage registers for partial sums
  val sum1 = RegInit(0.U(16.W))
  val sum2 = RegInit(0.U(16.W))
  val sum3 = RegInit(0.U(16.W))
  val sum4 = RegInit(0.U(16.W))
  
  // Stage 1: Calculate sum for the least significant 16 bits
  val stage1Sum = adda_reg(15, 0) +& addb_reg(15, 0)
  when(en_reg) {
    sum1 := stage1Sum(15, 0)
    carry1 := stage1Sum(16)
  }
  
  // Stage 2: Calculate sum for the next 16 bits
  val stage2Sum = adda_reg(31, 16) +& addb_reg(31, 16) + carry1
  when(en_reg2) {
    sum2 := stage2Sum(15, 0)
    carry2 := stage2Sum(16)
  }
  
  // Stage 3: Calculate sum for the next 16 bits
  val stage3Sum = adda_reg(47, 32) +& addb_reg(47, 32) + carry2
  when(en_reg3) {
    sum3 := stage3Sum(15, 0)
    carry3 := stage3Sum(16)
  }
  
  // Stage 4: Calculate sum for the most significant 16 bits
  val stage4Sum = adda_reg(63, 48) +& addb_reg(63, 48) + carry3
  when(en_reg4) {
    sum4 := stage4Sum(15, 0)
  }
  
  // Combine all partial sums into the final result
  io.result := Cat(stage4Sum(16), sum4, sum3, sum2, sum1)
}
