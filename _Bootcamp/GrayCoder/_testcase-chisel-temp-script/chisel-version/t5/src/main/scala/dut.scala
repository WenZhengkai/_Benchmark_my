import chisel3._
import chisel3.util._

class dut(val bitwidth: Int) extends Module {
  require(bitwidth > 0, "bitwidth must be a positive integer")

  // Input/Output declarations
  val io = IO(new Bundle {
    val in     = Input(UInt(bitwidth.W))
    val encode = Input(Bool())
    val out    = Output(UInt(bitwidth.W))
  })

  // Internal Logic
  when(io.encode) {
    // Encoding Mode: Binary to Gray Code
    io.out := io.in ^ (io.in >> 1.U)
  } .otherwise {
    // Decoding Mode: Gray Code to Binary
    // Iteratively compute the binary equivalent using XOR and right shifts
    val binary = Wire(Vec(bitwidth, UInt(1.W)))
    binary(0) := io.in(bitwidth - 1) // Most significant bit is the same for Gray and Binary

    // Iteratively compute remaining bits
    for (i <- 1 until bitwidth) {
      binary(i) := binary(i - 1) ^ io.in(bitwidth - 1 - i)
    }

    // Concatenate the result into a single UInt output
    io.out := binary.asUInt
  }
}
