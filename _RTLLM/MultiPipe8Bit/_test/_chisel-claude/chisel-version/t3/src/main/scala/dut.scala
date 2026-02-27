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
  val mul_en_out_reg = RegInit(0.U(5.W))
  
  // Input registers
  val mul_a_reg = RegInit(0.U(8.W))
  val mul_b_reg = RegInit(0.U(8.W))
  
  // Register updates for input control
  when(io.mul_en_in) {
    mul_a_reg := io.mul_a
    mul_b_reg := io.mul_b
  }
  
  // Update enable pipeline register
  mul_en_out_reg := Cat(mul_en_out_reg(3, 0), io.mul_en_in)
  
  // Generate partial products
  val pp0 = mul_a_reg & Fill(8, mul_b_reg(0))
  val pp1 = mul_a_reg & Fill(8, mul_b_reg(1))
  val pp2 = mul_a_reg & Fill(8, mul_b_reg(2))
  val pp3 = mul_a_reg & Fill(8, mul_b_reg(3))
  val pp4 = mul_a_reg & Fill(8, mul_b_reg(4))
  val pp5 = mul_a_reg & Fill(8, mul_b_reg(5))
  val pp6 = mul_a_reg & Fill(8, mul_b_reg(6))
  val pp7 = mul_a_reg & Fill(8, mul_b_reg(7))
  
  // Pipeline stage 1: Partial sum calculation
  val sum1_reg = RegNext(Cat(0.U(1.W), pp0) + Cat(0.U(1.W), pp1) << 1)
  val sum2_reg = RegNext(Cat(0.U(1.W), pp2) << 2 + Cat(0.U(1.W), pp3) << 3)
  val sum3_reg = RegNext(Cat(0.U(1.W), pp4) << 4 + Cat(0.U(1.W), pp5) << 5)
  val sum4_reg = RegNext(Cat(0.U(1.W), pp6) << 6 + Cat(0.U(1.W), pp7) << 7)
  
  // Pipeline stage 2: Combine partial sums
  val sum12_reg = RegNext(sum1_reg + sum2_reg)
  val sum34_reg = RegNext(sum3_reg + sum4_reg)
  
  // Pipeline stage 3: Final product calculation
  val mul_out_reg = RegNext(sum12_reg + sum34_reg)
  
  // Output assignments
  io.mul_en_out := mul_en_out_reg(4)
  io.mul_out := Mux(io.mul_en_out, mul_out_reg, 0.U)
}
