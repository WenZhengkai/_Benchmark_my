import chisel3._
import chisel3.util._
import chisel.lib.dclib._

class dut[D <: Data](data: D, n: Int, op: (D, D) => D) extends Module {
  require(n >= 2, "There must be at least two inputs for the reduction operation.")

  val io = IO(new Bundle {
    val a = Input(Vec(n, Flipped(Decoupled(data.cloneType))))
    val z = Decoupled(data)
  })

  // Initialization: Convert inputs to decoupled using DCInput
  val aInt = io.a.map(DCInput(_))

  // Internal wire for intermediate output computation
  val zInt = Wire(Decoupled(data))

  // Logic Computation: Check if all inputs are valid
  val all_valid = aInt.map(_.valid).reduce(_ && _)

  // Perform the reduction operation on valid inputs
  val reducedBits = aInt.map(_.bits).reduce(op)

  // Setup the bits and valid signals for zInt
  zInt.bits := reducedBits
  zInt.valid := all_valid

  // Ready signal control: Only set ready if zInt is ready to accept data
  aInt.foreach(_.ready := zInt.ready && all_valid)

  // Output Control: Connect zInt through DCOutput to the external output interface
  val zDcout = DCOutput(zInt)
  io.z <> zDcout
}


