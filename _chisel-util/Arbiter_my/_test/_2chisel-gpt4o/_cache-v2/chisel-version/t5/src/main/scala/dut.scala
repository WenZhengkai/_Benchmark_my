import chisel3._
import chisel3.util._

class dut[T <: Data](gen: T, n: Int) extends Module {
  val io = IO(new Bundle {
    val in = Input(Vec(n, Flipped(Decoupled(gen))))
    val out = Decoupled(gen)
    val chosen = Output(UInt(log2Ceil(n).W))
  })

  // Priority handling logic
  val requests = io.in.map(_.valid)
  val grants = ArbiterCtrlMy(requests)
  
  // Connect the chosen output and grant signals
  io.chosen := PriorityEncoder(requests)
  io.out.valid := requests(io.chosen)
  io.out.bits := Mux1H(grants, io.in.map(_.bits))
  
  // Manage ready signals for inputs
  for ((in, grant) <- io.in.zip(grants)) {
    in.ready := grant && io.out.ready
  }
}

private object ArbiterCtrlMy {
  def apply(request: Seq[Bool]): Seq[Bool] = {
    request.length match {
      case 0 => Seq()
      case 1 => Seq(true.B)
      case _ =>
        true.B +: request.tail.init.scanLeft(request.head)(_ || _).map(!_)
    }
  }
}

