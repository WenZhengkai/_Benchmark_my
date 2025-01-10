import chisel3._
import chisel3.util._

class dut(bitwidth: Int) extends Module {
  val io = IO(new Bundle {
    val in     = Input(UInt(bitwidth.W))  // Input data (binary or Gray code)
    val encode = Input(Bool())           // Mode selection: true for encoding, false for decoding
    val out    = Output(UInt(bitwidth.W)) // Output data (Gray code or binary)
  })

  // Internal logic for Gray code encoding
  def binaryToGray(binary: UInt): UInt = {
    binary ^ (binary >> 1.U)
  }

  // Internal logic for Gray code decoding
  // Decoding involves iterative XOR of the Gray code shifted by increasing powers of 2
  def grayToBinary(gray: UInt): UInt = {
    val binary = Wire(UInt(bitwidth.W))
    binary := gray // Initialize with the gray input

    // Iteratively compute the binary value
    for (i <- 1 until bitwidth) {
      binary := binary ^ (gray >> i.U)
    }

    binary
  }

  // Mode selection: Encoding or Decoding based on `encode` input
  io.out := Mux(io.encode,
    binaryToGray(io.in),  // Perform Binary to Gray code encoding
    grayToBinary(io.in)   // Perform Gray code to Binary decoding
  )
}

