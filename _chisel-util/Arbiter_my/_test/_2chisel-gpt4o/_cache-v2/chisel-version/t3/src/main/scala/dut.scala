import chisel3._
import chisel3.util._

class dut[T <: Data](gen: T, n: Int) extends Module {
  val io = IO(new Bundle {
    val in = Flipped(Vec(n, Decoupled(gen)))
    val out = Decoupled(gen)
    val chosen = Output(UInt(log2Ceil(n).W))
  })

  // Default outputs
  io.out.bits := DontCare
  io.out.valid := false.B
  io.chosen := (n-1).U

  // Internal grant signals based on the priority logic
  val grant = Wire(Vec(n, Bool()))
  grant := ArbiterCtrl_my(io.in.map(_.valid))

  for (i <- 0 until n) {
    when(grant(i)) {
      io.chosen := i.U
      io.out.bits := io.in(i).bits
    }
    io.in(i).ready := io.out.ready && grant(i)
  }

  io.out.valid := grant.zip(io.in.map(_.valid)).map { case (g, v) => g && v }.reduce(_ || _)
}

private object ArbiterCtrl_my {
  def apply(request: Seq[Bool]): Seq[Bool] = request.length match {
    case 0 => Seq()
    case 1 => Seq(true.B)
    case _ => true.B +: request.tail.init.scanLeft(request.head)(_ || _).map(!_)
  }
}

