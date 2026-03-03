import chisel3._
import chisel3.util._

class dut(val bitwidth: Int) extends Module {
  require(bitwidth > 0, "bitwidth must be > 0")

  val io = IO(new Bundle {
    val in     = Input(UInt(bitwidth.W))
    val encode = Input(Bool())
    val out    = Output(UInt(bitwidth.W))
  })

  // Encoding: binary -> Gray
  val grayEncoded = io.in ^ (io.in >> 1)

  // Decoding: Gray -> binary using iterative XOR with shifted versions
  val stages = log2Ceil(bitwidth)
  val decodeVec = Wire(Vec(stages + 1, UInt(bitwidth.W)))
  decodeVec(0) := io.in
  for (i <- 0 until stages) {
    decodeVec(i + 1) := decodeVec(i) ^ (decodeVec(i) >> (1 << i))
  }
  val grayDecoded = decodeVec(stages)

  io.out := Mux(io.encode, grayEncoded, grayDecoded)
}
