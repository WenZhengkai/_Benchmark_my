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

  // Define registers for storing input values
  val mul_en_out_reg = RegInit(0.U(1.W)) // Single bit register for enable
  val mul_a_reg = RegInit(0.U(8.W))
  val mul_b_reg = RegInit(0.U(8.W))

  // Partials and sum registers
  val partials = Reg(Vec(8, UInt(16.W)))
  val sum = Reg(UInt(16.W))

  // On positive clock edge, update registers based on enable signal
  when(io.mul_en_in) {
    mul_en_out_reg := 1.U
    mul_a_reg := io.mul_a
    mul_b_reg := io.mul_b
  }.otherwise {
    mul_en_out_reg := 0.U
  }

  // Generate partial products
  for (i <- 0 until 8) {
    partials(i) := 0.U
    when(mul_b_reg(i)) {
      partials(i) := mul_a_reg << i
    }
  }

  // Add the partial products to calculate the final sum
  sum := partials.reduce(_ +& _)

  // Output assignments
  io.mul_en_out := mul_en_out_reg
  io.mul_out := Mux(mul_en_out_reg === 1.U, sum, 0.U)
}
