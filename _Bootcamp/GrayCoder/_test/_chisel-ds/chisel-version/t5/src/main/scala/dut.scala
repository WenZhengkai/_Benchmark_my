import chisel3._
import chisel3.util._
import scala.math.pow

class dut(bitwidth: Int) extends Module {
  val io = IO(new Bundle {
    val in = Input(UInt(bitwidth.W))
    val encode = Input(Bool())
    val out = Output(UInt(bitwidth.W))
  })

  // Encoding logic: Binary to Gray code
  val encoded = io.in ^ (io.in >> 1.U)

  // Decoding logic: Gray code to Binary
  def decodeGrayCode(gray: UInt): UInt = {
    val width = gray.getWidth
    var binary = gray
    for (i <- 1 until width) {
      binary = binary ^ (gray >> i.U)
    }
    binary
  }

  // Output selection based on encode signal
  io.out := Mux(io.encode, encoded, decodeGrayCode(io.in))
}

// Companion object for testing and instantiation
object dut {
  def apply(bitwidth: Int): dut = new dut(bitwidth)
}
