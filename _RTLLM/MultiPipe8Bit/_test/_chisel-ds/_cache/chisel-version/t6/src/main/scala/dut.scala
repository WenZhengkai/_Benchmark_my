import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val mul_en_in = Input(Bool()) // Input enable signal
    val mul_a = Input(UInt(8.W))  // Multiplicand (8-bit)
    val mul_b = Input(UInt(8.W))  // Multiplier (8-bit)
    val mul_en_out = Output(Bool()) // Output enable signal
    val mul_out = Output(UInt(16.W)) // Product output (16-bit)
  })

  // Pipeline registers
  val mul_en_out_reg = RegInit(0.U(5.W)) // 5-bit register for enable signal
  val mul_a_reg = RegInit(0.U(8.W)) // Register for multiplicand
  val mul_b_reg = RegInit(0.U(8.W)) // Register for multiplier
  val temp = Wire(Vec(8, UInt(16.W))) // Partial products
  val sum = Reg(Vec(8, UInt(16.W))) // Partial sums
  val mul_out_reg = RegInit(0.U(16.W)) // Final product register

  // Input Control
  when(io.mul_en_in) {
    mul_en_out_reg := Cat(mul_en_out_reg(3, 0), io.mul_en_in) // Shift in the enable signal
    mul_a_reg := io.mul_a // Sample multiplicand
    mul_b_reg := io.mul_b // Sample multiplier
  }

  // Output enable signal
  io.mul_en_out := mul_en_out_reg(4) // MSB of the enable register

  // Partial Product Generation
  for (i <- 0 until 8) {
    temp(i) := Mux(mul_b_reg(i), mul_a_reg << i, 0.U(16.W)) // Bitwise multiplication
  }

  // Partial Sum Calculation
  sum(0) := temp(0)
  for (i <- 1 until 8) {
    sum(i) := sum(i - 1) + temp(i) // Accumulate partial sums
  }

  // Final Product Calculation
  mul_out_reg := sum(7) // Final product is the last partial sum

  // Output Assignment
  io.mul_out := Mux(io.mul_en_out, mul_out_reg, 0.U(16.W)) // Output product if enabled
}

/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(), Array("--target-dir", "generated"))
}
*/
