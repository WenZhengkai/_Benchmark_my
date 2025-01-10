import chisel3._
import chisel3.util._
import chisel.lib.dclib._

class dut[D <: Data](data: D, n: Int, op: (D, D) => D) extends Module {
  require(n >= 2, "The number of inputs must be at least 2")

  val io = IO(new Bundle {
    val a = Input(Vec(n, Flipped(Decoupled(data.cloneType))))
    val z = Output(Decoupled(data))
  })

  // Internal signals
  val aInt = VecInit(io.a.map(DCInput(_)))
  val zInt = Wire(Decoupled(data))

  // All-valid signal
  val allValid = aInt.map(_.valid).reduce(_ && _)

  // Reduction logic
  val reducedResult = aInt.map(_.bits).reduce(op)

  // Drive zInt
  zInt.bits := reducedResult
  zInt.valid := allValid
  aInt.foreach(_.ready := zInt.ready)

  // DCOutput
  val zDcout = DCOutput(zInt)

  // Connect to module's output
  io.z <> zDcout
}

