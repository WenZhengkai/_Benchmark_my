import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val mul_en_in = Input(Bool())               // Input enable signal
    val mul_a     = Input(UInt(8.W))            // 8-bit multiplicand
    val mul_b     = Input(UInt(8.W))            // 8-bit multiplier
    val mul_en_out = Output(Bool())             // Output enable signal
    val mul_out   = Output(UInt(16.W))          // 16-bit product output
  })

  // Pipeline registers
  val mul_en_out_reg = RegInit(0.U(5.W))        // 5-bit shift register for enable signal
  val mul_a_reg      = RegInit(0.U(8.W))        // Register for multiplicand
  val mul_b_reg      = RegInit(0.U(8.W))        // Register for multiplier
  val temp           = Wire(Vec(8, UInt(16.W))) // Wires for partial products
  val sum            = RegInit(VecInit(Seq.fill(8)(0.U(16.W)))) // Registers for partial sums
  val mul_out_reg    = RegInit(0.U(16.W))       // Register for final product

  // Input Control Logic
  mul_en_out_reg := Cat(mul_en_out_reg(3, 0), io.mul_en_in)
  io.mul_en_out := mul_en_out_reg(4)            // Output enable signal derived from MSB

  // Input Registers
  when(io.mul_en_in) {
    mul_a_reg := io.mul_a
    mul_b_reg := io.mul_b
  }

  // Partial Product Generation
  for (i <- 0 until 8) {
    temp(i) := Mux(mul_b_reg(i), mul_a_reg << i, 0.U)
  }

  // Partial Sum Calculation
  sum(0) := temp(0)
  for (i <- 1 until 8) {
    sum(i) := sum(i - 1) + temp(i)
  }

  // Final Product Calculation
  mul_out_reg := sum(7)

  // Output Assignment
  io.mul_out := Mux(io.mul_en_out, mul_out_reg, 0.U)
}

// Generate Verilog
/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(), Array("--target-dir", "generated"))
}
*/
