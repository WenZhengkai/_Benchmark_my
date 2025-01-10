import chisel3._
import chisel3.util._

class dut[T <: Data](gen: T, n: Int) extends Module {
  require(n >= 0, "The number of producers must be non-negative.")

  val io = IO(new Bundle {
    val in = Flipped(Vec(n, Decoupled(gen)))
    val out = Decoupled(gen)
    val chosen = Output(UInt(log2Ceil(n max 1).W))
  })

  // Priority resolution: Find the first valid producer
  val valid = io.in.map(_.valid)
  val grants = ArbiterCtrl_my(valid)

  // Select the chosen producer based on priority
  io.chosen := PriorityMux(valid, (0 until n).map(_.U))

  // Connect the output with the chosen producer
  io.out.bits := PriorityMux(grants, io.in.map(_.bits))

  // Output is valid if any of the valid signals of inputs is true
  io.out.valid := valid.reduce(_ || _)

  // Drive each producer's ready signal based on the grant and output ready
  for (i <- 0 until n) {
    io.in(i).ready := grants(i) && io.out.ready
  }

  // Internal Arbiter Control to generate grant signals
  private object ArbiterCtrl_my {
    def apply(request: Seq[Bool]): Seq[Bool] = {
      request.length match {
        case 0 => Seq()
        case 1 => Seq(true.B)
        case _ =>
          true.B +: request.tail.scanLeft(request.head)(_ || _).map(!_)
      }
    }
  }
}

