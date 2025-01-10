import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val mul_en_in = Input(Bool())
    val mul_a     = Input(UInt(8.W))
    val mul_b     = Input(UInt(8.W))
    val mul_en_out = Output(Bool())
    val mul_out   = Output(UInt(16.W))
  })

  // Registers for input enable and capture the inputs
  val mul_en_out_reg = RegInit(false.B)
  val mul_a_reg = RegInit(0.U(8.W))
  val mul_b_reg = RegInit(0.U(8.W))

  // Register to hold the final product
  val mul_out_reg = RegInit(0.U(16.W))

  // Update the input registers and enable register
  when(io.mul_en_in) {
    mul_a_reg := io.mul_a
    mul_b_reg := io.mul_b
  }
  
  val temp = Wire(Vec(8, UInt(16.W)))
  
  for(i <- 0 until 8) {
    temp(i) := Mux(mul_b_reg(i), mul_a_reg << i, 0.U)
  }

  // Partial sum calculation
  val sum1 = Wire(UInt(16.W))
  val sum2 = Wire(UInt(16.W))
  val sum3 = Wire(UInt(16.W))

  sum1 := temp(0) + temp(1)
  sum2 := temp(2) + temp(3)
  sum3 := temp(4) + temp(5)

  val finalSum1 = Wire(UInt(16.W))
  val finalSum2 = Wire(UInt(16.W))

  finalSum1 := sum1 + sum2
  finalSum2 := temp(6) + temp(7)

  val finalSum = Wire(UInt(16.W))
  finalSum := finalSum1 + finalSum2

  // Output register logic
  when(io.mul_en_in) {
    mul_out_reg := finalSum
    mul_en_out_reg := true.B
  } .otherwise {
    mul_en_out_reg := false.B
  }

  // Connect output enable and final output
  io.mul_en_out := mul_en_out_reg
  io.mul_out := Mux(mul_en_out_reg, mul_out_reg, 0.U)
}
