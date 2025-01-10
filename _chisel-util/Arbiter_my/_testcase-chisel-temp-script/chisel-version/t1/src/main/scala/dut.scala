import chisel3._
import chisel3.util._

class dut[T <: Data](gen: T, n: Int) extends Module {
  require(n > 0, "Number of producers (n) must be greater than 0")

  val io = IO(new Bundle {
    val in = Flipped(Vec(n, Decoupled(gen)))
    val out = Decoupled(gen)
    val chosen = Output(UInt(log2Ceil(n).W))
  })

  // Priority resolution logic
  val request = Wire(Vec(n, Bool()))
  for (i <- 0 until n) {
    request(i) := io.in(i).valid
  }

  val grant = ArbiterCtrl_my(request)
  
  // Connect ready signals for producers
  for (i <- 0 until n) {
    io.in(i).ready := grant(i) && io.out.ready
  }

  // Select the chosen input based on the grant signals
  val selectedIndex = PriorityEncoder(grant)
  io.chosen := selectedIndex

  // Connect the outputs
  io.out.bits := Mux1H(grant, io.in.map(_.bits))
  io.out.valid := Mux1H(grant, io.in.map(_.valid))
}

// Private object for Arbiter Control Logic
private object ArbiterCtrl_my {
  def apply(request: Seq[Bool]): Seq[Bool] = request.length match {
    case 0 => Seq()
    case 1 => Seq(true.B)
    case _ => 
      true.B +: request.tail.scanLeft(request.head)(_ || _).map(!_)
  }
}
