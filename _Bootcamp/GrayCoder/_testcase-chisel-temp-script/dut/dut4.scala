import chisel3._
import chisel3.util._

class dut(bitwidth: Int) extends Module {
  val io = IO(new Bundle {
    val in = Input(UInt(bitwidth.W))
    val encode = Input(Bool())
    val out = Output(UInt(bitwidth.W))
  })

  // Encoding mode: Convert binary to Gray code
  def encodeGray(binary: UInt): UInt = {
    binary ^ (binary >> 1.U)
  }

  // Decoding mode: Convert Gray code to binary
  def decodeGray(gray: UInt): UInt = {
    val binary = Wire(Vec(bitwidth, Bool()))
    binary(bitwidth - 1) := gray(bitwidth - 1)

    for (i <- bitwidth - 2 to 0 by -1) {
      binary(i) := binary(i + 1) ^ gray(i)
    }
    binary.asUInt()
  }

  // Choose operation based on the encode signal
  io.out := Mux(io.encode, encodeGray(io.in), decodeGray(io.in))
}

