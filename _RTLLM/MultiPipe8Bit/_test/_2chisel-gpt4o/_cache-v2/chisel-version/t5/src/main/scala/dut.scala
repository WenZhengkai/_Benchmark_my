import chisel3._
import chisel3.util._

/**
 * 8-bit unsigned multiplier with pipelining.
 */
class dut extends Module {
  val io = IO(new Bundle {
    val mul_en_in = Input(Bool())     // Input enable signal
    val mul_a = Input(UInt(8.W))      // Multiplicand (8 bits)
    val mul_b = Input(UInt(8.W))      // Multiplier (8 bits)
    val mul_en_out = Output(Bool())   // Output enable signal
    val mul_out = Output(UInt(16.W))  // Product output (16 bits)
  })

  // Number of pipeline stages
  val pipelineStages = 5

  // Registers for input enable signal to implement pipeline delay
  val mul_en_out_reg = RegInit(0.U(pipelineStages.W))
  when(io.mul_en_in) {
    mul_en_out_reg := Cat(mul_en_out_reg(pipelineStages - 2, 0), io.mul_en_in)
  }.otherwise {
    mul_en_out_reg := mul_en_out_reg >> 1
  }

  val mul_en_out = mul_en_out_reg(pipelineStages - 1)
  io.mul_en_out := mul_en_out

  // Pipeline registers for inputs mul_a and mul_b
  val mul_a_reg = RegInit(0.U(8.W))
  val mul_b_reg = RegInit(0.U(8.W))
  when(io.mul_en_in) {
    mul_a_reg := io.mul_a
    mul_b_reg := io.mul_b
  }

  // Pipeline registers for partial products and sums
  val temp = Wire(Vec(8, UInt(16.W))) // Wires for partial products (8 bits x 8 bits)
  val sum = Reg(Vec(4, UInt(16.W)))  // Registers for intermediate sums

  // Generating partial products
  for (i <- 0 until 8) {
    temp(i) := Mux(mul_b_reg(i), mul_a_reg << i, 0.U)
  }

  // First pipeline stage: Pairwise addition of partial products
  sum(0) := temp(0) + temp(1)
  sum(1) := temp(2) + temp(3)
  sum(2) := temp(4) + temp(5)
  sum(3) := temp(6) + temp(7)

  // Second pipeline stage: Combine intermediate sums
  val sum_stage2_1 = RegNext(sum(0) + sum(1))
  val sum_stage2_2 = RegNext(sum(2) + sum(3))

  // Final pipeline stage: Compute the final result
  val mul_out_reg = RegInit(0.U(16.W))
  when(mul_en_out === 1.U) {
    mul_out_reg := sum_stage2_1 + sum_stage2_2
  }.otherwise {
    mul_out_reg := 0.U
  }

  // Output assignment
  io.mul_out := mul_out_reg
}
