import chisel3._
import chisel3.util._

class dut(val bitwidth: Int) extends Module {
  require(bitwidth > 0, "bitwidth must be > 0")

  val io = IO(new Bundle {
    val in     = Input(UInt(bitwidth.W))
    val encode = Input(Bool())
    val out    = Output(UInt(bitwidth.W))
  })

  // Encode: bin -> gray
  val grayEnc = io.in ^ (io.in >> 1.U)

  // Decode: gray -> bin using iterative XOR with shifted versions (power-of-two shifts)
  val stages = log2Ceil(bitwidth) + 1
  val decVec = Wire(Vec(stages, UInt(bitwidth.W)))
  decVec(0) := io.in
  for (i <- 1 until stages) {
    val sh = (1 << (i - 1))
    decVec(i) := decVec(i - 1) ^ (decVec(i - 1) >> sh.U)
  }
  val binDec = decVec(stages - 1)

  io.out := Mux(io.encode, grayEnc, binDec)
}
