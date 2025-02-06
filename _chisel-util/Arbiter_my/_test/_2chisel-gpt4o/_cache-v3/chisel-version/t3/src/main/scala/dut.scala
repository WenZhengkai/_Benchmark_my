import chisel3._
import chisel3.util._

class dut[T <: Data](gen: T, n: Int) extends Module {
  require(n > 0, "Number of producer inputs must be greater than zero")
  
  val io = IO(new Bundle {
    val in = Flipped(Vec(n, Decoupled(gen)))
    val out = Decoupled(gen)
    val chosen = Output(UInt(log2Ceil(n).W))
  })

  // Priority logic and grant signals
  val request = io.in.map(_.valid)
  val grant = ArbiterCtrl_my(request)

  // Setting chosen index and output data
  io.chosen := (n-1).U
  io.out.bits := io.in(n-1).bits
  for (i <- (n-2) to 0 by -1) {
    when(request(i)) {
      io.chosen := i.U
      io.out.bits := io.in(i).bits
    }
  }

  // Output readiness and validity logic
  io.out.valid := io.in.zip(grant).map { case (in, g) => in.valid && g }.reduce(_ || _)
  io.in.zip(grant).foreach { case (in, g) => in.ready := io.out.ready && g }
}

private object ArbiterCtrl_my {
  def apply(request: Seq[Bool]): Seq[Bool] = request.length match {
    case 0 => Seq()
    case 1 => Seq(true.B)
    case _ => true.B +: request.tail.init.scanLeft(request.head)(_ || _).map(!_)
  }
}

// Testbench for Arbiter_my would be implemented separately if needed.
