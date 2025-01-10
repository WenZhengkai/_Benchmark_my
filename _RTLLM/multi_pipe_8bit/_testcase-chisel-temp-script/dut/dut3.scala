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

  // Enable register
  val mul_en_out_reg = RegInit(false.B)
  // Input registers
  val mul_a_reg = Reg(UInt(8.W))
  val mul_b_reg = Reg(UInt(8.W))
  // Partial products and sums
  val temp = Wire(Vec(8, UInt(16.W)))  // Wires for partial products
  val sum = Reg(Vec(8, UInt(16.W)))    // Registers for intermediate sums
  
  // Capture enable and inputs when enable is high
  when(io.mul_en_in) {
    mul_en_out_reg := true.B
    mul_a_reg := io.mul_a
    mul_b_reg := io.mul_b
  }

  // Generate partial products
  for (i <- 0 until 8) {
    temp(i) := Mux(mul_b_reg(i), mul_a_reg << i, 0.U)
  }

  // Compute the partial sums
  sum(0) := temp(0)
  for (i <- 1 until 8) {
    sum(i) := sum(i-1) + temp(i)
  }

  // Final product calculation
  val mul_out_reg = RegNext(sum(7))

  // Output logic
  io.mul_en_out := mul_en_out_reg
  io.mul_out := Mux(mul_en_out_reg, mul_out_reg, 0.U)
}


