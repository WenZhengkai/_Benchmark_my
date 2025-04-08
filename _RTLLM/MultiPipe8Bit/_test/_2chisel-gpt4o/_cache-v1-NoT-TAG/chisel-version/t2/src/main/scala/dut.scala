import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val mul_en_in = Input(Bool()) // Input enable signal
    val mul_a = Input(UInt(8.W)) // Multiplicand (8 bits)
    val mul_b = Input(UInt(8.W)) // Multiplier (8 bits)
    val mul_en_out = Output(Bool()) // Output enable signal
    val mul_out = Output(UInt(16.W)) // Product output (16 bits)
  })

  // ----------------
  // Task 1: Input enable shift register for pipeline tracking
  // ----------------
  val mul_en_out_reg = RegInit(0.U(3.W)) // 3-bit shift register initialized to 0
  mul_en_out_reg := Cat(mul_en_out_reg(1, 0), io.mul_en_in) // Update based on pipeline
  io.mul_en_out := mul_en_out_reg(2) // Assign the last bit to output enable

  // ----------------
  // Task 2: Input register locking mechanism
  // ----------------
  val mul_a_reg = RegInit(0.U(8.W)) // 8-bit locked register for multiplicand
  val mul_b_reg = RegInit(0.U(8.W)) // 8-bit locked register for multiplier
  when(io.mul_en_in) {
    mul_a_reg := io.mul_a
    mul_b_reg := io.mul_b
  }

  // ----------------
  // Task 3: Partial products generation
  // ----------------
  val temp = Wire(Vec(8, UInt(16.W))) // 8-element vector to hold partial products
  for (i <- 0 until 8) {
    temp(i) := Mux(mul_b_reg(i), (mul_a_reg << i).asUInt, 0.U)
  }

  // ----------------
  // Task 4: Pipelined partial sum calculation
  // ----------------
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

  // ----------------
  // Task 5: Final product register
  // ----------------
  val mul_out_reg = Reg(UInt(16.W)) // Final product register
  mul_out_reg := sum_stage3

  // ----------------
  // Task 6: Output gating logic
  // ----------------
  io.mul_out := Mux(io.mul_en_out, mul_out_reg, 0.U) // Output final product gated by enable
}

