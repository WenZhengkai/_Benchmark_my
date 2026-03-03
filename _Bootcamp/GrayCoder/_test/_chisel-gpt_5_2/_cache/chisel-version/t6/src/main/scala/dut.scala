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

  // Gray encode: gray = bin ^ (bin >> 1)
  val enc = io.in ^ (io.in >> 1)

  // Gray decode: iterative XOR with right shifts by powers of two
  // bin = gray ^ (gray >> 1) ^ (gray >> 2) ^ (gray >> 4) ^ ...
  val stages = log2Ceil(bitwidth) + 1
  val decodeVec = Wire(Vec(stages, UInt(bitwidth.W)))
  decodeVec(0) := io.in

  for (i <- 1 until stages) {
    val sh = (1 << (i - 1))
    decodeVec(i) := decodeVec(i - 1) ^ (decodeVec(i - 1) >> sh.U)
  }

  val dec = decodeVec(stages - 1)

  io.out := Mux(io.encode, enc, dec)
}
