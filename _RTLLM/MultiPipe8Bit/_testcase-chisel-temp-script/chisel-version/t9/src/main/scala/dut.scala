import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val mul_en_in = Input(Bool())
    val mul_a = Input(UInt(8.W))
    val mul_b = Input(UInt(8.W))
    val mul_en_out = Output(Bool())
    val mul_out = Output(UInt(16.W))
  })
  
  // Pipeline registers for input enable signal
  val mul_en_out_reg = RegInit(VecInit(Seq.fill(5)(false.B)))
  
  // Shift the enable signal through the pipeline
  mul_en_out_reg(0) := io.mul_en_in
  for (i <- 1 until 5) {
    mul_en_out_reg(i) := mul_en_out_reg(i-1)
  }
  
  // Output enable is the last stage of the pipeline
  io.mul_en_out := mul_en_out_reg(4)
  
  // Input registers for the multiplicand and multiplier
  val mul_a_reg = RegEnable(io.mul_a, 0.U(8.W), io.mul_en_in)
  val mul_b_reg = RegEnable(io.mul_b, 0.U(8.W), io.mul_en_in)
  
  // Generate partial products
  val temp = Wire(Vec(8, UInt(8.W)))
  for (i <- 0 until 8) {
    temp(i) := Mux(mul_b_reg(i), mul_a_reg << i, 0.U(8.W))
  }
  
  // Pipeline stage 1: Partial sum calculation (4 sums)
  val sum1 = RegInit(0.U(16.W))
  val sum2 = RegInit(0.U(16.W))
  val sum3 = RegInit(0.U(16.W))
  val sum4 = RegInit(0.U(16.W))
  
  when (mul_en_out_reg(0)) {
    sum1 := temp(0).asUInt +& temp(1).asUInt
    sum2 := temp(2).asUInt +& temp(3).asUInt
    sum3 := temp(4).asUInt +& temp(5).asUInt
    sum4 := temp(6).asUInt +& temp(7).asUInt
  }
  
  // Pipeline stage 2: Combine partial sums (2 sums)
  val sum5 = RegInit(0.U(16.W))
  val sum6 = RegInit(0.U(16.W))
  
  when (mul_en_out_reg(1)) {
    sum5 := sum1 +& sum2
    sum6 := sum3 +& sum4
  }
  
  // Pipeline stage 3: Final sum
  val sum7 = RegInit(0.U(16.W))
  
  when (mul_en_out_reg(2)) {
    sum7 := sum5 +& sum6
  }
  
  // Pipeline stage 4: Output register
  val mul_out_reg = RegInit(0.U(16.W))
  
  when (mul_en_out_reg(3)) {
    mul_out_reg := sum7
  }
  
  // Final output
  io.mul_out := Mux(io.mul_en_out, mul_out_reg, 0.U(16.W))
}
