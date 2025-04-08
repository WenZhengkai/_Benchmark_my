import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val mul_en_in  = Input(Bool())       // Input enable signal
    val mul_a      = Input(UInt(8.W))   // 8-bit multiplicand
    val mul_b      = Input(UInt(8.W))   // 8-bit multiplier
    val mul_en_out = Output(Bool())     // Output enable signal
    val mul_out    = Output(UInt(16.W)) // 16-bit product
  })

  // ------------------------------
  // Define pipeline registers
  // ------------------------------
  val stages = 5 // Number of pipeline stages for mul_en_out
  val mul_en_out_reg = RegInit(VecInit(Seq.fill(stages)(false.B)))
  val mul_a_reg = RegInit(VecInit(Seq.fill(stages)(0.U(8.W))))
  val mul_b_reg = RegInit(VecInit(Seq.fill(stages)(0.U(8.W))))

  // ------------------------------
  // Pipeline Updates
  // ------------------------------
  when(io.mul_en_in) {
    mul_en_out_reg(0) := io.mul_en_in    // Pipeline-stage 0 enable input
    mul_a_reg(0) := io.mul =>50 ]]
警告：dut9.scala格式异常
