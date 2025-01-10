import chisel3._
import chisel3.util._

class dut(val length: Int, val bitwidth: Int, val window: (Int, Int) => Seq[Int]) extends Module {
  require(length > 0, "Filter length must be greater than 0")
  require(bitwidth > 0, "Bitwidth must be greater than 0")

  val io = IO(new Bundle {
    val in = Input(UInt(bitwidth.W))
    val out = Output(UInt((bitwidth * 2 + length - 1).W))
  })

  // Coefficient calculation
  val coefficients = window(length, bitwidth).map(_.U(bitwidth.W))

  // Delay line creation
  val delayLine = RegInit(VecInit(Seq.fill(length)(0.U(bitwidth.W))))

  // Shift in the new sample and shift out the oldest sample
  delayLine := delayLine.tail :+ io.in

  // Multiplication stage
  val mults = for (i <- 0 until length) yield delayLine(i) * coefficients(i)

  // Summation stage
  val sum = mults.reduce(_ +& _)

  // Output connection
  io.out := sum
}

