import chisel3._
import chisel3.util._

class dut[T <: Data](gen: T, n: Int) extends Module {
  val io = IO(new Bundle {
    val in = Flipped(Vec(n, Decoupled(gen)))
    val out = Decoupled(gen)
    val chosen = Output(UInt(log2Ceil(n).W))
  })

  // Generate the grant signals for producers
  val request = io.in.map(_.valid)
  val grant = ArbiterCtrl_my(request)

  // Determine the chosen producer index
  io.chosen := PriorityEncoder(request)

  // Connect outputs
  io.out.valid := io.in(io.chosen).valid && grant(io.chosen)
  io.out.bits := io.in(io.chosen).bits

  // Assign ready signals to inputs
  for (i <- 0 until n) {
    io.in(i).ready := grant(i) && io.out.ready
  }
}

object ArbiterCtrl_my {
  def apply(request: Seq[Bool]): Seq[Bool] = request.length match {
    case 0 => Seq()
    case 1 => Seq(true.B)
    case _ => true.B +: request.tail.init.scanLeft(request.head)(_ || _).map(!_)
  }
}
