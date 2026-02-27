import chisel3._
import chisel3.util._
import scala.math.pow

class dut(bitwidth: Int) extends Module {
  val io = IO(new Bundle {
    val in = Input(UInt(bitwidth.W))
    val encode = Input(Bool())
    val out = Output(UInt(bitwidth.W))
  })

  // Encoding: Binary to Gray code
  val encoded = io.in ^ (io.in >> 1.U)

  // Decoding: Gray code to Binary
  def decodeGray(gray: UInt): UInt = {
    val log2Bitwidth = log2Ceil(bitwidth)
    var result = gray
    for (i <- 0 until log2Bitwidth) {
      result = result ^ (result >> (1 << i).U)
    }
    result
  }

  // Output selection based on encode signal
  io.out := Mux(io.encode, encoded, decodeGray(io.in))
}

// Optional: Companion object for testing
/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(bitwidth = 8), Array("--target-dir", "generated"))
}
*/
