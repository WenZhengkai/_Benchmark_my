import chisel3._
import chisel3.util._

class dut[T <: Data](gen: T, n: Int) extends Module {
  require(n > 0, "The number of producers must be greater than 0")
  val io = IO(new Bundle {
    val in = Flipped(Vec(n, Decoupled(gen)))
    val out = Decoupled(gen)
    val chosen = Output(UInt(log2Ceil(n).W))
  })

  // Generate ready signals for each input based on the priority logic
  val request = io.in.map(_.valid)
  val grant = ArbiterCtrl_my(request)

  // Select the first valid input and connect it to the output
  io.chosen := PriorityMux(request.zipWithIndex.map { case (req, index) => (req, index.U) })
  io.out.bits := Mux1H(grant, io.in.map(_.bits))
  
  // Set validity and readiness based on the grant
  io.out.valid := grant.zip(io.in).map { case (g, in) => g && in.valid }.reduce(_ || _)
  io.in.zip(grant).foreach { case (in, g) => in.ready := g && io.out.ready }
}

private object ArbiterCtrl_my {
  def apply(request: Seq[Bool]): Seq[Bool] = request.length match {
    case 0 => Seq()
    case 1 => Seq(true.B)
    case _ => true.B +: request.tail.init.scanLeft(request.head)(_ || _).map(!_)

  }
}

// The module instantiation might look something like this in your testbench or main program
// val arbiter = Module(new Arbiter_my(UInt(), 3))
// Connect your inputs and outputs accordingly
