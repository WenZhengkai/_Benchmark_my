import chisel3._
import chisel3.util._

class dut(val bitwidth: Int) extends Module {
  require(bitwidth > 0, "bitwidth must be greater than 0")
  
  val io = IO(new Bundle {
    val in = Input(UInt(bitwidth.W))
    val encode = Input(Bool())
    val out = Output(UInt(bitwidth.W))
  })

  // Encoding: Binary to Gray
  def binaryToGray(binary: UInt): UInt = {
    binary ^ (binary >> 1.U)
  }

  // Decoding: Gray to Binary
  def grayToBinary(gray: UInt): UInt = {
    val result = Wire(UInt(bitwidth.W))
    val temp = Wire(Vec(bitwidth, Bool()))
    // Initialize the first bit of result
    temp(bitwidth-1) := gray(bitwidth-1)
    // Implement iterative XOR based decoding
    for (i <- bitwidth-2 to 0 by -1) {
      temp(i) := temp(i+1) ^ gray(i)
    }
    // Convert temp Vec[Bool] to a single UInt
    result := temp.asUInt
    result
  }

  // Connect the output based on the operation mode
  io.out := Mux(io.encode, binaryToGray(io.in), grayToBinary(io.in))
}

