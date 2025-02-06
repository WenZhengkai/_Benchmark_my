import chisel3._
import chisel3.util._

class dut[T <: Data](gen: T, n: Int) extends Module {
  val io = IO(new Bundle {
    val in = Flipped(Vec(n, DecoupledIO(gen)))
    val out = DecoupledIO(gen)
    val chosen = Output(UInt(log2Ceil(n).W))
  })

  // Default: no valid input
  io.out.valid := false.B
  io.out.bits := 0.U.asTypeOf(gen)
  io.chosen := (n-1).U

  // Loop over inputs from highest priority to lowest
  for (i <- (n - 1) to 0 by -1) {
    when(io.in(i).valid) {
      io.out.valid := true.B
      io.out.bits := io.in(i).bits
      io.chosen := i.U
    }
  }

  // Generate grant signals for each input
  val grant = ArbiterCtrl_my(io.in.map(_.valid))

  // Set ready signals: only the chosen input is ready
  io.in.zip(grant).foreach { case (input, grantSignal) =>
    input.ready := grantSignal && io.out.ready
  }

  // ArbiterCtrl_my object for generating grant signals
  private object ArbiterCtrl_my {
    def apply(request: Seq[Bool]): Seq[Bool] = request.length match {
      case 0 => Seq()
      case 1 => Seq(true.B)
      case _ => 
        val partial = request.tail.init.scanLeft(request.head)(_ || _).map(!_ )
        true.B +: partial
    }
  }
}
