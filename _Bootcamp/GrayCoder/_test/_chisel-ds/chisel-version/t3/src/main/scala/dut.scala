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
  val decoded = Wire(Vec(bitwidth, UInt(bitwidth.W)))
  decoded(0) := io.in
  for (i <- 1 until bitwidth) {
    val shift = pow(2, i).toInt
    decoded(i) := decoded(i - 1) ^ (decoded(i - 1) >> shift.U)
  }

  // Output selection based on encode signal
  io.out := Mux(io.encode, encoded, decoded(bitwidth - 1))
}

// Optional: Top-level module for testing
/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(bitwidth = 8), Array("--target-dir", "generated"))
}
*/
