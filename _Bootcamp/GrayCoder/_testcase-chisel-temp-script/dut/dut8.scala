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

  // Binary -> Gray
  val encoded = io.in ^ (io.in >> 1)

  // Gray -> Binary (iterative prefix XOR using shifts of powers of two)
  val stages = log2Ceil(bitwidth)
  val decodeVec = Wire(Vec(stages + 1, UInt(bitwidth.W)))
  decodeVec(0) := io.in
  for (i <- 0 until stages) {
    decodeVec(i + 1) := decodeVec(i) ^ (decodeVec(i) >> (1 << i))
  }
  val decoded = decodeVec(stages)

  io.out := Mux(io.encode, encoded, decoded)
}
