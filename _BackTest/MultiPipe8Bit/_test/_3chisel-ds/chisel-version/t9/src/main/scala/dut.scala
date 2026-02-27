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

  // Pipeline registers for enable signal (shift register style)
  val mul_en_out_reg = RegInit(VecInit(Seq.fill(5)(false.B)))
  
  // Input registers
  val mul_a_reg = Reg(UInt(8.W))
  val mul_b_reg = Reg(UInt(8.W))
  
  // Partial product generation wires
  val temp = Wire(Vec(8, UInt(8.W)))
  
  // Partial sum registers
  val sum = Reg(Vec(4, UInt(16.W)))
  
  // Final product register
  val mul_out_reg = Reg(UInt(16.W))

  // Pipeline control logic
  when(io.mul_en_in) {
    // Shift in new enable value
    mul_en_out_reg(0) := true.B
    for (i <- 1 until 5) {
      mul_en_out_reg(i) := mul_en_out_reg(i-1)
    }
    
    // Sample inputs when enabled
    mul_a_reg := io.mul_a
    mul_b_reg := io.mul_b
  }.otherwise {
    // Shift in 0 when not enabled
    mul_en_out_reg(0) := false.B
    for (i <- 1 until 5) {
      mul_en_out_reg(i) := mul_en_out_reg(i-1)
    }
  }

  // Partial product generation
  for (i <- 0 until 8) {
    temp(i) := Mux(mul_b_reg(i), mul_a_reg, 0.U)
  }

  // Pipeline stage 1: First level of addition
  val sum_stage1_0 = temp(0) +& (temp(1) << 1)
  val sum_stage1_1 = temp(2) +& (temp(3) << 1)
  val sum_stage1_2 = temp(4) +& (temp(5) << 1)
  val sum_stage1_3 = temp(6) +& (temp(7) << 1)

  // Pipeline stage 2: Second level of addition
  when(mul_en_out_reg(1)) {
    sum(0) := sum_stage1_0 +& (sum_stage1_1 << 2)
    sum(1) := sum_stage1_2 +& (sum_stage1_3 << 2)
  }.otherwise {
    sum(0) := 0.U
    sum(1) := 0.U
  }

  // Pipeline stage 3: Third level of addition
  val sum_stage3 = Reg(UInt(16.W))
  when(mul_en_out_reg(2)) {
    sum_stage3 := sum(0) +& (sum(1) << 4)
  }.otherwise {
    sum_stage3 := 0.U
  }

  // Final product calculation
  when(mul_en_out_reg(3)) {
    mul_out_reg := sum_stage3
  }.otherwise {
    mul_out_reg := 0.U
  }

  // Output assignments
  io.mul_en_out := mul_en_out_reg(4)
  io.mul_out := Mux(io.mul_en_out, mul_out_reg, 0.U)
}

