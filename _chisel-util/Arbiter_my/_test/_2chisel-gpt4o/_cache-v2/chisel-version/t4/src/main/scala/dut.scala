import chisel3._
import chisel3.util._

class dut[T <: Data](gen: T, n: Int) extends Module {
  val io = IO(new Bundle {
    val in = Flipped(Vec(n, Decoupled(gen)))
    val out = Decoupled(gen)
    val chosen = Output(UInt(log2Ceil(n).W))
  })

  // Default values
  io.out.valid := false.B
  io.out.bits  := 0.U.asTypeOf(gen)
  io.chosen    := (n-1).asUInt

  // Generate grant signals
  val request = io.in.map(_.valid)
  val grant = ArbiterCtrlMy(request)

  // Priority logic and connecting signals
  for (i <- 0 until n) {
    io.in(i).ready := grant(i) && io.out.ready
    when(grant(i) && io.in(i).valid) {
      io.out.valid := true.B
      io.out.bits := io.in(i).bits
      io.chosen := i.U
    }
  }
}

// Object to generate grant signals with priority
private object ArbiterCtrlMy {
  def apply(request: Seq[Bool]): Seq[Bool] = request.length match {
    case 0 => Seq()
    case 1 => Seq(true.B)
    case _ => true.B +: request.tail.init.scanLeft(request.head)(_ || _).map(!_).map(_.asBool)
  }
}

// Sample usage (this part is outside the ArbiterMy module)
// val arbiter = Module(new ArbiterMy(UInt(8.W), 4))
// io connect your arbiter instance to your design appropriately
