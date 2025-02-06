import chisel3._
import chisel3.util._

class dut[T <: Data](gen: T, n: Int) extends Module {
  require(n > 0, "Number of producers must be greater than zero")

  val io = IO(new Bundle {
    val in = Flipped(Vec(n, Decoupled(gen)))
    val out = Decoupled(gen)
    val chosen = Output(UInt(log2Ceil(n).W))
  })

  // Initialize default values
  io.out.bits := io.in(n-1).bits
  io.out.valid := false.B
  io.chosen := (n-1).U

  // ArbiterCtrl_my object, calculates grant signals
  object ArbiterCtrl_my {
    def apply(requests: Seq[Bool]): Seq[Bool] = requests.length match {
      case 0 => Seq()
      case 1 => Seq(true.B)
      case _ => true.B +: requests.tail.init.scanLeft(requests.head)(_ || _).map(!_)
    }
  }

  // Calculate the grant signals
  val grants = ArbiterCtrl_my(io.in.map(_.valid))

  // Assign ready signals and choose the first valid input
  for (i <- 0 until n) {
    io.in(i).ready := grants(i) && io.out.ready
    when(io.in(i).valid && grants(i)) {
      io.out.bits := io.in(i).bits
      io.out.valid := true.B
      io.chosen := i.U
    }
  }
}
