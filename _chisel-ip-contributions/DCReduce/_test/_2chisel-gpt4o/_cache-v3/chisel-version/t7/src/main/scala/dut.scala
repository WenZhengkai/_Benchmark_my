import chisel3._
import chisel3.util._
import chisel.lib.dclib._

class dut[D <: Data](data: D, n: Int, op: (D, D) => D) extends Module {
  require(n >= 2, "The number of inputs 'n' must be at least 2")
  val io = IO(new Bundle {
    val a = Vec(n, Flipped(Decoupled(data.cloneType)))
    val z = Decoupled(data.cloneType)
  })

  // Internal decoupled input wires
  val aInt = VecInit(io.a.map(a => DCInput(a)))

  // Internal decoupled output wire
  val zInt = Wire(Decoupled(data.cloneType))

  // Check if all input signals are valid
  val allValid = aInt.map(_.valid).reduce(_ && _)

  // Perform reduction operation
  val reducedResult = aInt.map(_.bits).reduce(op)

  // Connect the reduction result to zInt
  zInt.bits := reducedResult
  zInt.valid := allValid

  // Set aInt.ready signals
  for (i <- 0 until n) {
    aInt(i).ready := allValid && io.z.ready
  }

  // Connect internal zInt to external z using DCOutput
  val zDcout = DCOutput(zInt)
  io.z <> zDcout
}

