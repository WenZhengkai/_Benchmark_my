import chisel3._
import chisel3.util._

class dut[T <: Data](gen: T, n: Int) extends Module {
  val io = IO(new Bundle {
    val in = Flipped(Vec(n, Decoupled(gen)))
    val out = Decoupled(gen)
    val chosen = Output(UInt(log2Ceil(n).W))
  })

  // Grant signals computed by ArbiterCtrl_my
  private object ArbiterCtrl_my {
    def apply(request: Seq[Bool]): Seq[Bool] = request.length match {
      case 0 => Seq()
      case 1 => Seq(true.B)
      case _ => true.B +: request.tail.init.scanLeft(request.head)(_ || _).map(!_(_))
    }
  }

  val request = io.in.map(_.valid)
  val grant = ArbiterCtrl_my(request)

  // Handling io.chosen and output data
  io.chosen := PriorityEncoder(request)

  io.out.bits := Mux1H(grant, io.in.map(_.bits))
  io.out.valid := request.reduce(_ || _)

  // Input readiness logic
  for (i <- 0 until n) {
    io.in(i).ready := grant(i) && io.out.ready
  }
}

