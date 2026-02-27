import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    // Input ports
    val mul_en_in = Input(Bool())
    val mul_a     = Input(UInt(8.W))
    val mul_b     = Input(UInt(8.W))
    
    // Output ports
    val mul_en_out = Output(Bool())
    val mul_out    = Output(UInt(16.W))
  })

  // Pipeline registers for enable signal
  val mul_en_out_reg = RegInit(0.U(3.W))
  when(reset.asBool) {
    mul_en_out_reg := 0.U
  }.otherwise {
    mul_en_out_reg := Cat(mul_en_out_reg(1, 0), io.mul_en_in)
  }
  io.mul_en_out := mul_en_out_reg(2)

  // Input registers (Stage 1)
  val mul_a_reg = Reg(UInt(8.W))
  val mul_b_reg = Reg(UInt(8.W))
  when(io.mul_en_in) {
    mul_a_reg := io.mul_a
    mul_b_reg := io.mul_b
  }

  // Partial product generation (Stage 2)
  val partial_products = Wire(Vec(8, UInt(16.W)))
  for (i <- 0 until 8) {
    partial_products(i) := Mux(mul_b_reg(i), mul_a_reg << i, 0.U)
  }

  // First level of partial sums (Stage 3)
  val sum_stage1_reg = Reg(Vec(4, UInt(16.W)))
  when(mul_en_out_reg(0)) {
    sum_stage1_reg(0) := partial_products(0) + partial_products(1)
    sum_stage1_reg(1) := partial_products(2) + partial_products(3)
    sum_stage1_reg(2) := partial_products(4) + partial_products(5)
    sum_stage1_reg(3) := partial_products(6) + partial_products(7)
  }

  // Second level of partial sums (Stage 4)
  val sum_stage2_reg = Reg(Vec(2, UInt(16.W)))
  when(mul_en_out_reg(1)) {
    sum_stage2_reg(0) := sum_stage1_reg(0) + sum_stage1_reg(1)
    sum_stage2_reg(1) := sum_stage1_reg(2) + sum_stage1_reg(3)
  }

  // Final sum (Stage 5)
  val mul_out_reg = Reg(UInt(16.W))
  when(mul_en_out_reg(2)) {
    mul_out_reg := sum_stage2_reg(0) + sum_stage2_reg(1)
  }

  // Output assignment
  io.mul_out := Mux(io.mul_en_out, mul_out_reg, 0.U)
}

