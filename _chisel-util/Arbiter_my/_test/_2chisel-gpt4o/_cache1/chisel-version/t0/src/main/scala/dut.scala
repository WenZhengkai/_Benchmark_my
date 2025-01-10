import chisel3._
import chisel3.util._

class dut[T <: Data](gen: T, n: Int) extends Module {
  val io = IO(new Bundle {
    val in = Flipped(Vec(n, Decoupled(gen)))
    val out = Decoupled(gen)
    val chosen = Output(UInt(log2Ceil(n).W))
  })

  // Priority resolution: find the first valid input
  val request = io.in.map(_.valid)
  val grant = ArbiterCtrl_my(request)

  // Connect the chosen producer's data to the output
  io.out.bits := Mux1H(grant.zip(io.in.map(_.bits)))

  // Output valid if we have a valid grant and output is ready
  io.out.valid := VecInit(grant).asUInt.orR && VecInit(request).asUInt.orR

  // Provide feedback to inputs about when they are selected
  for (i <- 0 until n) {
    io.in(i).ready := grant(i) && io.out.ready
  }

  // Determine which producer is chosen
  io.chosen := PriorityEncoder(grant)

}

private object ArbiterCtrl_my {
  def apply(request: Seq[Bool]): Seq[Bool] = request.length match {
    case 0 => Seq()
    case 1 => Seq(true.B)
    case _ => true.B +: request.tail.init.scanLeft(request.head)(_ || _).map(!_).toSeq
  }
}

// Example usage:
// val arbiter = Module(new Arbiter_my(UInt(8.W), 3))
