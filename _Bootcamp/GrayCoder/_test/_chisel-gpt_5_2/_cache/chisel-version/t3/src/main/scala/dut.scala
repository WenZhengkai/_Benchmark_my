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

  // Gray decode: iterative XOR with right shifts by powers of two
  // x0 = gray
  // x_{i+1} = x_i ^ (x_i >> (2^i))
  val stages = log2Ceil(bitwidth max 1)
  val decVec = Wire(Vec(stages + 1, UInt(bitwidth.W)))
  decVec(0) := io.in
  for (i <- 0 until stages) {
    val shamt = 1 << i
    decVec(i + 1) := decVec(i) ^ (decVec(i) >> shamt.U)
  }
  val grayDec = decVec(stages)

  io.out := Mux(io.encode, grayEnc, grayDec)
}
