import chisel3._
import chisel3.util._

class dut[T <: Data](gen: T, n: Int) extends Module {
  val io = IO(new Bundle {
    val in = Flipped(Vec(n, Decoupled(gen)))
    val out = Decoupled(gen)
    val chosen = Output(UInt(log2Ceil(n).W))
  })

  // Arbiter Control Logic to generate grant signals
  private object ArbiterCtrl_my {
    def apply(request: Seq[Bool]): Seq[Bool] = request.length match {
      case 0 => Seq()
      case 1 => Seq(true.B)
      case _ => true.B +: request.tail.init.scanLeft(request.head)(_ || _).map(!_)
    }
  }

  val request = io.in.map(_.valid)
  val grant = ArbiterCtrl_my(request)

  val ready = grant.map(_ && io.out.ready)
  io.in.zip(ready).foreach { case (in, r) =>
    in.ready := r
  }

  io.out.valid := request.last || !grant.last
  io.out.bits := Mux1H(grant, io.in.map(_.bits))
  io.chosen := PriorityMux(grant.zipWithIndex.map { case (g, idx) => g -> idx.U })

}

