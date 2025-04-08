import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val mul_en_in = Input(Bool())
    val mul_a     = Input(UInt(8.W))
    val mul_b     = Input(UInt(8.W))
    val mul_en_out = Output(Bool())
    val mul_out    = Output(UInt(16.W))
  })

  // Pipeline registers
  val mul_en_out_reg = RegInit(0.U(1.W))
  val mul_a_reg      = Reg(UInt(8.W))
  val mul_b_reg      = Reg(UInt(8.W))
  
  // Store input data if enable is high
  when(io.mul_en_in) {
    mul_a_reg := io.mul_a
    mul_b_reg := io.mul_b
    mul_en_out_reg := io.mul_en_in
  }

  // Partial product generation
  val temp = Wire(Vec(8, UInt(16.W)))
  for (i <- 0 until 8) {
    temp(i) := Mux(mul_b_reg(i), mul_a_reg << i, 0.U)
  }

  // Partial sum calculation
  val sum1 = RegInit(0.U(16.W))
  val sum2 = RegInit(0.U(16.W))
  val sum3 = RegInit(0.U(16.W))
  
  when(io.mul_en_in) {
    sum1 := temp(0) + temp(1)
    sum2 := temp(2) + temp(3)
    sum3 := temp(4) + temp(5)
  }

  // Final product calculation
  val final_sum1 = RegInit(0.U(16.W))
  val final_sum2 = RegInit(0.U(16.W))

  when(io.mul_en_in) {
    final_sum1 := sum1 + sum2
    final_sum2 := temp(6) + temp(7)
  }

  val mul_out_reg = RegInit(0.U(16.W))
  when(io.mul_en_in) {
    mul_out_reg := final_sum1 + final_sum2 + sum3
  }

  // Output assignment
  io.mul_out := Mux(mul_en_out_reg === 1.U, mul_out_reg, 0.U)
  io.mul_en_out := mul_en_out_reg
}
