
import chisel3._
import chisel3.util._

class dut(length: Int, bitwidth: Int, window: (Int, Int) => Seq[Int]) extends Module {
  val io = IO(new Bundle {
    val in = Input(UInt(bitwidth.W))
    val out = Output(UInt((bitwidth * 2 + length - 1).W))
  })

  // Generate filter coefficients using the provided window function
  val coefficients = window(length, bitwidth).map(_.U)

  // Implement the delay line
  val delayLine = RegInit(VecInit(Seq.fill(length)(0.U(bitwidth.W))))

  // Shift the input through the delay line
  for (i <- length - 1 to 1 by -1) {
    delayLine(i) := delayLine(i - 1)
  }
  delayLine(0) := io.in

  // Perform multiplication of delayed inputs and filter coefficients
  val mults = Wire(Vec(length, UInt((bitwidth * 2).W)))
  for (i <- 0 until length) {
    mults(i) := delayLine(i) * coefficients(i)
  }

  // Sum up all multiplier outputs
  val sum = mults.reduce(_ +& _)

  // Connect the final sum to the output, accounting for any necessary bit growth
  io.out := sum
}

