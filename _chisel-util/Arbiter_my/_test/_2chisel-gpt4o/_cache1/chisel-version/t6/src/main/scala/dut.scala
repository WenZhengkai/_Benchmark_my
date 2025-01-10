import chisel3._
import chisel3.util._

class dut[T <: Data](gen: T, n: Int) extends Module {
  require(n >= 0, "Number of producers must be >= 0")

  val io = IO(new Bundle {
    val in = Flipped(Vec(n, Decoupled(gen)))
    val out = Decoupled(gen)
    val chosen = Output(UInt(log2Ceil(n).W))
  })

  // Priority resolution: find the lowest valid index
  val chosen = WireDefault(n.U) // Default to an invalid "none chosen" value
  io.out.valid := false.B

  for (i <- 0 until n) {
    when(io.in(i).valid && (chosen === n.U)) {
      chosen := i.U
    }
  }

  // Grant generation using the ArbiterCtrl_my logic
  val grants = ArbiterCtrl_my(io.in.map(_.valid))

  // Connect producers to the output based on chosen grant
  io.out.bits := io.in(chosen).bits
  io.out.valid := Mux(chosen === n.U, false.B, io.in(chosen).valid)

  // Set ready signals for producers
  for (i <- 0 until n) {
    io.in(i).ready := grants(i) && io.out.ready
  }

  io.chosen := chosen


}

private object ArbiterCtrl_my {
  def apply(request: Seq[Bool]): Seq[Bool] = request.length match {
    case 0 => Seq()
    case 1 => Seq(true.B)
    case _ => true.B +: request.tail.init.scanLeft(request.head)(_ || _).map(!_)

  }
}
