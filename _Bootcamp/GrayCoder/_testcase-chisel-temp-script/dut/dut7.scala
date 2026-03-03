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

  // Gray -> Binary decode pipeline:
  // x0 = gray
  // x(i+1) = x(i) ^ (x(i) >> 2^i), for i in [0, log2Ceil(bitwidth)-1]
  val stages = log2Ceil(bitwidth)
  val decVec = Wire(Vec(stages + 1, UInt(bitwidth.W)))
  decVec(0) := io.in

  for (i <- 0 until stages) {
    val shiftAmt = pow(2, i).toInt
    decVec(i + 1) := decVec(i) ^ (decVec(i) >> shiftAmt)
  }

  val grayEncoded = io.in ^ (io.in >> 1)
  val grayDecoded = decVec(stages)

  io.out := Mux(io.encode, grayEncoded, grayDecoded)
}
