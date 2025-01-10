import chisel3._
import chisel3.util._

class dut[T <: Data](gen: T, n: Int) extends Module {
  require(n > 0, "Number of producers (n) must be greater than 0.")

  val io = IO(new Bundle {
    val in = Flipped(Vec(n, Decoupled(gen))) // Array of producer inputs
    val out = Decoupled(gen)                // Consumer output
    val chosen = Output(UInt(log2Ceil(n).W)) // Indicates the chosen producer
  })

  // Priority-based valid signals
  val request = io.in.map(_.valid) // Extract valid signals from producers
  val grants = ArbiterCtrl_my(request) // Generate grant signals

  // Select the valid producer based on priority
  io.chosen := PriorityEncoder(request)

  // Connect the chosen producer's bits to the output's bits
  io.out.bits := Mux1H(grants, io.in.map(_.bits))

  // Connect output valid to indicate when at least one producer is valid
  io.out.valid := request.zip(grants).map { case (r, g) => r && g }.reduce(_ || _)

  // Generate the ready signals for the producers
  (io.in zip grants).foreach { case (in, grant) =>
    in.ready := grant && io.out.ready // A producer is ready if it has a grant and the consumer is ready
  }
}

private object ArbiterCtrl_my {
  def apply(request: Seq[Bool]): Seq[Bool] = request.length match {
    case 0 => Seq()                   // No producers, no grants
    case 1 => Seq(true.B)             // Single producer, always granted
    case _ => true.B +: request.tail.init.scanLeft(request.head)(_ || _).map(!_)
  }
}




