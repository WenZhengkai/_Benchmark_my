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
  
  // Input registers (only update when enabled)
  val mul_a_reg = Reg(UInt(8.W))
  val mul_b_reg = Reg(UInt(8.W))
  
  // Partial product generation wires
  val temp = Wire(Vec(8, Vec(8, UInt(1.W))))
  
  // Partial sum registers
  val sum = Reg(Vec(4, UInt(10.W)))
  
  // Final product register
  val mul_out_reg = Reg(UInt(16.W))

  // Pipeline the enable signal
  when(io.mul_en_in) {
    mul_en_out_reg(0) := true.B
  }.otherwise {
    mul_en_out_reg(0) := false.B
  }
  
  for (i <- 1 until 5) {
    mul_en_out_reg(i) := mul_en_out_reg(i-1)
  }

  // Input registers
  when(io.mul_en_in) {
    mul_a_reg := io.mul_a
    mul_b_reg := io.mul_b
  }

  // Partial product generation
  for (i <- 0 until 8) {
    for (j <- 0 until 8) {
      temp(i)(j) := mul_a_reg(j) & mul_b_reg(i)
    }
  }

  // Pipeline stage 1: First level of addition
  val sum_stage1 = Wire(Vec(4, UInt(10.W)))
  
  sum_stage1(0) := Cat(0.U(2.W), temp(0).asUInt) + 
                  Cat(0.U(1.W), temp(1).asUInt, 0.U(1.W))
  
  sum_stage1(1) := Cat(0.U(2.W), temp(2).asUInt) + 
                  Cat(0.U(1.W), temp(3).asUInt, 0.U(1.W))
  
  sum_stage1(2) := Cat(0.U(2.W), temp(4).asUInt) + 
                  Cat(0.U(1.W), temp(5).asUInt, 0.U(1.W))
  
  sum_stage1(3) := Cat(0.U(2.W), temp(6).asUInt) + 
                  Cat(0.U(1.W), temp(7).asUInt, 0.U(1.W))

  // Pipeline stage 2: Register first level sums
  sum(0) := sum_stage1(0)
  sum(1) := sum_stage1(1)
  sum(2) := sum_stage1(2)
  sum(3) := sum_stage1(3)

  // Pipeline stage 3: Second level of addition
  val sum_stage2 = Wire(Vec(2, UInt(12.W)))
  
  sum_stage2(0) := Cat(0.U(2.W), sum(0)) + 
                  Cat(0.U(2.W), sum(1), 0.U(2.W))
  
  sum_stage2(1) := Cat(0.U(2.W), sum(2)) + 
                  Cat(0.U(2.W), sum(3), 0.U(2.W))

  // Pipeline stage 4: Final addition
  val final_sum = sum_stage2(0) + (sum_stage2(1) << 4)

  // Register final product
  mul_out_reg := final_sum

  // Output assignment
  io.mul_en_out := mul_en_out_reg(4)
  io.mul_out := Mux(io.mul_en_out, mul_out_reg, 0.U)
}

