import chisel3._
import chisel3.util._

class dut(val length: Int, val bitwidth: Int, val window: (Int, Int) => Seq[Int]) extends Module {
  // Define the input and output IO
  val io = IO(new Bundle {
    val in  = Input(UInt(bitwidth.W))
    val out = Output(UInt((bitwidth * 2 + length - 1).W))
  })

  // Generate coefficients using the provided window function
  val coefficients = window(length, bitwidth).map(_.U(bitwidth.W))

  // Create a delay line of 'length' registers and shift the input through them
  val delayLine = RegInit(VecInit(Seq.fill(length)(0.U(bitwidth.W))))
  for (i <- (length - 1) until 0 by -1) {
    delayLine(i) := delayLine(i - 1)
  }
  delayLine(0) := io.in

  // Compute the products of each coefficient and the corresponding delayed sample
  val mults = for (i <- 0 until length) yield {
    delayLine(i) * coefficients(i)
  }

  // Sum the multiplication results to get the filtered output
  val sum = mults.reduce(_ +& _)

  // Connect the summed output to io.out
  io.out := sum
}


