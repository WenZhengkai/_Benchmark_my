import chisel3._
import chisel3.util._

class dut[T <: Data](gen: T, n: Int) extends Module {
  require(n > 0)
  val io = IO(new Bundle {
    val in = Flipped(Vec(n, Decoupled(gen)))
    val out = Decoupled(gen)
    val chosen = Output(UInt(log2Ceil(n).W))
  })

  // Priority logic for arbiter control
  private object ArbiterCtrl_my {
    def apply(request: Seq[Bool]): Seq[Bool] = request.length match {
      case 0 => Seq()
      case 1 => Seq(true.B)
      case _ => true.B +: request.tail.init.scanLeft(request.head)(_ || _).map(!_)

    }
  }

  // Priority assignment and signal routing
  val request = io.in.map(_.valid)
  val grant = ArbiterCtrl_my(request)
  io.chosen := n.U - 1.U

  // Iterate through inputs and assign the chosen producer and output bits
  for (i <- n - 1 to 0 by -1) {
    when(io.in(i).valid) {
      io.chosen := i.U
    }
  }

  // Assign outputs
  val chosenValid = grant.reverse.zip(io.in.reverse).collectFirst {
    case (g, in) if g => in.bits
  }
  io.out.bits := chosenValid.getOrElse(io.in.head.bits)
  io.out.valid := request.orR

  // Set the ready signal of each producer input
  for (i <- 0 until n) {
    io.in(i).ready := io.out.ready && (io.chosen === i.U)
  }
}

