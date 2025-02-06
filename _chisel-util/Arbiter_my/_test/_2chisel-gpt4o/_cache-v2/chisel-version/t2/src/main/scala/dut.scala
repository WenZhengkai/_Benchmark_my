import chisel3._
import chisel3.util._

class dut[T <: Data](gen: T, n: Int) extends Module {
  val io = IO(new Bundle {
    val in = Flipped(Vec(n, Decoupled(gen))) // Array of producer inputs
    val out = Decoupled(gen)                 // Consumer output
    val chosen = Output(UInt(log2Ceil(n).W)) // Indicates which input is chosen
  })

  // Priority logic
  val validVec = io.in.map(_.valid)
  val grantVec = Wire(Vec(n, Bool()))
  grantVec := VecInit(ArbiterCtrl_my(validVec))

  // Determine which input is chosen
  val chosenReg = RegInit((n-1).U(log2Ceil(n).W))
  io.chosen := chosenReg

  // Select data and update chosen
  io.out.bits := 0.U.asTypeOf(gen) // Default value
  for (i <- 0 until n) {
    when(grantVec(i)) {
      io.out.bits := io.in(i).bits
      chosenReg := i.U
    }
  }

  // Set ready signals and output validity
  io.out.valid := validVec.contains(true.B)
  io.in.zip(grantVec).foreach { case (in, grant) =>
    in.ready := grant && io.out.ready
  }
}

private object ArbiterCtrl_my {
  def apply(request: Seq[Bool]): Seq[Bool] = request.length match {
    case 0 => Seq()
    case 1 => Seq(true.B)
    case _ => true.B +: request.tail.init.scanLeft(request.head)(_ || _).map(!_)
  }
}

