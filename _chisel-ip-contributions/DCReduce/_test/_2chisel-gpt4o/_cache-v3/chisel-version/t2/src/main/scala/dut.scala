import chisel3._
import chisel3.util._
import chisel.lib.dclib._

class dut[D <: Data](data: D, n: Int, op: (D, D) => D) extends Module {
  require(n >= 2, "The number of inputs must be at least 2.")
  val io = IO(new Bundle {
    val a = Vec(n, Flipped(Decoupled(data.cloneType)))
    val z = Decoupled(data.cloneType)
  })

  // Internal decoupled inputs
  val aInt = VecInit(io.a.map(DCInput(_)))

  // Internal decoupled output
  val zInt = Wire(Decoupled(data.cloneType))

  // Compute all_valid: true if all input channels are valid
  val all_valid = aInt.map(_.valid).reduce(_ && _)

  // Reduction result
  val reductionResult = aInt.map(_.bits).reduce(op)

  // Control the decoupled logic
  zInt.bits := reductionResult
  zInt.valid := all_valid && io.z.ready

  // All inputs are ready only when io.z.fire() occurs
  for (i <- 0 until n) {
    aInt(i).ready := io.z.ready && all_valid
  }

  // Connect output through DCOutput
  val zDcout = DCOutput(zInt)
  io.z <> zDcout
}


