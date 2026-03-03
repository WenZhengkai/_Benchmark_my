import chisel3._
import chisel3.util._
import scala.math.pow

class dut(val bitwidth: Int) extends Module {
  require(bitwidth > 0, "bitwidth must be greater than 0")

  val io = IO(new Bundle {
    val in     = Input(UInt(bitwidth.W))
    val encode = Input(Bool())
    val out    = Output(UInt(bitwidth.W))
  })

  // Binary -> Gray: g = b ^ (b >> 1)
  val grayEncoded = io.in ^ (io.in >> 1)

  // Gray -> Binary using iterative XOR with right shifts by powers of 2
  var grayDecoded = io.in
  for (i <- 0 until log2Ceil(bitwidth)) {
    val shiftAmt = pow(2, i).toInt
    grayDecoded = grayDecoded ^ (grayDecoded >> shiftAmt)
  }

  io.out := Mux(io.encode, grayEncoded, grayDecoded)
}
