import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val mul_en_in = Input(Bool())         // Input enable signal
    val mul_a = Input(UInt(8.W))         // Multiplicand (8 bits)
    val mul_b = Input(UInt(8.W))         // Multiplier (8 bits)
    val mul_en_out = Output(Bool())      // Output enable signal
    val mul_out = Output(UInt(16.W))     // Product (16 bits)
  })

  // Registers for pipelining
  val mul_en_out_reg = RegInit(0.U(5.W)) // 5-bit shift register for enable signal
  val mul_a_reg = RegInit(0.U(8.W))      // 8-bit register to store multiplicand
  val mul_b_reg = RegInit(0.U(8.W))      // 8-bit register to store multiplier

  // Shift the enable pipeline with the input enable signal
  mul_en_out_reg := Cat(mul_en_out_reg(3, 0), io.mul_en_in)

  // Update mul_a_reg and mul_b_reg only when mul_en_in is active
  when(io.mul_en_in) {
    mul_a_reg := io.mul_a
    mul_b_reg := io.mul_b
  }

  // Partial product generation (bitwise AND between multiplicand and each multiplier bit)
  val partialProducts = Wire(Vec(8, UInt(16.W)))
  for (i <- 0 until 8) {
    partialProducts(i) := Mux(mul_b_reg(i), mul_a_reg << i, 0.U)
  }

  // Partial sum calculation (pipeline accumulation of partial products)
  val sumStages = Reg(Vec(4, UInt(16.W))) // 4 stages of intermediate sums

  // Stage 0: Add first two partial products
  sumStages(0) := partialProducts(0) + partialProducts(1)

  // Stage 1: Add next two partial products
  sumStages(1) := partialProducts(2) + partialProducts(3)

  // Stage 2: Add results of the first two stages
  val stage2Sum = sumStages(0) + sumStages(1)

  // Stage 3: Pipeline addition of remaining partial products
  sumStages(2) := partialProducts(4) + partialProducts(5)
  sumStages(3) := partialProducts(6) + partialProducts(7)

  val stage3Sum = sumStages(2) + sumStages(3)

  // Final product calculation: Accumulate all partial sums
  val mul_out_reg = RegInit(0.U(16.W))
  mul_out_reg := stage2Sum + stage3Sum

  // Output enable is determined by the MSB of mul_en_out_reg
  io.mul_en_out := mul_en_out_reg(4)

  // Output assignment
  io.mul_out := Mux(io.mul_en_out, mul_out_reg, 0.U)
}

