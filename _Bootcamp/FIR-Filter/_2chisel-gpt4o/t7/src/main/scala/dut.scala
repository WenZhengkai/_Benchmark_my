
import chisel3._
import chisel3.util._

class dut(length: Int, bitwidth: Int, windowFn: (Int, Int) => Seq[Int]) extends Module {
  val io = IO(new Bundle {
    val in = Input(UInt(bitwidth.W))
    val out = Output(UInt((bitwidth * 2 + length - 1).W))
  })

  // Generate filter coefficients using the provided window function
  val coefficients = windowFn(length, bitwidth).map(_.U)

  // Create a delay line to store the past input samples
  val delayLine = RegInit(VecInit(Seq.fill(length)(0.U(bitwidth.W))))

  // Shift in the new input into the delay line
  for (i <- length - 1 to 1 by -1) {
    delayLine(i) := delayLine(i - 1)
  }
  delayLine(0) := io.in

  // Multiply each delayed sample by its corresponding coefficient
  val mults = VecInit((0 until length).map(i => delayLine(i) * coefficients(i)))

  // Sum all the multiplied results
  val sum = mults.reduce(_ +& _) // Using +& to handle potential overflow

  // Connect the computed sum to the output
  io.out := sum
}

// Chisel's default main function to generate Verilog
object MyFirDriver extends App {
  chisel3.Driver.execute(args, () => new MyFir(4, 16, (len, bw) => (0 until len).map(_ => 1)))
}
