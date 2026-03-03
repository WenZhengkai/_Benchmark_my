import chisel3._
import chisel3.util._

class dut(val bitwidth: Int) extends Module {
  require(bitwidth > 0, "bitwidth must be > 0")

  val io = IO(new Bundle {
    val in     = Input(UInt(bitwidth.W))
    val encode = Input(Bool())
    val out    = Output(UInt(bitwidth.W))
  })

  // Gray encode: g = b ^ (b >> 1)
  val grayEnc = io.in ^ (io.in >> 1).asUInt

  // Gray decode: iterative XOR with right shifts by powers of two
  // b = g ^ (g >> 1) ^ (g >> 2) ^ (g >> 4) ^ ...
  val stages = log2Ceil(bitwidth max 1) + 1
  val decodeVec = Wire(Vec(stages, UInt(bitwidth.W)))

  decodeVec(0) := io.in
  for (i <- 1 until stages) {
    val shiftAmt = 1 << (i - 1)
    decodeVec(i) := decodeVec(i - 1) ^ (decodeVec(i - 1) >> shiftAmt).asUInt
  }
  val grayDec = decodeVec(stages - 1)

  io.out := Mux(io.encode, grayEnc, grayDec)
}
