import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    // Input ports
    val mul_en_in = Input(Bool()) // Input enable signal
    val mul_a = Input(UInt(8.W)) // Multiplicand
    val mul_b = Input(UInt(8.W)) // Multiplier

    // Output ports
    val mul_en_out = Output(Bool()) // Output enable signal
    val mul_out = Output(UInt(16.W)) // 16-bit product output
  })

  // Task 1: Input enable shift register for pipeline tracking
  val mul_en_out_reg = RegInit(0.U(3.W)) // 3-bit shift register initialized to 0
  mul_en_out_reg := Cat(mul_en_out_reg(1, 0), io.mul_en_in) // Update shift register
  io.mul_en_out := mul_en_out_reg(2) // Output last bit as mul_en_out

  // Task 2: Input register locking mechanism
  val mul_a_reg = Reg(UInt(8.W))
  val mul_b_reg = Reg(UInt(8.W))
  when(io.mul_en_in) {
    mul_a_reg := io.mul_a
    mul_b_reg := io.mul_b
  }

  // Task 3: Generate partial products using bitwise operations
  val temp = Wire(Vec(8, UInt(16.W))) // 8-element vector of 16-bit wires
  for (i <- 0 until 8) {
    temp(i) := Mux(mul_b_reg(i), (mul_a_reg << i).asUInt, 0.U)
  }

  // Task 4: Pipelined partial sum calculation
  // Stage 1: Pairwise sums of partial products
  val sum_stage1 = Reg(Vec(4, UInt(16.W)))
  sum_stage1(0) := temp(0) + temp(1)
  sum_stage1(1) := temp(2) + temp(3)
  sum_stage1(2) := temp(4) + temp(5)
  sum_stage1(3) := temp(6) + temp(7)

  // Stage 2: Summation of Stage 1 results
  val sum_stage2 = Reg(Vec(2, UInt(16.W)))
  sum_stage2(0) := sum_stage1(0) + sum_stage1(1)
  sum_stage2(1) := sum_stage1(2) + sum_stage1(3)

  // Stage 3: Final summation of Stage 2 results
  val sum_stage3 = Reg(UInt(16.W))
  sum_stage3 := sum_stage2(0) + sum_stage2(1)

  // Task 5: Final product register
  val mul_out_reg = Reg(UInt(16.W))
  mul_out_reg := sum_stage3

  // Task 6: Output gating logic
  io.mul_out := Mux(io.mul_en_out, mul_out_reg, 0.U)
}

