import chisel3._
import chisel3.util._
import chisel.lib.dclib._

class dut[D <: Data](data: D, n: Int, op: (D, D) => D) extends Module {
  require(n >= 2, "The number of inputs must be at least 2")

  val io = IO(new Bundle {
    val a = Input(Vec(n, Flipped(Decoupled(data.cloneType))))
    val z = Output(Decoupled(data))
  })

  // Create internal decoupled inputs using DCInput
  val aInt = io.a.map(DCInput.apply)

  // Internal wire for intermediate decoupled output
  val zInt = Wire(Decoupled(data))

  // Compute the all_valid signal
  val all_valid = aInt.map(_.valid).reduce(_ && _)

  // Perform the reduction operation
  val reducedResult = aInt.map(_.bits).reduce(op)

  // Assign the reduction result to zInt.bits
  zInt.bits := reducedResult

  // Output control logic
  zInt.valid := all_valid
  aInt.foreach(_.ready := zInt.ready && all_valid)

  // Connect internal output zInt to the registered output using DCOutput
  val zDcout = DCOutput(zInt)
  io.z <> zDcout
}

