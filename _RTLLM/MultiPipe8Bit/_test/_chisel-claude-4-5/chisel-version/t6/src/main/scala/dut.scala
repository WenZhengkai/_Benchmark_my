import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val mul_en_in  = Input(Bool())
    val mul_a      = Input(UInt(8.W))
    val mul_b      = Input(UInt(8.W))
    val mul_en_out = Output(Bool())
    val mul_out    = Output(UInt(16.W))
  })

  // Enable signal pipeline register (5 bits for 5-stage pipeline)
  val mul_en_out_reg = RegInit(0.U(5.W))
  
  // Input registers for multiplicand and multiplier
  val mul_a_reg = RegInit(0.U(8.W))
  val mul_b_reg = RegInit(0.U(8.W))
  
  // Update enable pipeline
  mul_en_out_reg := Cat(mul_en_out_reg(3, 0), io.mul_en_in)
  
  // Update input registers when enable is active
  when(io.mul_en_in) {
    mul_a_reg := io.mul_a
    mul_b_reg := io.mul_b
  }
  
  // Partial product generation (Stage 1)
  // Generate 8 partial products, each shifted appropriately
  val temp = Wire(Vec(8, UInt(16.W)))
  for (i <- 0 until 8) {
    temp(i) := Mux(mul_b_reg(i), mul_a_reg << i, 0.U)
  }
  
  // Partial sum calculation using pipeline stages
  // Stage 2: Sum pairs of partial products
  val sum1 = RegInit(VecInit(Seq.fill(4)(0.U(16.W))))
  for (i <- 0 until 4) {
    sum1(i) := temp(2*i) + temp(2*i + 1)
  }
  
  // Stage 3: Sum pairs from stage 2
  val sum2 = RegInit(VecInit(Seq.fill(2)(0.U(16.W))))
  for (i <- 0 until 2) {
    sum2(i) := sum1(2*i) + sum1(2*i + 1)
  }
  
  // Stage 4: Final sum
  val sum3 = RegInit(0.U(16.W))
  sum3 := sum2(0) + sum2(1)
  
  // Stage 5: Output register
  val mul_out_reg = RegInit(0.U(16.W))
  mul_out_reg := sum3
  
  // Output assignments
  io.mul_en_out := mul_en_out_reg(4)
  io.mul_out := Mux(io.mul_en_out, mul_out_reg, 0.U)
}

// Generate Verilog
/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(), Array("--target-dir", "generated"))
}
*/
