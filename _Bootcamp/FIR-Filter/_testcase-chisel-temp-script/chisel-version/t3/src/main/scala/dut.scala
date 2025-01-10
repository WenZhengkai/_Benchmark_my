import chisel3._
import chisel3.util._

class dut(length: Int, bitwidth: Int, window: (Int, Int) => Seq[Int]) extends Module {
  val io = IO(new Bundle {
    val in = Input(UInt(bitwidth.W))
    val out = Output(UInt((bitwidth * 2 + length - 1).W))
  })

  // Generate the coefficients using the window function
  val coefficients = window(length, bitwidth).map(_.U(bitwidth.W))

  // Create a Vec of delay registers to hold past input samples
  val delayLine = RegInit(VecInit(Seq.fill(length)(0.U(bitwidth.W))))

  // Shift the delay line and insert the new input sample
  delayLine := delayLine.tail :+ io.in

  // Multiply each delayed sample by its corresponding coefficient
  val mults = for (i <- 0 until length) yield {
    delayLine(i) * coefficients(i)
  }

  // Sum the results of the multiplications
  val sum = mults.reduce(_ +& _)

  // Connect the summed result to the output
  io.out := sum
}
