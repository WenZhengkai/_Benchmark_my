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

  // Pipeline registers for enable signals (3 stages)
  val mul_en_out_reg = RegInit(VecInit(Seq.fill(3)(false.B)))
  
  // Input registers
  val mul_a_reg = RegInit(0.U(8.W))
  val mul_b_reg = RegInit(0.U(8.W))
  
  // Partial product generation wires
  val temp = Wire(Vec(8, UInt(8.W)))
  
  // Partial sum registers (pipelined)
  val sum = Reg(Vec(4, UInt(9.W))))  // Stage 1: 4 partial sums
  val sum2 = Reg(Vec(2, UInt(10.W))) // Stage 2: 2 partial sums
  val sum3 = Reg(UInt(11.W))         // Stage 3: final sum
  
  // Final product register
  val mul_out_reg = RegInit(0.U(16.W))

  // Pipeline the enable signal
  when(reset.asBool === false.B) {
    mul_en_out_reg(0) := io.mul_en_in
    for (i <- 1 until 3) {
      mul_en_out_reg(i) := mul_en_out_reg(i-1)
    }
  }

  // Input register update
  when(io.mul_en_in) {
    mul_a_reg := io.mul_a
    mul_b_reg := io.mul_b
  }

  // Partial product generation (combinational)
  for (i <- 0 until 8) {
    temp(i) := Mux(mul_b_reg(i), mul_a_reg << i, 0.U)
  }

  // Pipeline stage 1: First level of addition
  when(mul_en_out_reg(0)) {
    sum(0) := temp(0) + temp(1)
    sum(1) := temp(2) + temp(3)
    sum(2) := temp(4) + temp(5)
    sum(3) := temp(6) + temp(7)
  }.otherwise {
    sum.foreach(_ := 0.U)
  }

  // Pipeline stage 2: Second level of addition
  when(mul_en_out_reg(1)) {
    sum2(0) := sum(0) + sum(1)
    sum2(1) := sum(2) + sum(3)
  }.otherwise {
    sum2.foreach(_ := 0.U)
  }

  // Pipeline stage 3: Final addition
  when(mul_en_out_reg(2)) {
    sum3 := sum2(0) + sum2(1)
    mul_out_reg := sum3
  }.otherwise {
    sum3 := 0.U
  }

  // Output assignment
  io.mul_en_out := mul_en_out_reg(2)
  io.mul_out := Mux(io.mul_en_out, mul_out_reg, 0.U)
}

