
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

  // Pipeline registers for enable signal (shift register)
  val mul_en_out_reg = RegInit(VecInit(Seq.fill(5)(false.B)))
  
  // Input registers (Stage 1)
  val mul_a_reg = RegInit(0.U(8.W))
  val mul_b_reg = RegInit(0.U(8.W))
  
  // Partial products (Stage 2)
  val temp = Wire(Vec(8, UInt(8.W)))
  
  // Partial sums registers (Stage 3)
  val sum1 = RegInit(0.U(9.W))
  val sum2 = RegInit(0.U(10.W))
  val sum3 = RegInit(0.U(12.W))
  
  // Final product register (Stage 4)
  val mul_out_reg = RegInit(0.U(16.W))

  // Pipeline control logic
  when(reset.asBool || !io.rst_n) {
    // Reset all registers
    mul_en_out_reg.foreach(_ := false.B)
    mul_a_reg := 0.U
    mul_b_reg := 0.U
    sum1 := 0.U
    sum2 := 0.U
    sum3 := 0.U
    mul_out_reg := 0.U
  }.otherwise {
    // Shift enable signal through pipeline
    mul_en_out_reg(0) := io.mul_en_in
    for (i <- 1 until 5) {
      mul_en_out_reg(i) := mul_en_out_reg(i-1)
    }
    
    // Stage 1: Register inputs when enabled
    when(io.mul_en_in) {
      mul_a_reg := io.mul_a
      mul_b_reg := io.mul_b
    }
    
    // Stage 2: Generate partial products (combinational)
    for (i <- 0 until 8) {
      temp(i) := Mux(mul_b_reg(i), mul_a_reg, 0.U)
    }
    
    // Stage 3: Calculate partial sums
    sum1 := Cat(0.U(1.W), temp(0)) + Cat(temp(1), 0.U(1.W))
    sum2 := Cat(0.U(1.W), sum1) + Cat(temp(2), 0.U(2.W)) + Cat(temp(3), 0.U(3.W))
    sum3 := Cat(0.U(2.W), sum2) + Cat(temp(4), 0.U(4.W)) + Cat(temp(5), 0.U(5.W))
    
    // Stage 4: Final addition
    mul_out_reg := Cat(0.U(4.W), sum3) + Cat(temp(6), 0.U(6.W)) + Cat(temp(7), 0.U(7.W))
  }
  
  // Output assignments
  io.mul_en_out := mul_en_out_reg(4)
  io.mul_out    := Mux(mul_en_out_reg(4), mul_out_reg, 0.U)
}

