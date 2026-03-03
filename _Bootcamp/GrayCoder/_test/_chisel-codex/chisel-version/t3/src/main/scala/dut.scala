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

  // Encoding: binary -> Gray
  val grayEncoded = io.in ^ (io.in >> 1)

  // Decoding: Gray -> binary (iterative XOR with shifted versions)
  val stages = log2Ceil(bitwidth)
  val decodeChain = Wire(Vec(stages + 1, UInt(bitwidth.W)))
  decodeChain(0) := io.in

  for (i <- 0 until stages) {
    val shiftAmt = (1 << i)
    decodeChain(i + 1) := decodeChain(i) ^ (decodeChain(i) >> shiftAmt)
  }

  val grayDecoded = decodeChain(stages)

  io.out := Mux(io.encode, grayEncoded, grayDecoded)
}
