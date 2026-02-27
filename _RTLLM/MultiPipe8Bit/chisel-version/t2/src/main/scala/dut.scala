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

  // Pipeline registers for control signal
  val mul_en_out_reg = RegInit(VecInit(Seq.fill(5)(false.B)))
  
  // Pipeline the enable signal
  mul_en_out_reg(0) := io.mul_en_in
  for (i <- 1 until 5) {
    mul_en_out_reg(i) := mul_en_out_reg(i-1)
  }
  
  // Connect output enable signal to the last pipeline stage
  io.mul_en_out := mul_en_out_reg(4)

  // Input registers
  val mul_a_reg = RegEnable(io.mul_a, 0.U(8.W), io.mul_en_in)
  val mul_b_reg = RegEnable(io.mul_b, 0.U(8.W), io.mul_en_in)

  // Partial product generation
  val temp = Wire(Vec(8, UInt(8.W)))
  for (i <- 0 until 8) {
    temp(i) := Mux(mul_b_reg(i), mul_a_reg, 0.U) << i
  }

  // Pipeline stage 1: First level partial sum calculation
  val sum1_0 = RegNext(temp(0) + temp(1))
  val sum1_1 = RegNext(temp(2) + temp(3))
  val sum1_2 = RegNext(temp(4) + temp(5))
  val sum1_3 = RegNext(temp(6) + temp(7))

  // Pipeline stage 2: Second level partial sum calculation
  val sum2_0 = RegNext(sum1_0 + sum1_1)
  val sum2_1 = RegNext(sum1_2 + sum1_3)

  // Pipeline stage 3: Final product calculation
  val mul_out_reg = RegNext(sum2_0 + sum2_1)

  // Output assignment
  io.mul_out := Mux(io.mul_en_out, mul_out_reg, 0.U)
}
