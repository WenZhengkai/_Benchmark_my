import chisel3._
import chisel3.util._
import scala.math.pow

class dut(val bitwidth: Int) extends Module {
  val io = IO(new Bundle {
    val in     = Input(UInt(bitwidth.W))
    val encode = Input(Bool())
    val out    = Output(UInt(bitwidth.W))
  })

  // Encode: binary -> Gray
  val grayEnc = io.in ^ (io.in >> 1.U)

  // Decode: Gray -> binary using iterative XOR with shifted versions
  val stages = log2Ceil(bitwidth max 1) + 1
  val decVec = Wire(Vec(stages, UInt(bitwidth.W)))
  decVec(0) := io.in

  for (i <- 1 until stages) {
    val shiftAmt = (1 << (i - 1)).U
    decVec(i) := decVec(i - 1) ^ (decVec(i - 1) >> shiftAmt)
  }
  val grayDec = decVec(stages - 1)

  io.out := Mux(io.encode, grayEnc, grayDec)
}
