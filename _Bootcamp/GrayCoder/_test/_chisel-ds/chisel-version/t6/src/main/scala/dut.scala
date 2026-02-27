import chisel3._
import chisel3.util._
import scala.math.pow

class dut(bitwidth: Int) extends Module {
  val io = IO(new Bundle {
    val in     = Input(UInt(bitwidth.W))
    val encode = Input(Bool())
    val out    = Output(UInt(bitwidth.W))
  })

  // Encoding Mode
  val encoded = io.in ^ (io.in >> 1.U)

  // Decoding Mode
  val decodeSteps = log2Ceil(bitwidth)
  val decoded = Wire(UInt(bitwidth.W))
  val intermediate = RegInit(0.U(bitwidth.W))

  when(io.encode === false.B) {
    intermediate := io.in
    for (i <- 0 until decodeSteps) {
      intermediate := intermediate ^ (intermediate >> (1 << i).U)
    }
    decoded := intermediate
  }

  // Output selection
  io.out := Mux(io.encode, encoded, decoded)
}

// Companion object to generate Verilog
/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(bitwidth = 8), Array("--target-dir", "generated"))
}
*/
