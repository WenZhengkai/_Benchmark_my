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
  val grayEncoded = io.in ^ (io.in >> 1.U)

  // Decoding logic: Gray code to Binary
  def grayDecode(gray: UInt): UInt = {
    val log2Bitwidth = log2Ceil(bitwidth)
    var decoded = gray
    for (i <- 0 until log2Bitwidth) {
      decoded = decoded ^ (decoded >> (1 << i).U)
    }
    decoded
  }

  // Output selection based on encode signal
  io.out := Mux(io.encode, grayEncoded, grayDecode(io.in))
}

/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(bitwidth = 8), Array("--target-dir", "generated"))
}
*/
