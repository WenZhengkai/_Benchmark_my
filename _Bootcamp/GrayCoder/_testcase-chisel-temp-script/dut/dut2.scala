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

  // Encoding: binary -> Gray
  val gray = io.in ^ (io.in >> 1)

  // Decoding: Gray -> binary (iterative XOR with shifted versions)
  var decoded = io.in
  for (i <- 0 until log2Ceil(bitwidth)) {
    decoded = decoded ^ (decoded >> (1 << i))
  }

  io.out := Mux(io.encode, gray, decoded)
}
