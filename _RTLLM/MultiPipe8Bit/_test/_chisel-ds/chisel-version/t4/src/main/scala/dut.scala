import chisel3._
import chisel3.util._

class dut extends Module {
  // Input ports
  val mul_en_in = Input(Bool())
  val mul_a     = Input(UInt(8.W))
  val mul_b     = Input(UInt(8.W))

  // Output ports
  val mul_en_out = Output(Bool())
  val mul_out    = Output(UInt(16.W))

  // Internal registers
  val mul_en_out_reg = RegInit(0.U(5.W)) // 5-bit shift register for enable signal
  val mul_a_reg      = RegInit(0.U(8.W)) // Register for multiplicand
  val mul_b_reg      = RegInit(0.U(8.W)) // Register for multiplier
  val sum_regs       = RegInit(VecInit(Seq.fill(8)(0.U(16.W)))) // Registers for partial sums
  val mul_out_reg    = RegInit(0.U(16.W)) // Register for final product

  // Partial product wires
  val temp = Wire(Vec(8, UInt(16.W))) // Wires for partial products

  // Input Control Logic
  mul_en_out_reg := Cat(mul_en_out_reg(3, 0), mul_en_in) // Shift the enable signal
  mul_en_out := mul_en_out_reg(4) // Output enable is the MSB of the shift register

  // Input Registers
  when(mul_en_in) {
    mul_a_reg := mul_a
    mul_b_reg := mul_b
  }

  // Partial Product Generation
  for (i <- 0 until 8) {
    temp(i) := Mux(mul_b_reg(i), mul_a_reg << i, 0.U)
  }

  // Partial Sum Calculation
  sum_regs(0) := temp(0)
  for (i <- 1 until 8) {
    sum_regs(i) := sum_regs(i - 1) + temp(i)
  }

  // Final Product Calculation
  mul_out_reg := sum_regs(7)

  // Output Assignment
  mul_out := Mux(mul_en_out, mul_out_reg, 0.U)
}

/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(), Array("--target-dir", "generated"))
}
*/
