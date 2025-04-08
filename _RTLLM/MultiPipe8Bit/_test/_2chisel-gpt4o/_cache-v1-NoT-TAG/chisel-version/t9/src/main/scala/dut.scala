import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val mul_en_in  = Input(Bool())          // Input enable signal
    val mul_a      = Input(UInt(8.W))      // Multiplicand (8-bit)
    val mul_b      = Input(UInt(8.W))      // Multiplier (8-bit)
    val mul_en_out = Output(Bool())        // Output enable signal
    val mul_out    = Output(UInt(16.W))    // 16-bit product output
  })

  // Task 1: Implement input enable shift register for pipeline tracking
  val mul_en_out_reg = RegInit(0.U(3.W))   // 3-bit shift register initialzed to 0
  mul_en_out_reg := Cat(mul_en_out_reg(1, 0), io.mul_en_in)  // Shift mul_en_in into the register
  io.mul_en_out := mul_en_out_reg(2)       // Assign mul_en_out as the last bit of the shift register

  // Task 2: Implement input register locking mechanism
  val mul_a_reg = Reg(UInt(8.W))           // 8-bit register for multiplicand
  val mul_b_reg = Reg(UInt(8.W))           // 8-bit register for multiplier
  when(io.mul_en_in) {
    mul_a_reg := io.mul_a                  // Lock mul_a when mul_en_in is high
    mul_b_reg := io.mul_b                  // Lock mul_b when mul_en_in is high
  }

  // Task 3: Generate partial products using bitwise operations
  val temp = Wire(Vec(8, UInt(16.W)))      // 8-element vector for partial products
  for (i <- 0 until 8) {
    temp(i) := Mux(mul_b_reg(i), (mul_a_reg << i).asUInt, 0.U)  // Generate partial products
  }

  // Task 4: Implement pipelined partial sum calculation
  // Stage 1: Pairwise sums of partial products
  val sum_stage1 = Reg(Vec(4, UInt(16.W))) // 4 intermediate registers for stage 1 sums
  sum_stage1(0) := temp(0) + temp(1)
  sum_stage1(1) := temp(2) + temp(3)
  sum_stage1(2) := temp(4) + temp(5)
  sum_stage1(3) := temp(6) + temp(7)

  // Stage 2: Next-level pairwise sums
  val sum_stage2 = Reg(Vec(2, UInt(16.W))) // 2 intermediate registers for stage 2 sums
  sum_stage2(0) := sum_stage1(0) + sum_stage1(1)
  sum_stage2(1) := sum_stage1(2) + sum_stage1(3)

  // Stage 3: Final sum
  val sum_stage3 = Reg(UInt(16.W))         // 1 intermediate register for stage 3 sum
  sum_stage3 := sum_stage2(0) + sum_stage2(1)

  // Task 5: Implement final product register
  val mul_out_reg = Reg(UInt(16.W))        // 16-bit register for final product
  mul_out_reg := sum_stage3                // Store the final sum in the product register

  // Task 6: Implement output gating logic
  io.mul_out := Mux(io.mul_en_out, mul_out_reg, 0.U)  // Output gated by mul_en_out signal
}

