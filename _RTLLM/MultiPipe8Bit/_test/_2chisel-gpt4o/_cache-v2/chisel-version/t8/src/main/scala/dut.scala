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

  // ---- Internal Registers and Wires -----
  // Registers for pipelining enable signal
  val mulEnReg = RegInit(0.U(6.W)) // 5 pipeline stages + 1 input stage
  mulEnReg := Cat(mulEnReg(4, 0), io.mul_en_in)

  // Registers for the multiplicand and multiplier
  val mulAReg = RegEnable(io.mul_a, 0.U, io.mul_en_in)
  val mulBReg = RegEnable(io.mul_b, 0.U, io.mul_en_in)

  // Register for partial sums and final product
  val partialSums = RegInit(VecInit(Seq.fill(4)(0.U(16.W))))

  // ---- Pipelined Partial Products Generation -----
  // Generate partial products
  val tempProducts = Wire(Vec(4, UInt(16.W)))
  tempProducts(0) := Cat(0.U(8.W), mulAReg & Fill(8, mulBReg(0))) // LSB of multiplier
  tempProducts(1) := Cat(0.U(7.W), (mulAReg & Fill(8, mulBReg(1))) << 1)
  tempProducts(2) := Cat(0.U(6.W), (mulAReg & Fill(8, mulBReg(2))) << 2)
  tempProducts(3) := Cat(0.U(5.W), (mulAReg & Fill(8, mulBReg(3))) << 3)

  // Pipeline: Forward partial sums
  for (i <- partialSums.indices) {
    partialSums(i) := tempProducts(i) + (if (i > 0) 

InputLogic --- Of Indvice }}
警告：dut8.scala格式异常
