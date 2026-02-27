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

  // Pipeline registers for enable signals (3 stages)
  val mul_en_out_reg = RegInit(VecInit(Seq.fill(3)(false.B)))
  
  // Input registers (only update when enabled)
  val mul_a_reg = RegInit(0.U(8.W))
  val mul_b_reg = RegInit(0.U(8.W))
  
  // Partial product wires
  val temp = Wire(Vec(8, UInt(9.W))) // 8 partial products (each 9 bits)
  
  // Pipeline registers for partial sums (2 stages)
  val sum = Reg(Vec(2, UInt(16.W)))
  val mul_out_reg = RegInit(0.U(16.W))

  // Pipeline the enable signal
  mul_en_out_reg(0) := io.mul_en_in
  for (i <- 1 until 3) {
    mul_en_out_reg(i) := mul_en_out_reg(i-1)
  }
  io.mul_en_out := mul_en_out_reg(2)

  // Stage 1: Register inputs and generate partial products
  when(io.mul_en_in) {
    mul_a_reg := io.mul_a
    mul_b_reg := io.mul_b
  }

  // Generate partial products
  for (i <- 0 until 8) {
    temp(i) := Mux(mul_b_reg(i), mul_a_reg, 0.U) << i
  }

  // Stage 2: First level of addition (4 additions)
  when(mul_en_out_reg(0)) {
    sum(0) := temp(0) +& temp(1) +& temp(2) +& temp(3)
    sum(1) := temp(4) +& temp(5) +& temp(6) +& temp(7)
  }.otherwise {
    sum(0) := 0.U
    sum(1) := 0.U
  }

  // Stage 3: Final addition
  when(mul_en_out_reg(1)) {
    mul_out_reg := sum(0) +& sum(1)
  }.otherwise {
    mul_out_reg := 0.U
  }

  // Output assignment
  io.mul_out := Mux(mul_en_out_reg(2), mul_out_reg, 0.U)
}