import chisel3._
import chisel3.util._
import scala.math.pow

class dut(val bitwidth: Int) extends Module {
  require(bitwidth > 0, "bitwidth must be greater than 0")

  val io = IO(new Bundle {
    val in     = Input(UInt(bitwidth.W))
    val encode = Input(Bool())
    val out    = Output(UInt(bitwidth.W))
  })

  // Binary -> Gray
  val grayEncoded = io.in ^ (io.in >> 1)

  // Gray -> Binary (iterative prefix XOR using power-of-two shifts)
  val stages = Wire(Vec(log2Ceil(bitwidth) + 1, UInt(bitwidth.W)))
  stages(0) := io.in
  for (i <- 0 until log2Ceil(bitwidth)) {
    val shiftAmt = (1 << i)
    stages(i + 1) := stages(i) ^ (stages(i) >> shiftAmt)
  }
  val grayDecoded = stages(log2Ceil(bitwidth))

  io.out := Mux(io.encode, grayEncoded, grayDecoded)
}

/*
object dut extends App {
  emitVerilog(new dut(bitwidth = 8), Array("--target-dir", "generated"))
}
*/
