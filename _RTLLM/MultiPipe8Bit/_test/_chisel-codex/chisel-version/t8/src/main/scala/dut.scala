import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val mul_en_in  = Input(Bool())
    val mul_a      = Input(UInt(8.W))
    val mul_b      = Input(UInt(8.W))
    val mul_en_out = Output(Bool())
    val mul_out    = Output(UInt(16.W))
  })

  // 5-bit enable pipeline register
  val mul_en_out_reg = RegInit(0.U(5.W))
  mul_en_out_reg := Cat(mul_en_out_reg(3, 0), io.mul_en_in)

  // Input registers (updated only when input enable is asserted)
  val mul_a_reg = RegInit(0.U(8.W))
  val mul_b_reg = RegInit(0.U(8.W))
  when(io.mul_en_in) {
    mul_a_reg := io.mul_a
    mul_b_reg := io.mul_b
  }

  // Partial product generation
  val temp = Wire(Vec(8, UInt(16.W)))
  for (i <- 0 until 8) {
    temp(i) := Mux(mul_b_reg(i), (mul_a_reg.asUInt << i).asUInt, 0.U(16.W))
  }

  // Pipeline stage enables (using pre-update values of mul_en_out_reg in this cycle)
  val stg1_en = mul_en_out_reg(0)
  val stg2_en = mul_en_out_reg(1)
  val stg3_en = mul_en_out_reg(2)
  val stg4_en = mul_en_out_reg(3)

  // Partial sum registers
  val sum1 = RegInit(VecInit(Seq.fill(4)(0.U(16.W)))) // level-1: 8 -> 4
  val sum2 = RegInit(VecInit(Seq.fill(2)(0.U(16.W)))) // level-2: 4 -> 2
  val sum3 = RegInit(0.U(16.W))                       // level-3: 2 -> 1

  when(stg1_en) {
    sum1(0) := temp(0) +& temp(1)
    sum1(1) := temp(2) +& temp(3)
    sum1(2) := temp(4) +& temp(5)
    sum1(3) := temp(6) +& temp(7)
  }

  when(stg2_en) {
    sum2(0) := sum1(0) +& sum1(1)
    sum2(1) := sum1(2) +& sum1(3)
  }

  when(stg3_en) {
    sum3 := sum2(0) +& sum2(1)
  }

  // Final product register
  val mul_out_reg = RegInit(0.U(16.W))
  when(stg4_en) {
    mul_out_reg := sum3
  }

  // Outputs
  io.mul_en_out := mul_en_out_reg(4)
  io.mul_out    := Mux(io.mul_en_out, mul_out_reg, 0.U(16.W))
}
