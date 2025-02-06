import chisel3._
import chisel3.util._

class dut[T <: Data](gen: T, n: Int) extends Module {
  val io = IO(new Bundle {
    val in = Flipped(Vec(n, DecoupledIO(gen)))
    val out = DecoupledIO(gen)
    val chosen = Output(UInt(log2Ceil(n).W))
  })

  private object ArbiterCtrl_my {
    def apply(request: Seq[Bool]): Seq[Bool] = request.length match {
      case 0 => Seq()
      case 1 => Seq(true.B)
      case _ => true.B +: request.tail.init.scanLeft(request.head)(_ || _).map(!_(_))
    }
  }

  val validVec = io.in.map(_.valid)
  val grantVec = ArbiterCtrl_my(validVec)

  io.chosen := (n-1).U  // Default to the highest index
  for (i <- n - 1 to 0 by -1) {
    when(io.in(i).valid) {
      io.chosen := i.U
    }
  }

  io.out.bits := io.in(io.chosen).bits
  io.out.valid := grantVec.last || validVec(n - 1)
  for (i <- 0 until n) {
    io.in(i).ready := grantVec(i) && io.out.ready
  }
}

