

import chisel3._
import chisel3.util._

class dut[T <: Data](gen: T, n: Int) extends Module {
  require(n > 0, "The Arbiter must have at least one producer")

  val io = IO(new Bundle {
    val in = Flipped(Vec(n, Decoupled(gen))) // Array of n producer inputs
    val out = Decoupled(gen)                // Consumer output
    val chosen = Output(UInt(log2Ceil(n).W)) // Output the index of the chosen input
  })

  // Default values for outputs
  io.out.bits := DontCare
  io.out.valid := false.B
  io.chosen := 0.U

  // Priority logic to evaluate valid producers
  val request = io.in.map(_.valid) // Extract validity of all inputs

  // Control logic to generate grants
  val grants = ArbiterCtrl_my(request)

  // Connect the chosen input to the output based on priority
  val chosenVec = Wire(Vec(n, Bool()))
  (0 until n).foreach { i =>
    io.in(i).ready := grants(i) && io.out.ready // Grant-ready protocol
    chosenVec(i) := grants(i)
    when(grants(i)) {
      io.out.bits := io.in(i).bits
      io.out.valid := io.in(i).valid
      io.chosen := i.U
    }
  }

  // If no input is valid, output valid remains false
  when(!request.reduce(_ || _)) {
    io.out.valid := false.B
  }
}

private object ArbiterCtrl_my {
  // Priority-based grant generation logic
  def apply(request: Seq[Bool]): Seq[Bool] = request.length match {
    case 0 => Seq() // No inputs
    case 1 => Seq(true.B) // Only one input, always grant
    case _ =>
      // Generate the grant signals using priority encoding
      // The first true valid input has priority, subsequent ones are masked
      true.B +: request.tail.init.scanLeft(request.head)(_ || _).map(!_)
  }
}

