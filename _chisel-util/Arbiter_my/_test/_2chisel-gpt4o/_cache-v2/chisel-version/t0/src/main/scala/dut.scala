import chisel3._
import chisel3.util._

class dut[T <: Data](gen: T, n: Int) extends Module {
  val io = IO(new Bundle {
    val in = Input(Vec(n, Flipped(Decoupled(gen))))
    val out = Output(Decoupled(gen))
    val chosen = Output(UInt(log2Ceil(n).W))
  })

  // Compute the grant signals using the ArbiterCtrl_my object
  val requests = io.in.map(_.valid)
  val grants = ArbiterCtrlMy(requests)

  // Connect the chosen producer to the output
  io.out.valid := requests.zip(grants).map { case (req, grant) => req && grant }.reduce(_ || _)
  io.out.bits := Mux1H(grants.zip(io.in.map(_.bits)))

  // Set the chosen index to the producer with the active grant signal
  io.chosen := PriorityEncoder(grants)

  // Set the readiness of each producer input
  io.in.zip(grants).foreach {
    case (in, grant) => in.ready := grant && io.out.ready
  }
}

// The ArbiterCtrl_my object calculating grant signals
private object ArbiterCtrlMy {
  def apply(request: Seq[Bool]): Seq[Bool] = request.length match {
    case 0 => Seq.empty
    case 1 => Seq(true.B)
    case _ => true.B +: request.tail.init.scanLeft(request.head)(_ || _).map(!_)
  }
}

