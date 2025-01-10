import chisel3._
import chisel3.util._

class dut(val bitwidth: Int) extends Module {
  val io = IO(new Bundle {
    val in = Input(UInt(bitwidth.W))
    val encode = Input(Bool())
    val out = Output(UInt(bitwidth.W))
  })

  when(io.encode) {
    // Encoding mode: Binary to Gray code
    io.out := io.in ^ (io.in >> 1.U)
  } .otherwise {
    // Decoding mode: Gray code to Binary
    val gray = io.in
    var binary = Wire(UInt(bitwidth.W))
    binary := gray

    // Iteratively decode the Gray code to binary
    for (i <- 1 until bitwidth) {
      binary = binary ^ (gray >> i.U)
    }

    io.out := binary
  }
}


