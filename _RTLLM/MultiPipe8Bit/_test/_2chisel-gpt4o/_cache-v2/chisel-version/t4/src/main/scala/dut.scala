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

  // Pipeline Registers
  val mul_en_out_reg = RegInit(0.U(5.W)) // 5-bit shift register for enable signal
  val mul_a_reg = RegEnable(io.mul_a, 0.U, io.mul_en_in) // Register for multiplicand
  val mul_b_reg = RegEnable(io.mul_b, 0.U, io.mul_en_in) // Register for multiplier

  // Partial Product Wires
  val temp = Wire(Vec(8, UInt(16.W))) // Wires for partial products

  // Generate Partial Products
  for (i <- 0 until 8) {
    temp(i) := Mux(io.mul_b(i), io.mul_a << i, 0.U) // Conditional assignment for each multiplier bit
  }

  // Partial Sum Registers
  val sumReg1 = RegNext(temp(0) + temp(1), 0.U) // Sum of partial product 0 and 1
  val sumReg2 = RegNext(temp(2) + temp(3), 0.U) // Sum of partial product 2 and 3
  val sumReg3 = RegNext(temp(4) + temp(5), 0.U) // Sum of partial product 4 and 5
  val sumReg4 = RegNext(temp(6) + temp(7), 0.U) // Sum of partial product 6 and 7

  // Final Product Registers
  val partialSum1 = RegNext(sumReg1 + sumReg2, 0.U) // Sum of first two groups
  val partialSum2 = RegNext(sumReg3 + sumReg4, 0.U) // Sum of second two groups
  val mul_out_reg = RegNext(partialSum1 + partialSum2, 0.U) // Final product

  // Update enable shift register
  mul_en_out_reg := Cat(mul_en_out_reg(3, 0), io.mul_en_in)

  // Output Assignment
  io.mul_en_out := mul_en_out_reg(4) // Output enable is the MSB of mul_en_out_reg
  io.mul_out := Mux(io.mul_en_out, mul_out_reg, 0.U) // Output product when enable is high, else 0
}

