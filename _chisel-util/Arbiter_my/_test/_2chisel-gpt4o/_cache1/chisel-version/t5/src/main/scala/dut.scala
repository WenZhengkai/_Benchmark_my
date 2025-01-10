import chisel3._
import chisel3.util._

class dut[T <: Data](gen: T, n: Int) extends Module {
  require(n >= 1, "Number of producers must be at least 1")
  
  val io = IO(new Bundle {
    val in = Flipped(Vec(n, Decoupled(gen)))
    val out = Decoupled(gen)
    val chosen = Output(UInt(log2Ceil(n).W))
  })

  // Priority Resolution: Select the first valid input with the lowest index
  val validVec = io.in.map(_.valid)
  val grantVec = ArbiterCtrl_my(validVec)
  
  io.chosen := PriorityMux(validVec, (0 until n).map(_.U))
  
  // Connect the selected producer to the output
  io.out.bits := Mux1H(grantVec, io.in.map(_.bits))
  io.out.valid := validVec.reduce(_ || _)
  
  // Generate ready signals for each producer
  io.in.zip(grantVec).foreach { case (in, grant) =>
    in.ready := grant && io.out.ready
  }
}

private object ArbiterCtrl_my {
  def apply(request: Seq[Bool]): Seq[Bool] = request.length match {
    case 0 => Seq()
    case 1 => Seq(true.B)
    case _ => true.B +: request.tail.init.scanLeft(request.head)(_ || _).map(!_ || _)
  }
}

