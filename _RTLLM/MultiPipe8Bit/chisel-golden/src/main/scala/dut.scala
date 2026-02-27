import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val mul_en_in = Input(Bool()) // Input enable signal
    val mul_a = Input(UInt(8.W))  // 8-bit multiplicand
    val mul_b = Input(UInt(8.W))  // 8-bit multiplier
    val mul_en_out = Output(Bool()) // Output enable signal
    val mul_out = Output(UInt(16.W)) // 16-bit product output
  })

  // Pipeline stages
  val mul_en_out_reg = RegInit(VecInit(Seq.fill(5)(false.B))) // 5-bit pipeline for enable signal
  val mul_a_reg = Reg(UInt(8.W)) // Register for multiplicand
  val mul_b_reg = Reg(UInt(8.W)) // Register for multiplier
  val temp = Wire(Vec(8, UInt(16.W))) // Partial products
  val sum = Reg(Vec(4, UInt(16.W))) // Partial sums
  val mul_out_reg = Reg(UInt(16.W)) // Final product register

  // Input Control
  when(io.mul_en_in) {
    mul_a_reg := io.mul_a
    mul_b_reg := io.mul_b
  }
  mul_en_out_reg(0) := io.mul_en_in
  for (i <- 1 until 5) {
    mul_en_out_reg(i) := mul_en_out_reg(i - 1)
  }
  io.mul_en_out := mul_en_out_reg(4)

  // Partial Product Generation
  for (i <- 0 until 8) {
    temp(i) := Mux(mul_b_reg(i), mul_a_reg << i, 0.U)
  }

  // Partial Sum Calculation
  sum(0) := temp(0) + temp(1)
  sum(1) := temp(2) + temp(3)
  sum(2) := temp(4) + temp(5)
  sum(3) := temp(6) + temp(7)

  // Final Product Calculation
  mul_out_reg := sum(0) + sum(1) + sum(2) + sum(3)

  // Output Assignment
  io.mul_out := Mux(io.mul_en_out, mul_out_reg, 0.U)
}

// Generate Verilog
/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut)
}
*/
