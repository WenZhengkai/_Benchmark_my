import chisel3._
import chisel3.util._

class dut[T <: Data](gen: T, n: Int) extends Module {
  val io = IO(new Bundle {
    val in = Flipped(Vec(n, Decoupled(gen)))
    val out = Decoupled(gen)
    val chosen = Output(UInt(log2Ceil(n).W))
  })

  // Generate the grant signals using the ArbiterCtrl_my logic
  val grant = ArbiterCtrl_my(io.in.map(_.valid))

  // Connect inputs to the outputs based on grant signals
  io.out.valid := Mux1H(grant, io.in.map(_.valid))
  io.chosen := Mux1H(grant.zipWithIndex.map { case (g, i) => (g, i.U) })

  // Route the selected valid input bits to the output
  io.out.bits := Mux1H(grant, io.in.map(_.bits))

  // Set ready signal for each input based on grant and output readiness
  io.in.zip(grant).foreach { case (in, g) =>
    in.ready := g && io.out.ready
  }
}

private object ArbiterCtrl_my {
  def apply(request: Seq[Bool]): Seq[Bool] = request.length match {
    case 0 => Seq()
    case 1 => Seq(true.B)
    case _ => true.B +: request.tail.init.scanLeft(request.head)(_ || _).map(!_)
  }
}
