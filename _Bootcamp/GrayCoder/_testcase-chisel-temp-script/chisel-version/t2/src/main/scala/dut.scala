import chisel3._
import chisel3.util._

class dut(val bitwidth: Int) extends Module {
  require(bitwidth > 0, "bitwidth must be greater than 0")
  
  val io = IO(new Bundle {
    val in     = Input(UInt(bitwidth.W))  // Input binary or Gray code number
    val encode = Input(Bool())           // Operation mode: true -> encode, false -> decode
    val out    = Output(UInt(bitwidth.W)) // Output Gray code or binary number
  })

  // Wire for the output
  val result = Wire(UInt(bitwidth.W))

  when(io.encode) {
    // Encoding binary to Gray code
    result := io.in ^ (io.in >> 1.U) // Each bit is XORed with the bit right-shifted by 1
  }.otherwise {
    // Decoding Gray code to Binary
    val binaryDecoded = Wire(Vec(bitwidth, Bool())) // Intermediate Vec to hold the binary bits

    // Gray code decoding process:
    binaryDecoded(bitwidth - 1) := io.in(bitwidth - 1) // MSB remains the same
    for (i <- (0 until bitwidth - 1).reverse) {
      binaryDecoded(i) := binaryDecoded(i + 1) ^ io.in(i) // XOR previous decoded bit
    }

    // Convert Vec[Bool] to UInt for output
    result := binaryDecoded.asUInt
  }

  // Connect the result to the output
  io.out := result
}

