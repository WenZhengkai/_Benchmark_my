import chisel3._
import chisel3.util._
import scala.math.pow

class dut(bitwidth: Int) extends Module {
  val io = IO(new Bundle {
    val in = Input(UInt(bitwidth.W))
    val encode = Input(Bool())
    val out = Output(UInt(bitwidth.W))
  })

  // Encoding logic
  val encoded = io.in ^ (io.in >> 1.U)

  // Decoding logic
  val decoded = Wire(UInt(bitwidth.W))
  decoded := io.in
  for (i <- 0 until log2Ceil(bitwidth)) {
    decoded := decoded ^ (decoded >> (1 << i).U)
  }

  // Output selection based on encode signal
  io.out := Mux(io.encode, encoded, decoded)
}

// Companion object to allow easy instantiation
object dut {
  def apply(bitwidth: Int): dut = new dut(bitwidth)
}
