import chisel3._
import chisel3.util._

class dut(val bitwidth: Int) extends Module {
  require(bitwidth > 0, "bitwidth must be > 0")

  val io = IO(new Bundle {
    val in     = Input(UInt(bitwidth.W))
    val encode = Input(Bool())
    val out    = Output(UInt(bitwidth.W))
  })

  // Gray encode: gray = bin ^ (bin >> 1)
  val grayEnc = io.in ^ (io.in >> 1)

  // Gray decode using iterative XOR with shifting by powers of two:
  // x0 = gray
  // x(i+1) = x(i) ^ (x(i) >> 2^i), for i = 0 .. log2Ceil(bitwidth)-1
  val stages = log2Ceil(bitwidth) + 1
  val dec = Wire(Vec(stages, UInt(bitwidth.W)))
  dec(0) := io.in
  for (i <- 0 until log2Ceil(bitwidth)) {
    val sh = (1 << i)
    dec(i + 1) := dec(i) ^ (dec(i) >> sh)
  }
  val grayDec = dec(stages - 1)

  io.out := Mux(io.encode, grayEnc, grayDec)
}
