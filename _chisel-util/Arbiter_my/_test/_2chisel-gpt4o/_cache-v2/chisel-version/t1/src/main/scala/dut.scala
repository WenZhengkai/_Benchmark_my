import chisel3._
import chisel3.util._

// Define the internal Arbiter Control
private object ArbiterCtrl_my {
  def apply(request: Seq[Bool]): Seq[Bool] = request.length match {
    case 0 => Seq()
    case 1 => Seq(true.B)
    case _ => true.B +: request.tail.init.scanLeft(request.head)(_ || _).map(!_)
  }
}

// Define the Arbiter_my module
class dut[T <: Data](gen: T, n: Int) extends Module {
  val io = IO(new Bundle {
    val in = Flipped(Vec(n, Decoupled(gen)))
    val out = Decoupled(gen)
    val chosen = Output(UInt(log2Ceil(n).W))
  })

  // Generate the request signals
  val request = io.in.map(_.valid)

  // Generate the grant signals using ArbiterCtrl_my
  val grant = ArbiterCtrl_my(request)

  // Determine the chosen input index and its validity
  val chosenVec = request.zipWithIndex.map { case (req, i) => req && grant(i) }
  io.chosen := PriorityEncoder(chosenVec)
  
  // Output is valid if any input is valid and granted
  io.out.valid := request.zip(grant).exists { case (req, g) => req && g }

  // Route the appropriate input to the output
  io.out.bits := Mux1H(io.chosen, io.in.map(_.bits))

  // Set the ready signals for inputs
  io.in.zip(grant).foreach { case (in, g) =>
    in.ready := io.out.ready && g
  }
}
