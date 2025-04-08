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

  // Task 1: Input Enable Shift Register for Pipeline Tracking
  val mul_en_out_reg = RegInit(0.U(5.W)) // 3-bit shift register initialized to 0
  mul_en_out_reg := Cat(mul_en_out_reg(3, 0), io.mul_en_in) // Shift new enable in
  io.mul_en_out := mul_en_out_reg(4) // Assign the last bit to the output enable

  // Task 2: Input Register Locking Mechanism
  val mul_a_reg = RegInit(0.U(8.W)) // 8-bit register for multiplicand
  val mul_b_reg = RegInit(0.U(8.W)) // 8-bit register for multiplier
  when(io.mul_en_in) {
    mul_a_reg := io.mul_a
    mul_b_reg := io.mul_b
  }

  // Task 3: Generate Partial Products Using Bitwise Operations
  val temp = Wire(Vec(8, UInt(16.W))) // 8-element vector of 16-bit wires
  for (i <- 0 until 8) {
    temp(i) := Mux(mul_b_reg(i), (mul_a_reg << i).asUInt, 0.U) // Partial products
  }

  // Task 4: Pipelined Partial Sum Calculation
  // Stage 1: Pairwise Sums
  val sum_stage1 = Reg(Vec(4, UInt(16.W)))
  sum_stage1(0) := temp(0) + temp(1)
  sum_stage1(1) := temp(2) + temp(3)
  sum_stage1(2) := temp(4) + temp(5)
  sum_stage1(3) := temp(6) + temp(7)

  // Stage 2: Next-Level Sums
  val sum_stage2 = Reg(Vec(2, UInt(16.W)))
  sum_stage2(0) := sum_stage1(0) + sum_stage1(1)
  sum_stage2(1) := sum_stage1(2) + sum_stage1(3)

  // Stage 3: Final Sum
  val sum_stage3 = Reg(UInt(16.W))
  sum_stage3 := sum_stage2(0) + sum_stage2(1)

  // Task 5: Final Product Register
  val mul_out_reg = Reg(UInt(16.W))
  mul_out_reg := sum_stage3

  // Task 6: Output Gating Logic
  io.mul_out := Mux(io.mul_en_out, mul_out_reg, 0.U) // Use enable control for output
}

