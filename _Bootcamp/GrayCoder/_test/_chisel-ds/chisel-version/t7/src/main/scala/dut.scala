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
    var binary = gray
    for (i <- 0 until log2Ceil(bitwidth)) {
      binary = binary ^ (binary >> (1 << i).U)
    }
    binary
  }

  // Output logic
  io.out := Mux(io.encode, encoded, decodeGray(io.in))
}

/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(bitwidth = 8), Array("--target-dir", "generated"))
}
*/
