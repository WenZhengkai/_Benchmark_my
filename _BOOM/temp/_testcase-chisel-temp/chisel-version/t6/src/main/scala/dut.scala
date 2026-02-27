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
  val en_reg1 = RegInit(false.B)
  val en_reg2 = RegInit(false.B)
  val en_reg3 = RegInit(false.B)
  val en_reg4 = RegInit(false.B)
  
  // Pipeline registers for operands
  val adda_reg = RegInit(0.U(64.W))
  val addb_reg = RegInit(0.U(64.W))
  
  // Pipeline registers for partial sums
  val sum1 = RegInit(0.U(16.W))
  val sum2 = RegInit(0.U(16.W))
  val sum3 = RegInit(0.U(16.W))
  
  // Pipeline registers for carry
  val carry1 = RegInit(false.B)
  val carry2 = RegInit(false.B)
  val carry3 = RegInit(false.B)
  val carry4 = RegInit(false.B)
  
  // Final result register
  val result_reg = RegInit(0.U(65.W))
  
  // Register input operands
  when(io.i_en) {
    adda_reg := io.adda
    addb_reg := io.addb
  }
  
  // Pipeline stage enable propagation
  en_reg1 := io.i_en
  en_reg2 := en_reg1
  en_reg3 := en_reg2
  en_reg4 := en_reg3
  
  // Extract 16-bit chunks from the input operands
  val adda_chunks = Wire(Vec(4, UInt(16.W)))
  val addb_chunks = Wire(Vec(4, UInt(16.W)))
  
  for (i <- 0 until 4) {
    adda_chunks(i) := adda_reg(16 * (i + 1) - 1, 16 * i)
    addb_chunks(i) := addb_reg(16 * (i + 1) - 1, 16 * i)
  }
  
  // Pipeline Stage 1: Add first 16 bits
  when(en_reg1) {
    val temp = adda_chunks(0) +& addb_chunks(0)
    sum1 := temp(15, 0)
    carry1 := temp(16)
  }
  
  // Pipeline Stage 2: Add second 16 bits + carry
  when(en_reg2) {
    val temp = adda_chunks(1) +& addb_chunks(1) + carry1
    sum2 := temp(15, 0)
    carry2 := temp(16)
  }
  
  // Pipeline Stage 3: Add third 16 bits + carry
  when(en_reg3) {
    val temp = adda_chunks(2) +& addb_chunks(2) + carry2
    sum3 := temp(15, 0)
    carry3 := temp(16)
  }
  
  // Pipeline Stage 4: Add fourth 16 bits + carry and combine all results
  when(en_reg4) {
    val temp = adda_chunks(3) +& addb_chunks(3) + carry3
    val high_sum = temp(15, 0)
    carry4 := temp(16)
    
    // Combine all partial sums to form the final result
    result_reg := Cat(carry4, high_sum, sum3, sum2, sum1)
  }
  
  // Connect outputs
  io.result := result_reg
  io.o_en := en_reg4
}
