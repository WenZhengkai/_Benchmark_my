import chisel3._
import chisel3.util._
import chisel.lib.dclib._

class dut[D <: Data](data: D, n: Int, op: (D, D) => D) extends Module {
  require(n >= 2, "The number of inputs must be at least 2.")

  val io = IO(new Bundle {
    val a = Vec(n, Flipped(Decoupled(data.cloneType)))
    val z = Decoupled(data.cloneType)
  })

  // Internal wires for decoupled inputs and output
  val aInt = VecInit(io.a.map(DCInput(_)))
  val zInt = Wire(Decoupled(data.cloneType))

  // Compute the `all_valid` signal indicating all inputs are valid
  val all_valid = aInt.map(_.valid).reduce(_ && _)

  // Perform reduction operation
  val result = aInt.map(_.bits).reduce(op)

  // Logic to control the `valid` and `ready` signals
  zInt.bits := result
  zInt.valid := all_valid
  aInt.foreach(_.ready := all_valid && zInt.ready)

  // Connect internal output to external output using DCOutput
  val zDcout = DCOutput(zInt)
  io.z <> zDcout
}

