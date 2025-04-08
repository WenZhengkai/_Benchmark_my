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

  // Task 1: Input Enable Shift Register
  val mul_en_out_reg = RegInit(0.U(3.W)) // 3-bit shift register initialized to 0
  mul_en_out_reg := Cat(mul_en_out_reg(1, 0), io.mul_en_in) // Shift and include new input
  io.mul_en_out := mul_en_out_reg(2) // Output is the final bit of the shift register

  // Task 2: Input Register Locking
  val mul_a_reg = Reg(UInt(8.W))
  val mul_b_reg = Reg(UInt(8.W))
  when(io.mul_en_in) {
    mul_a_reg := io.mul_a
    mul_b_reg := io.mul_b
  }

  // Task 3: Partial Product Generation
  val temp = Wire(Vec(8, UInt(16.W))) // Vector of 16-bit wires
  for (i <- 0 until 8) {
    temp(i) := Mux(mul_b_reg(i), (mul_a_reg << i).asUInt, 0.U) // Generate partial products
  }

  // Task 4: Pipelined Partial Sum Calculation
  // Stage 1: Pairwise sums
  val sum_stage1 = Reg(Vec(4, UInt(16.W)))
  sum_stage1(0) := temp(0) + temp(1)
  sum_stage1(1) := temp(2) + temp(3)
  sum_stage1(2) := temp(4) + temp(5)
  sum_stage1(3) := temp(6) + temp(7)

  // Stage 2: Next-level sums
  val sum_stage2 = Reg(Vec(2, UInt(16.W)))
  sum_stage2(0) := sum_stage1(0) + sum_stage1(1)
  sum_stage2(1) := sum_stage1(2) + sum_stage1(3)

  // Stage 3: Final sum
  val sum_stage3 = Reg(UInt(16.W))
  sum_stage3 := sum_stage2(0) + sum_stage2(1)

  // Task 5: Final Product Register
  val mul_out_reg = Reg(UInt(16.W))
  mul_out_reg := sum_stage3

  // Task 6: Output Gating Logic
  io.mul_out := Mux(io.mul_en_out, mul_out_reg, 0.U) // Gated output
}

