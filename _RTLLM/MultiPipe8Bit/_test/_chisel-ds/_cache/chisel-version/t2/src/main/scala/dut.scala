import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val mul_en_in = Input(Bool()) // Input enable signal
    val mul_a     = Input(UInt(8.W)) // 8-bit multiplicand
    val mul_b     = Input(UInt(8.W)) // 8-bit multiplier
    val mul_en_out = Output(Bool()) // Output enable signal
    val mul_out    = Output(UInt(16.W)) // 16-bit product output
  })

  // Internal registers and wires
  val mul_en_out_reg = RegInit(0.U(5.W)) // 5-bit shift register for enable signal
  val mul_a_reg = RegInit(0.U(8.W)) // Register for multiplicand
  val mul_b_reg = RegInit(0.U(8.W)) // Register for multiplier
  val temp = Wire(Vec(8, UInt(16.W))) // Partial products
  val sum = Reg(Vec(7, UInt(16.W))) // Partial sums
  val mul_out_reg = RegInit(0.U(16.W)) // Final product register

  // Input control logic
  mul_en_out_reg := Cat(mul_en_out_reg(3, 0), io.mul_en_in)
  io.mul_en_out := mul_en_out_reg(4) // Output enable signal

  // Input registers
  when(io.mul_en_in) {
    mul_a_reg := io.mul_a
    mul_b_reg := io.mul_b
  }

  // Partial product generation
  for (i <- 0 until 8) {
    temp(i) := Mux(mul_b_reg(i), mul_a_reg << i, 0.U)
  }

  // Partial sum calculation
  sum(0) := temp(0) + temp(1)
  for (i <- 1 until 7) {
    sum(i) := sum(i - 1) + temp(i + 1)
  }

  // Final product calculation
  mul_out_reg := sum(6)

  // Output assignment
  io.mul_out := Mux(io.mul_en_out, mul_out_reg, 0.U)
}

// Generate Verilog code
/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(), Array("--target-dir", "generated"))
}
*/
