import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val mul_en_in = Input(Bool())               // Input enable signal
    val mul_a = Input(UInt(8.W))               // 8-bit multiplicand
    val mul_b = Input(UInt(8.W))               // 8-bit multiplier
    val mul_en_out = Output(Bool())            // Output enable signal
    val mul_out = Output(UInt(16.W))           // 16-bit product output
  })

  // Task 1: Input control logic
  // 5-bit shift register to store enable signal across clock cycles
  val mul_en_out_reg = RegInit(0.U(5.W))
  when(io.mul_en_in) {
    mul_en_out_reg := Cat(mul_en_out_reg(3, 0), io.mul_en_in)
  }
  val mul_en_out = mul_en_out_reg(4)
  io.mul_en_out := mul_en_out

  // Task 2: Input registers for `mul_a` and `mul_b`
  val mul_a_reg = RegInit(0.U(8.W))
  val mul_b_reg = RegInit(0.U(8.W))
  when(io.mul_en_in) {
    mul_a_reg := io.mul_a
    mul_b_reg := io.mul_b
  }

  // Task 3: Generate partial products
  val temp = Wire(Vec(8, UInt(16.W)))
  for (i <- 0 until 8) {
    temp(i) := Cat(0.U((7 - i).W), (mul_a_reg & Fill(8, mul_b_reg(i))), 0.U(i.W))
  }

  // Task 4: Partial sum calculation (pipelined)
  val sum1 = RegInit(0.U(16.W))
  val sum2 = RegInit(0.U(16.W))
  val sum3 = RegInit(0.U(16.W))
  val sum4 = RegInit(0.U(16.W))

  when(io.mul_en_in) {
    // Pipeline stage 1: Add partial products temp(0) and temp(1)
    sum1 := temp(0) + temp(1)
    // Pipeline stage 2: Add partial products temp(2), temp(3), and sum1
    sum2 := temp(2) + temp(3) + sum1
    // Pipeline stage 3: Add partial products temp(4), temp(5), and sum2
    sum3 := temp(4) + temp(5) + sum2
    // Pipeline stage 4: Add partial products temp(6), temp(7), and sum3
    sum4 := temp(6) + temp(7) + sum3
  }

  // Task 5: Calculate final product
  val mul_out_reg = RegInit(0.U(16.W))
  when(io.mul_en_in) {
    mul_out_reg := sum4
  }

  // Task 6: Output assignment
  io.mul_out := Mux(mul_en_out, mul_out_reg, 0.U)
}
