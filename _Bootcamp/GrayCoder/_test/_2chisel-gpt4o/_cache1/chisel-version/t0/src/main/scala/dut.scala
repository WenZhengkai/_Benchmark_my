import chisel3._
import chisel3.util._

/** GrayCoder Module
  *
  * This module performs encoding and decoding between binary and Gray code representations.
  *
  * @param bitwidth The width of the input and output data in bits.
  */
class dut(val bitwidth: Int) extends Module {
  val io = IO(new Bundle {
    val in     = Input(UInt(bitwidth.W))  // Input data (binary or Gray code)
    val encode = Input(Bool())           // 'true' for encoding, 'false' for decoding
    val out    = Output(UInt(bitwidth.W)) // Output data (Gray code or binary)
  })

  // Create a Wire to hold the decoded binary result
  val decoded = Wire(UInt(bitwidth.W))
  decoded := 0.U

  // Decoding logic: Iteratively compute binary equivalent of Gray code
  when (!io.encode) { // Decoding mode: io.encode == false
    var intermediate = io.in
    decoded := intermediate
    for (i <- 1 until bitwidth) {
      intermediate = intermediate ^ (io.in >> i.U)
      decoded := intermediate
    }
  }

  // GrayCoder module operation
  io.out := Mux(io.encode, io.in ^ (io.in >> 1.U), decoded)
}


