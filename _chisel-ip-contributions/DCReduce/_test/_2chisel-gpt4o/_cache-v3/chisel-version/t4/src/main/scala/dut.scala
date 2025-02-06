import chisel3._
import chisel3.util._
import chisel.lib.dclib._

class dut[D <: Data](data: D, n: Int, op: (D, D) => D) extends Module {
  require(n >= 2, "The number of inputs (n) must be at least 2")

  val io = IO(new Bundle {
    val a = Vec(n, Flipped(Decoupled(data.cloneType)))
    val z = Decoupled(data.cloneType)
  })

  // Initialize internal decoupled inputs
  val aInt = io.a.map(DCInput(_))
  val zInt = Wire(Decoupled(data.cloneType))

  // Compute the validity of all inputs
  val all_valid = aInt.map(_.valid).reduce(_ && _)

  // Perform the reduction operation only when all inputs are valid
  val reducedBits = aInt.map(_.bits).reduce(op)

  // Intermediate output wire logic
  zInt.bits := reducedBits
  zInt.valid := all_valid

  // Assign ready signals
  aInt.foreach(_.ready := zInt.ready && all_valid)

  // Connect internal zInt to output using DCOutput
  val zDcout = DCOutput(zInt)
  io.z <> zDcout
}

