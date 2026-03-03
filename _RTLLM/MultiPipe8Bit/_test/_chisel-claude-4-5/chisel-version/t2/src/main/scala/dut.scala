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

  // Input enable register (5-bit shift register for pipeline control)
  val mul_en_out_reg = RegInit(VecInit(Seq.fill(5)(false.B)))
  
  // Shift the enable signal through the pipeline
  mul_en_out_reg(0) := io.mul_en_in
  for (i <- 1 until 5) {
    mul_en_out_reg(i) := mul_en_out_reg(i-1)
  }
  
  // Output enable is the MSB of the enable register
  io.mul_en_out := mul_en_out_reg(4)

  // Input registers for multiplicand and multiplier
  val mul_a_reg = RegInit(0.U(8.W))
  val mul_b_reg = RegInit(0.U(8.W))
  
  when(io.mul_en_in) {
    mul_a_reg := io.mul_a
    mul_b_reg := io.mul_b
  }

  // Partial product generation (8 partial products for 8-bit multiplier)
  val temp = Wire(Vec(8, UInt(16.W)))
  
  for (i <- 0 until 8) {
    temp(i) := Mux(mul_b_reg(i), Cat(0.U(8.W), mul_a_reg) << i, 0.U(16.W))
  }

  // Pipeline stage 1: Sum partial products in groups
  // Group 1: temp(0) + temp(1)
  val sum1_reg = RegInit(0.U(16.W))
  sum1_reg := temp(0) + temp(1)
  
  // Group 2: temp(2) + temp(3)
  val sum2_reg = RegInit(0.U(16.W))
  sum2_reg := temp(2) + temp(3)
  
  // Group 3: temp(4) + temp(5)
  val sum3_reg = RegInit(0.U(16.W))
  sum3_reg := temp(4) + temp(5)
  
  // Group 4: temp(6) + temp(7)
  val sum4_reg = RegInit(0.U(16.W))
  sum4_reg := temp(6) + temp(7)

  // Pipeline stage 2: Sum pairs of partial sums
  val sum12_reg = RegInit(0.U(16.W))
  sum12_reg := sum1_reg + sum2_reg
  
  val sum34_reg = RegInit(0.U(16.W))
  sum34_reg := sum3_reg + sum4_reg

  // Pipeline stage 3: Final sum
  val sum_all_reg = RegInit(0.U(16.W))
  sum_all_reg := sum12_reg + sum34_reg

  // Final output register
  val mul_out_reg = RegInit(0.U(16.W))
  mul_out_reg := sum_all_reg

  // Output assignment
  io.mul_out := Mux(io.mul_en_out, mul_out_reg, 0.U(16.W))
}

// Generate Verilog
/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(), Array("--target-dir", "generated"))
}
*/
