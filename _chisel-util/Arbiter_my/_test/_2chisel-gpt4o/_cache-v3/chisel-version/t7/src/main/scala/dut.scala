import chisel3._
import chisel3.util._

class dut[T <: Data](gen: T, n: Int) extends Module {
  val io = IO(new Bundle {
    val in     = Flipped(Vec(n, Decoupled(gen)))
    val out    = Decoupled(gen)
    val chosen = Output(UInt(log2Ceil(n).W))
  })

  // Initialize chosen index as the default highest priority
  io.chosen := (n-1).U
  io.out.bits := io.in(n-1).bits

  // Calculate the grant sequence
  val request = io.in.map(_.valid)
  val grant   = ArbiterCtrl_my(request)

  // Assign chosen index correctly based on the priority
  for (i <- n-1 to 0 by -1) {
    when(grant(i)) {
      io.chosen := i.U
      io.out.bits := io.in(i).bits
    }
  }

  // Set valid and ready signals
  io.out.valid := grant.reduce(_ || _)
  io.in.zip(grant).foreach { case (in, g) =>
    in.ready := g && io.out.ready
  }
}

// ArbiterCtrl_my implementation
private object ArbiterCtrl_my {
  def apply(request: Seq[Bool]): Seq[Bool] = request.length match {
    case 0 => Seq()
    case 1 => Seq(true.B)
    case _ => true.B +: request.tail.init.scanLeft(request.head)(_ || _).map(!_)
  }
}

// A test harness or main function can be added to instantiate and test the module as required.
