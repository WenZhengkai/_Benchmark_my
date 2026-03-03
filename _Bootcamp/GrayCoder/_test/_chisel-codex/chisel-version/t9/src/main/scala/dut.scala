import chisel3._
import chisel3.util._
import scala.math.pow

class dut(val bitwidth: Int) extends Module {
  require(bitwidth > 0, "bitwidth must be > 0")

  val io = IO(new Bundle {
    val in     = Input(UInt(bitwidth.W))
    val encode = Input(Bool())
    val out    = Output(UInt(bitwidth.W))
  })

  // Encode: binary -> Gray
  val grayEncoded = io.in ^ (io.in >> 1)

  // Decode: Gray -> binary using iterative XOR with right shifts by powers of 2
  val stages = log2Ceil(bitwidth)
  val decodeSteps = Wire(Vec(stages + 1, UInt(bitwidth.W)))
  decodeSteps(0) := io.in
  for (i <- 0 until stages) {
    val shiftAmt = pow(2, i).toInt
    decodeSteps(i + 1) := decodeSteps(i) ^ (decodeSteps(i) >> shiftAmt)
  }
  val grayDecoded = decodeSteps(stages)

  io.out := Mux(io.encode, grayEncoded, grayDecoded)
}
