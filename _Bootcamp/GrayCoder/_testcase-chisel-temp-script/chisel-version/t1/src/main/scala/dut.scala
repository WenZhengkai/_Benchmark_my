import chisel3._
import chisel3.util._

class dut(val bitwidth: Int) extends Module {
  val io = IO(new Bundle {
    val in = Input(UInt(bitwidth.W))
    val encode = Input(Bool())
    val out = Output(UInt(bitwidth.W))
  })

  when(io.encode) {
    // Encoding binary to Gray
    io.out := io.in ^ (io.in >> 1.U)
  } .otherwise {
    // Decoding Gray to binary
    val result = Wire(Vec(bitwidth, UInt(1.W)))
    result(0) := io.in(bitwidth-1)

    for (i <- 1 until bitwidth) {
      result(i) := result(i-1) ^ io.in(bitwidth-1-i)
    }

    io.out := result.asUInt
  }
}

