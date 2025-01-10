import chisel3._
import chisel3.util._
import chisel.lib.dclib._

class dut[D <: Data](data: D, n: Int, op: (D, D) => D) extends Module {
  require(n >= 2, "DCReduce requires at least two inputs")

  val io = IO(new Bundle {
    val a = Input(Vec(n, Flipped(Decoupled(data.cloneType))))
    val z = Output(Decoupled(data))
  })

  // Wrap the inputs using DCInput, creating decoupled valid-ready interfaces
  val aInt = io.a.map(DCInput(_))

  // Create an intermediate Decoupled wire for output computation
  val zInt = Wire(Decoupled(data))

  // Compute the all-valid signal
  val all_valid = aInt.map(_.valid).reduce(_ && _)

  // Perform the reduction operation on valid inputs
  val reducedResult = aInt.map(_.bits).reduce(op)

  // Logic for setting the output valid signal and ready for inputs
  zInt.bits := reducedResult
  zInt.valid := all_valid

  for ((input, index) <- aInt.zipWithIndex) {
    input.ready := all_valid && zInt.ready
  }

  // Connect the output through DCOutput and map it to io.z
  val zDcout = DCOutput(zInt)
  io.z <> zDcout
}
