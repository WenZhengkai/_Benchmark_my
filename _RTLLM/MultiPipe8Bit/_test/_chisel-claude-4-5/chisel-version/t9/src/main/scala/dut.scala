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

  // Enable signal pipeline register (5 bits for 5 pipeline stages)
  val mul_en_out_reg = RegInit(VecInit(Seq.fill(5)(false.B)))
  
  // Shift the enable signal through the pipeline
  mul_en_out_reg(0) := io.mul_en_in
  for (i <- 1 until 5) {
    mul_en_out_reg(i) := mul_en_out_reg(i-1)
  }
  
  // Output enable is the last stage of the pipeline
  io.mul_en_out := mul_en_out_reg(4)

  // Input registers for multiplicand and multiplier
  val mul_a_reg = RegInit(0.U(8.W))
  val mul_b_reg = RegInit(0.U(8.W))
  
  when(io.mul_en_in) {
    mul_a_reg := io.mul_a
    mul_b_reg := io.mul_b
  }

  // Partial product generation
  // temp(i) represents the partial product for bit i of multiplier
  val temp = Wire(Vec(8, UInt(16.W)))
  
  for (i <- 0 until 8) {
    temp(i) := Mux(mul_b_reg(i), 
                   Cat(0.U((8-i).W), mul_a_reg, 0.U(i.W)),
                   0.U(16.W))
  }

  // Partial sum calculation using pipeline stages
  // Stage 1: Sum pairs of partial products (0+1, 2+3, 4+5, 6+7)
  val sum_stage1 = RegInit(VecInit(Seq.fill(4)(0.U(16.W))))
  sum_stage1(0) := temp(0) + temp(1)
  sum_stage1(1) := temp(2) + temp(3)
  sum_stage1(2) := temp(4) + temp(5)
  sum_stage1(3) := temp(6) + temp(7)

  // Stage 2: Sum pairs from stage 1 (0+1, 2+3)
  val sum_stage2 = RegInit(VecInit(Seq.fill(2)(0.U(16.W))))
  sum_stage2(0) := sum_stage1(0) + sum_stage1(1)
  sum_stage2(1) := sum_stage1(2) + sum_stage1(3)

  // Stage 3: Final sum
  val sum_stage3 = RegInit(0.U(16.W))
  sum_stage3 := sum_stage2(0) + sum_stage2(1)

  // Final product register
  val mul_out_reg = RegInit(0.U(16.W))
  mul_out_reg := sum_stage3

  // Output assignment
  io.mul_out := Mux(io.mul_en_out, mul_out_reg, 0.U(16.W))
}

// Generate Verilog
/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(), Array("--target-dir", "generated"))
}
*/
