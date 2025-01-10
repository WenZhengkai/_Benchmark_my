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

  // Input Control Register
  val mul_en_out_reg = RegInit(false.B)
  val mul_a_reg = Reg(UInt(8.W))
  val mul_b_reg = Reg(UInt(8.W))

  // Intermediate Registers for Partial Products and Sums
  val partialSums = RegInit(VecInit(Seq.fill(9)(0.U(16.W)))) // 9 to account for 8 partial steps
  val sum = RegInit(0.U(16.W))

  // Pipeline 1: Register inputs and enable signal
  when(io.mul_en_in) {
    mul_en_out_reg := true.B
    mul_a_reg := io.mul_a
    mul_b_reg := io.mul_b
  } .otherwise {
    mul_en_out_reg := false.B
  }

  // Partial product generation
  val temp = Wire(Vec(8, UInt(16.W)))
  for (i <- 0 until 8) {
    temp(i) := Mux(mul_b_reg(i), mul_a_reg << i, 0.U)
  }

  // Pipeline 2: Calculate and store partial sums
  for (i <- 0 until 8) {
    partialSums(i + 1) := (partialSums(i) + temp(i))
  }

  // Pipeline 3: Final sum calculation
  sum := partialSums(8)

  // Output Assignment
  io.mul_en_out := mul_en_out_reg
  io.mul_out := Mux(mul_en_out_reg, sum, 0.U)
}


