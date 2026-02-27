import chisel3._
import chisel3.util._
import scala.math.pow

class dut(bitwidth: Int) extends Module {
  val io = IO(new Bundle {
    val in = Input(UInt(bitwidth.W))
    val encode = Input(Bool())
    val out = Output(UInt(bitwidth.W))
  })

  // Encoding: Binary to Gray Code
  val grayEncoded = io.in ^ (io.in >> 1.U)

  // Decoding: Gray Code to Binary
  def grayDecode(gray: UInt): UInt = {
    val n = log2Ceil(bitwidth)
    var binary = gray
    for (i <- 0 until n) {
      binary = binary ^ (binary >> (1 << i).U)
    }
    binary
  }

  // Output logic
  io.out := Mux(io.encode, grayEncoded, grayDecode(io.in))
}

// Optional: Companion object for instantiation
object dut {
  def apply(bitwidth: Int): dut = new dut(bitwidth)
}
