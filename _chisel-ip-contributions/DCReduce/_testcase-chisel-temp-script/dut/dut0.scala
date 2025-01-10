import chisel3._
import chisel3.util._
import chisel.lib.dclib._

class dut[D <: Data](data: D, n: Int, op: (D, D) => D) extends Module {
  require(n >= 2, "The number of inputs (n) should be at least 2")

  val io = IO(new Bundle {
    val a = Vec(n, Flipped(Decoupled(data.cloneType)))
    val z = Decoupled(data)
  })

  // Initialize internal decoupled inputs using DCInput
  val aInt = VecInit(io.a.map(a => DCInput(a)))

  // Internal wire for the reduction result
  val zInt = Wire(Decoupled(data))

  // Compute all_valid signal
  val all_valid = aInt.map(_.valid).reduce(_ && _)

  // Reduction operation on valid inputs
  val reducedResult = aInt.map(_.bits).reduce(op)

  // Output control logic
  zInt.bits := reducedResult
  zInt.valid := all_valid && io.z.ready

  // Set ready signals for inputs
  for (i <- 0 until n) {
    aInt(i).ready := all_valid && io.z.ready
  }

  // Use DCOutput for the final output
  val zDcout = DCOutput(zInt)
  io.z <> zDcout
}

