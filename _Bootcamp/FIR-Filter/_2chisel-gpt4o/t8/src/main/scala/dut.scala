
import chisel3._
import chisel3.util._

class dut(length: Int, bitwidth: Int, window: (Int, Int) => Seq[Int]) extends Module {
  val io = IO(new Bundle {
    val in = Input(UInt(bitwidth.W))
    val out = Output(UInt((bitwidth * 2 + length - 1).W))
  })

  // Coefficient Calculation
  val coeffs = window(length, bitwidth).map(c => c.U(bitwidth.W))

  // Delay Line Creation
  val delayLine = RegInit(VecInit(Seq.fill(length)(0.U(bitwidth.W))))

  // Shift the delay line and insert the new input at the head
  delayLine(0) := io.in
  for (i <- 1 until length) {
    delayLine(i) := delayLine(i - 1)
  }

  // Multiplication
  val mults = VecInit(Seq.tabulate(length)(i => delayLine(i) * coeffs(i)))

  // Summation
  val sum = mults.reduce(_ +& _)

  // Output Connection
  io.out := sum
}

