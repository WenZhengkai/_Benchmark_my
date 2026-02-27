import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    // Input ports
    val mul_en_in = Input(Bool())
    val mul_a = Input(UInt(8.W))
    val mul_b = Input(UInt(8.W))
    
    // Output ports
    val mul_en_out = Output(Bool())
    val mul_out = Output(UInt(16.W))
  })

  // Pipeline registers for enable signal
  val mul_en_out_reg = RegInit(0.U(2.W))
  io.mul_en_out := mul_en_out_reg(1)

  // Input registers (only update when enabled)
  val mul_a_reg = RegEnable(io.mul_a, 0.U(8.W), io.mul_en_in)
  val mul_b_reg = RegEnable(io.mul_b, 0.U(8.W), io.mul_en_in)

  // Partial product generation
  val temp = Wire(Vec(8, UInt(9.W))) // 9 bits to accommodate shifted values
  for (i <- 0 until 8) {
    temp(i) := Mux(mul_b_reg(i), mul_a_reg << i, 0.U)
  }

  // Pipeline stage 1: First level of addition
  val sum1_reg = Reg(UInt(10.W))
  val sum2_reg = Reg(UInt(10.W))
  val sum3_reg = Reg(UInt(10.W))
  val sum4_reg = Reg(UInt(10.W))

  when(mul_en_out_reg(0)) {
    sum1_reg := temp(0) +& temp(1) // +& for proper width extension
    sum2_reg := temp(2) +& temp(3)
    sum3_reg := temp(4) +& temp(5)
    sum4_reg := temp(6) +& temp(7)
  }.otherwise {
    sum1_reg := 0.U
    sum2_reg := 0.U
    sum3_reg := 0.U
    sum4_reg := 0.U
  }

  // Pipeline stage 2: Second level of addition
  val sum5_reg = Reg(UInt(11.W))
  val sum6_reg = Reg(UInt(11.W))

  when(mul_en_out_reg(1)) {
    sum5_reg := sum1_reg +& sum2_reg
    sum6_reg := sum3_reg +& sum4_reg
  }.otherwise {
    sum5_reg := 0.U
    sum6_reg := 0.U
  }

  // Pipeline stage 3: Final addition
  val mul_out_reg = Reg(UInt(16.W))

  when(mul_en_out_reg(2)) {
    mul_out_reg := sum5_reg +& sum6_reg
  }.otherwise {
    mul_out_reg := 0.U
  }

  // Output assignment
  io.mul_out := Mux(io.mul_en_out, mul_out_reg, 0.U)

  // Pipeline control logic
  when(reset.asBool || !io.mul_en_in) {
    mul_en_out_reg := 0.U
  }.otherwise {
    mul_en_out_reg := Cat(mul_en_out_reg(1, 0), io.mul_en_in)
  }
}