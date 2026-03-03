import chisel3._
import chisel3.util._

class dut(val bitwidth: Int) extends Module {
  require(bitwidth > 0, "bitwidth must be > 0")

  val io = IO(new Bundle {
    val in     = Input(UInt(bitwidth.W))
    val encode = Input(Bool())
    val out    = Output(UInt(bitwidth.W))
  })

  // Gray encode: bin ^ (bin >> 1)
  val grayEnc = io.in ^ (io.in >> 1)

  // Gray decode: iterative XOR with shifts by powers of two
  val stages = log2Ceil(bitwidth + 1) // ensures enough stages for any bitwidth
  val decVec = Wire(Vec(stages, UInt(bitwidth.W)))

  decVec(0) := io.in
  for (i <- 1 until stages) {
    val sh = 1 << (i - 1) // 1, 2, 4, 8, ...
    decVec(i) := decVec(i - 1) ^ (decVec(i - 1) >> sh)
  }
  val grayDec = decVec(stages - 1)

  io.out := Mux(io.encode, grayEnc, grayDec)
}
