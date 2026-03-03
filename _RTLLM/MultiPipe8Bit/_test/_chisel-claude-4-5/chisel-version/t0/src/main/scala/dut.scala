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

  // Input Control - 5-bit shift register for enable signal
  val mul_en_out_reg = RegInit(0.U(5.W))
  mul_en_out_reg := Cat(mul_en_out_reg(3, 0), io.mul_en_in)
  io.mul_en_out := mul_en_out_reg(4)

  // Input Registers
  val mul_a_reg = RegInit(0.U(8.W))
  val mul_b_reg = RegInit(0.U(8.W))
  
  when(io.mul_en_in) {
    mul_a_reg := io.mul_a
    mul_b_reg := io.mul_b
  }

  // Partial Product Generation (8 partial products)
  val temp = Wire(Vec(8, UInt(16.W)))
  for (i <- 0 until 8) {
    temp(i) := Mux(mul_b_reg(i), Cat(0.U(8.W), mul_a_reg) << i, 0.U(16.W))
  }

  // Partial Sum Calculation (4-stage pipeline)
  // Stage 1: Add pairs of partial products (4 sums)
  val sum1 = Reg(Vec(4, UInt(16.W)))
  sum1(0) := temp(0) + temp(1)
  sum1(1) := temp(2) + temp(3)
  sum1(2) := temp(4) + temp(5)
  sum1(3) := temp(6) + temp(7)

  // Stage 2: Add pairs from stage 1 (2 sums)
  val sum2 = Reg(Vec(2, UInt(16.W)))
  sum2(0) := sum1(0) + sum1(1)
  sum2(1) := sum1(2) + sum1(3)

  // Stage 3: Add the two sums from stage 2
  val sum3 = RegInit(0.U(16.W))
  sum3 := sum2(0) + sum2(1)

  // Final Product Calculation
  val mul_out_reg = RegInit(0.U(16.W))
  mul_out_reg := sum3

  // Output Assignment
  io.mul_out := Mux(io.mul_en_out, mul_out_reg, 0.U(16.W))
}

// Generate Verilog
/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(), Array("--target-dir", "generated"))
}
*/
