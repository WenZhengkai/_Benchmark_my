import chisel3._
import chisel3.util._
import scala.math._

class dut(val bitwidth: Int) extends Module {
  val io = IO(new Bundle {
    val in = Input(UInt(bitwidth.W))
    val encode = Input(Bool())
    val out = Output(UInt(bitwidth.W))
  })

  // Encoding: Binary to Gray
  val encoded = io.in ^ (io.in >> 1.U)

  // Decoding: Gray to Binary
  val decoded = Wire(UInt(bitwidth.W))
  decoded := io.in
  for (shift <- 1 until log2Ceil(bitwidth) + 1) {
    decoded := decoded ^ (decoded >> shift.U)
  }

  // Select between encoding and decoding based on the mode
  io.out := Mux(io.encode, encoded, decoded)
}

