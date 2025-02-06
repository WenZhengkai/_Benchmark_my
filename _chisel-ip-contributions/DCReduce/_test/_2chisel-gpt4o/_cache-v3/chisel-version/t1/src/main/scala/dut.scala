import chisel3._
import chisel3.util._
import chisel.lib.dclib._

class dut[D <: Data](data: D, n: Int, op: (D, D) => D) extends Module {
  require(n >= 2, "The number of inputs must be at least 2.")

  val io = IO(new Bundle {
    val a = Vec(n, Flipped(Decoupled(data.cloneType)))
    val z = Decoupled(data.cloneType)
  })

  // Generate a vector of internal decoupled inputs using DCInput
  val aInt = VecInit(io.a.map(DCInput(_)))

  // Internal wire for output computation
  val zInt = Wire(Decoupled(data.cloneType))

  // Compute `all_valid` signal
  val all_valid = aInt.map(_.valid).reduce(_ && _)

  // Reduction operation using the provided binary operator `op`
  val reducedResult = aInt.map(_.bits).reduce(op)

  // Connect result to `zInt`
  zInt.bits := reducedResult
  zInt.valid := all_valid

  // Control the ready signals for inputs and output decoupling
  for (i <- 0 until n) {
    aInt(i).ready := zInt.ready && all_valid
  }
  
  // Use DCOutput for interfacing `zInt` with `io.z`
  val zDcout = DCOutput(zInt)
  io.z <> zDcout
}
