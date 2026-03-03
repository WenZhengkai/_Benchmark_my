import chisel3._
import chisel3.util._

class dut(val bitwidth: Int) extends Module {
  require(bitwidth > 0, "bitwidth must be > 0")

  val io = IO(new Bundle {
    val in     = Input(UInt(bitwidth.W))
    val encode = Input(Bool())
    val out    = Output(UInt(bitwidth.W))
  })

  // Gray encode: g = b ^ (b >> 1)
  val encoded = io.in ^ (io.in >> 1)

  // Gray decode via iterative XOR-folding:
  // b = g ^ (g >> 1) ^ (g >> 2) ^ (g >> 4) ...
  val stages = log2Ceil(bitwidth + 1) // ensures enough stages for any bitwidth
  val decVec = Wire(Vec(stages + 1, UInt(bitwidth.W)))
  decVec(0) := io.in
  for (i <- 0 until stages) {
    val shiftAmt = 1 << i
    decVec(i + 1) := decVec(i) ^ (decVec(i) >> shiftAmt)
  }
  val decoded = decVec(stages)

  io.out := Mux(io.encode, encoded, decoded)
}
