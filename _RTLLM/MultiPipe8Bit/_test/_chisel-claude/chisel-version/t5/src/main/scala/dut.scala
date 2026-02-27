import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    // Input signals
    val mul_en_in = Input(Bool())
    val mul_a = Input(UInt(8.W))
    val mul_b = Input(UInt(8.W))
    
    // Output signals
    val mul_en_out = Output(Bool())
    val mul_out = Output(UInt(16.W))
  })
  
  // Pipeline registers for enable signal (5-stage pipeline)
  val mul_en_out_reg = RegInit(VecInit(Seq.fill(5)(false.B)))
  
  // Shift the enable signal through the pipeline
  mul_en_out_reg(0) := io.mul_en_in
  for (i <- 1 until 5) {
    mul_en_out_reg(i) := mul_en_out_reg(i-1)
  }
  
  // Output enable signal from the last stage of the pipeline
  io.mul_en_out := mul_en_out_reg(4)
  
  // Input registers for operands
  val mul_a_reg = RegInit(0.U(8.W))
  val mul_b_reg = RegInit(0.U(8.W))
  
  // Register input values when enabled
  when(io.mul_en_in) {
    mul_a_reg := io.mul_a
    mul_b_reg := io.mul_b
  }
  
  // Generate partial products - stage 1
  val pp = Wire(Vec(8, UInt(8.W)))
  for (i <- 0 until 8) {
    pp(i) := Mux(mul_b_reg(i), mul_a_reg, 0.U)
  }
  
  // Pipeline stage 2 - First level of accumulation
  val sum1 = RegInit(VecInit(Seq.fill(4)(0.U(9.W))))
  
  when(mul_en_out_reg(0)) {
    // Add pairs of partial products with the appropriate shift
    sum1(0) := (pp(0) | (pp(1) << 1.U)).zext
    sum1(1) := (pp(2) | (pp(3) << 1.U)).zext
    sum1(2) := (pp(4) | (pp(5) << 1.U)).zext
    sum1(3) := (pp(6) | (pp(7) << 1.U)).zext
  }
  
  // Pipeline stage 3 - Second level of accumulation
  val sum2 = RegInit(VecInit(Seq.fill(2)(0.U(11.W))))
  
  when(mul_en_out_reg(1)) {
    sum2(0) := (sum1(0) | (sum1(1) << 2.U)).zext
    sum2(1) := (sum1(2) | (sum1(3) << 2.U)).zext
  }
  
  // Pipeline stage 4 - Third level of accumulation
  val sum3 = RegInit(0.U(15.W))
  
  when(mul_en_out_reg(2)) {
    sum3 := (sum2(0) | (sum2(1) << 4.U)).zext
  }
  
  // Pipeline stage 5 - Final result
  val mul_out_reg = RegInit(0.U(16.W))
  
  when(mul_en_out_reg(3)) {
    mul_out_reg := sum3.zext
  }
  
  // Assign the output product
  io.mul_out := Mux(io.mul_en_out, mul_out_reg, 0.U)
}
