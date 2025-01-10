import chisel3._
import chisel3.util._
import chisel.lib.dclib._

class dut[D <: Data](data: D, n: Int, op: (D, D) => D) extends Module {
  require(n >= 2, "The number of inputs 'n' must be at least 2.")

  val io = IO(new Bundle {
    val a = Vec(n, Flipped(Decoupled(data.cloneType)))
    val z = Decoupled(data.cloneType)
  })

  // Create internal decoupled inputs using DCInput
  val aInt = VecInit(io.a.map(DCInput(_)))

  // Create an internal decoupled wire for the output
  val zInt = Wire(Decoupled(data.cloneType))

  // Compute the all_valid signal indicating if all inputs are valid
  val allValid = aInt.map(_.valid).reduce(_ && _)

  // Perform reduction operation on the inputs
  val reductionResult = aInt.map(_.bits).reduce(op)

  // Wire the internal output logic
  zInt.bits := reductionResult
  zInt.valid := allValid

  // Set ready signals based on output readiness
  aInt.foreach(_.ready := zInt.ready && allValid)

  // Connect the internal output to DCOutput for decoupled flow control
  val zDcout = DCOutput(zInt)
  io.z <> zDcout
}

