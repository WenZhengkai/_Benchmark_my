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
  
  // Update the pipeline registers for enable signal
  en_reg := io.i_en
  en_reg2 := en_reg
  en_reg3 := en_reg2
  en_reg4 := en_reg3
  
  // Assign output enable signal
  io.o_en := en_reg4
  
  // Divide inputs into 16-bit segments
  val adda_segments = Wire(Vec(4, UInt(16.W)))
  val addb_segments = Wire(Vec(4, UInt(16.W)))
  
  for (i <- 0 until 4) {
    adda_segments(i) := io.adda((i+1)*16-1, i*16)
    addb_segments(i) := io.addb((i+1)*16-1, i*16)
  }
  
  // Pipeline stage 1: First 16 bits
  val sum1 = RegInit(0.U(16.W))
  val carry1 = RegInit(0.U(1.W))
  
  when (io.i_en) {
    val temp_sum = adda_segments(0) +& addb_segments(0)
    sum1 := temp_sum(15, 0)
    carry1 := temp_sum(16)
  }
  
  // Pipeline stage 2: Second 16 bits
  val sum2 = RegInit(0.U(16.W))
  val carry2 = RegInit(0.U(1.W))
  val sum1_reg = RegInit(0.U(16.W))
  
  when (en_reg) {
    val temp_sum = adda_segments(1) +& addb_segments(1) + carry1
    sum2 := temp_sum(15, 0)
    carry2 := temp_sum(16)
    sum1_reg := sum1
  }
  
  // Pipeline stage 3: Third 16 bits
  val sum3 = RegInit(0.U(16.W))
  val carry3 = RegInit(0.U(1.W))
  val sum2_reg = RegInit(0.U(16.W))
  val sum1_reg2 = RegInit(0.U(16.W))
  
  when (en_reg2) {
    val temp_sum = adda_segments(2) +& addb_segments(2) + carry2
    sum3 := temp_sum(15, 0)
    carry3 := temp_sum(16)
    sum2_reg := sum2
    sum1_reg2 := sum1_reg
  }
  
  // Pipeline stage 4: Fourth 16 bits
  val sum4 = RegInit(0.U(16.W))
  val carry4 = RegInit(0.U(1.W))
  val sum3_reg = RegInit(0.U(16.W))
  val sum2_reg2 = RegInit(0.U(16.W))
  val sum1_reg3 = RegInit(0.U(16.W))
  
  when (en_reg3) {
    val temp_sum = adda_segments(3) +& addb_segments(3) + carry3
    sum4 := temp_sum(15, 0)
    carry4 := temp_sum(16)
    sum3_reg := sum3
    sum2_reg2 := sum2_reg
    sum1_reg3 := sum1_reg2
  }
  
  // Final result
  io.result := Cat(carry4, sum4, sum3_reg, sum2_reg2, sum1_reg3)
}
