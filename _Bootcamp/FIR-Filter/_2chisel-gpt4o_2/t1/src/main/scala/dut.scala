import chisel3._
import chisel3.util._

class dut(length: Int, bitwidth: Int, window: (Int, Int) => Seq[Int]) extends Module {
  val io = IO(new Bundle {
    val in = Input(UInt(bitwidth.W))
    val out = Output(UInt((bitwidth * 2 + length - 1).W))
  })

  // Generate filter coefficients using the window function
  val coefficients = window(length, bitwidth).map(c => c.U(bitwidth.W))

  // Create a delay line (sequence of registers)
  val delayLine = RegInit(VecInit(Seq.fill(length)(0.U(bitwidth.W))))

  // Shift in the new sample
  delayLine(0) := io.in
  for (i <- 1 until length) {
    delayLine(i) := delayLine(i - 1)
  }

  // Compute the multiplication of delay line values with filter coefficients
  val mults = for (i <- 0 until length) yield {
    delayLine(i) * coefficients(i)
  }

  // Sum all the multiplied values
  val sum = mults.reduce(_ +& _)

  // Connect the computed sum to the output
  io.out := sum
}
