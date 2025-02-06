import chisel3._
import chisel3.util._

class dut[T <: Data](gen: T, n: Int) extends Module {
  val io = IO(new Bundle {
    val in = Flipped(Vec(n, Decoupled(gen)))
    val out = Decoupled(gen)
    val chosen = Output(UInt(log2Ceil(n).W))
  })

  // Priority handling and grant sequence generation
  val request = io.in.map(_.valid)
  val grant = ArbiterCtrl_my(request)

  // Internal signal to determine which producer is chosen
  val chosen = WireDefault(n.U(log2Ceil(n).W)) // default to an invalid value

  // Iterate through inputs and assign priority
  for (i <- n-1 to 0 by -1) {
    when(grant(i)) {
      chosen := i.U
      io.out.bits := io.in(i).bits
    }
  }
  
  // Assign outputs
  io.chosen := chosen
  io.out.valid := request(chosen) && io.out.ready
  for (i <- 0 until n) {
    io.in(i).ready := grant(i) && io.out.ready
  }
}

// Internal object for controlling grant signals
private object ArbiterCtrl_my {
  def apply(request: Seq[Bool]): Seq[Bool] = request.length match {
    case 0 => Seq()
    case 1 => Seq(true.B)
    case _ => 
      val grants = true.B +: request.tail.init.scanLeft(request.head)(_ || _).map(!_)
      grants
  }
}
