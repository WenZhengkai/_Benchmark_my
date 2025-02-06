import chisel3._
import chisel3.util._

class dut[T <: Data](gen: T, n: Int) extends Module {
  val io = IO(new Bundle {
    val in = Flipped(Vec(n, Decoupled(gen)))
    val out = Decoupled(gen)
    val chosen = Output(UInt(log2Ceil(n).W))
  })

  // Default values
  io.out.bits := io.in(n-1).bits
  io.out.valid := io.in(n-1).valid
  io.chosen := (n-1).U

  // Priority logic: Lower index has higher priority
  for (i <- (n-2) to 0 by -1) {
    when(io.in(i).valid) {
      io.out.bits := io.in(i).bits
      io.out.valid := true.B
      io.chosen := i.U
    }
  }

  // Arbiter Control: grant control logic
  val grant = ArbiterCtrl_my(io.in.map(_.valid))

  // Setting the ready signals
  for (i <- 0 until n) {
    io.in(i).ready := grant(i) && io.out.ready
  }
}

private object ArbiterCtrl_my {
  def apply(request: Seq[Bool]): Seq[Bool] = request.length match {
    case 0 => Seq()
    case 1 => Seq(true.B)
    case _ => true.B +: request.tail.init.scanLeft(request.head)(_ || _).map(!_)
  }
}
