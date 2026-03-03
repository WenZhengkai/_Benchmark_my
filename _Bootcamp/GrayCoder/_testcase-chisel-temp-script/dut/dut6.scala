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

  // Binary -> Gray
  val gray = io.in ^ (io.in >> 1)

  // Gray -> Binary (iterative XOR with shifts by powers of two)
  val nStages = log2Ceil(bitwidth)
  val decodeStages = Wire(Vec(nStages + 1, UInt(bitwidth.W)))
  decodeStages(0) := io.in
  for (i <- 1 to nStages) {
    val shift = 1 << (i - 1)
    decodeStages(i) := decodeStages(i - 1) ^ (decodeStages(i - 1) >> shift)
  }
  val bin = decodeStages(nStages)

  io.out := Mux(io.encode, gray, bin)
}
