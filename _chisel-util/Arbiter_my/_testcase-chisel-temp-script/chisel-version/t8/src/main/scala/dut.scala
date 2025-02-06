import chisel3._
import chisel3.util._

class dut[T <: Data](gen: T, n: Int) extends Module {
  val io = IO(new Bundle {
    val in = Flipped(Vec(n, Decoupled(gen)))
    val out = Decoupled(gen)
    val chosen = Output(UInt(log2Ceil(n).W))
  })

  // Create a vector to hold boolean request signals for each input
  val request = VecInit(io.in.map(_.valid))

  // This is where the ArbiterCtrl_my logic is integrated
  val grant = ArbiterCtrlMy(request)

  // Default output logic
  io.out.valid := false.B
  io.out.bits := DontCare
  io.chosen := (n-1).U

  // Iterate over all inputs to find the highest priority valid input
  for (i <- 0 until n) {
    when(grant(i)) {
      io.out.valid := io.in(i).valid
      io.out.bits := io.in(i).bits
      io.chosen := i.U
    }
    // Each input's ready signal is driven by the grant signal and output readiness
    io.in(i).ready := grant(i) && io.out.ready
  }
}

object ArbiterCtrlMy {
  def apply(request: Seq[Bool]): Seq[Bool] = request.length match {
    case 0 => Seq()
    case 1 => Seq(true.B)
    case _ => true.B +: request.tail.init.scanLeft(request.head)(_ || _).map(!_ _)
  }
}
