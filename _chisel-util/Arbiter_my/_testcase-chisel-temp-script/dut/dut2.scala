import chisel3._
import chisel3.util._

class dut[T <: Data](gen: T, n: Int) extends Module {
  require(n > 0, "Number of producers must be greater than 0.")
  
  val io = IO(new Bundle {
    val in = Flipped(Vec(n, Decoupled(gen)))
    val out = Decoupled(gen)
    val chosen = Output(UInt(log2Ceil(n).W))
  })

  // Priority resolution logic
  val request = io.in.map(_.valid)  // Extract valid signals from all producers
  val grant = ArbiterCtrl_my(request) // Generate grant signals based on priority
  io.chosen := PriorityEncoder(request) // Select the lowest-index valid producer

  // Connect ready signals
  (io.in zip grant).foreach { case (in, g) => in.ready := g && io.out.ready }

  // Connect output
  io.out.valid := request.zip(grant).map { case (req, g) => req && g }.reduce(_ || _)
  io.out.bits := Mux1H(grant, io.in.map(_.bits))
}

// Arbiter Control Logic (Generates grant signals)
private object ArbiterCtrl_my {
  def apply(request: Seq[Bool]): Seq[Bool] = request.length match {
    case 0 => Seq()
    case 1 => Seq(true.B)
    case _ => true.B +: request.tail.init.scanLeft(request.head)(_ || _).map(!_)
  }
}


