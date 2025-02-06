import chisel3._
import chisel3.util._

class dut[T <: Data](gen: T, n: Int) extends Module {
  val io = IO(new Bundle {
    val in = Flipped(Vec(n, Decoupled(gen)))
    val out = Decoupled(gen)
    val chosen = Output(UInt(log2Ceil(n).W))
  })

  // Initialize the priority signals and default values
  val grant = ArbiterCtrl_my(io.in.map(_.valid))
  io.out.valid := io.in.zip(grant).map { case (in, g) => in.valid && g }.reduce(_ || _)
  io.out.bits := Mux1H(io.in.zipWithIndex.map { case (in, i) => grant(i) -> in.bits })

  // Control logic for `chosen` output
  io.chosen := PriorityEncoder(io.in.map(_.valid))
  
  // Assign ready signals based on output readiness and grant
  for ((in, g) <- io.in.zip(grant)) {
    in.ready := io.out.ready && g
  }
}

object ArbiterCtrl_my {
  def apply(request: Seq[Bool]): Seq[Bool] = request.length match {
    case 0 => Seq()
    case 1 => Seq(true.B)
    case _ => true.B +: request.tail.init.scanLeft(request.head)(_ || _).map(!_):+request.init.last
  }
}


