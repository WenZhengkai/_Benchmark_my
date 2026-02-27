import chisel3._
import chisel3.util._
import scala.math.pow

class dut(bitwidth: Int) extends Module {
  val io = IO(new Bundle {
    val in = Input(UInt(bitwidth.W))
    val encode = Input(Bool())
    val out = Output(UInt(bitwidth.W))
  })

  // Encoding logic: Binary to Gray code
  val encoded = io.in ^ (io.in >> 1.U)

  // Decoding logic: Gray code to Binary
  val decoded = Wire(UInt(bitwidth.W))
  decoded := io.in
  for (i <- 1 until bitwidth) {
    decoded := decoded ^ (io.in >> i.U)
  }

  // Mux to select between encoding and decoding based on the 'encode' signal
  io.out := Mux(io.encode, encoded, decoded)
}

/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(bitwidth = 8), args)
}
*/
