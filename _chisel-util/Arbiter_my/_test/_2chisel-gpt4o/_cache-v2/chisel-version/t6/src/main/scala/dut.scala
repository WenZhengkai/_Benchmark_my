import chisel3._
import chisel3.util._

// The Arbiter_my module
class dut[T <: Data](gen: T, n: Int) extends Module {
  require(n > 0, "There must be at least one producer input.")

  val io = IO(new Bundle {
    val in = Flipped(Vec(n, Decoupled(gen)))
    val out = Decoupled(gen)
    val chosen = Output(UInt(log2Ceil(n).W))
  })

  // ArbiterCtrl_my object to create grant sequence
  private object ArbiterCtrl_my {
    def apply(request: Seq[Bool]): Seq[Bool] = request.length match {
      case 0 => Seq()
      case 1 => Seq(true.B)
      case _ => true.B +: request.tail.init.scanLeft(request.head)(_ || _).map(!_)

    }
  }

  // Generate the `grant` signals based on request signals
  val request = io.in.map(_.valid)
  val grant = ArbiterCtrl_my(request)

  // Find the chosen producer and set the out bits
  io.chosen := PriorityMux(request.zipWithIndex.map { case (req, idx) => req -> idx.U })
  io.out.bits := Mux1H(grant, io.in.map(_.bits))

  // Output validity and producer readiness
  io.out.valid := request.reduce(_ || _)
  io.in.zip(grant).foreach { case (in, g) =>
    in.ready := g && io.out.ready
  }
}
