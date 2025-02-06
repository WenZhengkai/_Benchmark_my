import chisel3._
import chisel3.util._
import chisel.lib.dclib._

class dut[D <: Data](data: D, n: Int, op: (D, D) => D) extends Module {
  require(n >= 2, "The module requires at least two inputs.")

  val io = IO(new Bundle {
    val a = Vec(n, Flipped(Decoupled(data.cloneType)))
    val z = Decoupled(data.cloneType)
  })

  // Task 1: Initialization of Internal Structures
  // Initialize the internal inputs with DCInput
  val aInt = io.a.map(DCInput(_))

  // Define an intermediate wire for the reduction result
  val zInt = Wire(Decoupled(data.cloneType))

  // Task 2: Signal Generation for Validity Checking
  // Check that all inputs are valid
  val all_valid = aInt.map(_.valid).reduce(_ && _)

  // Task 3: Implement Reduction Operation
  // Perform reduction on inputs with the provided binary operator
  val reducedResult = aInt.map(_.bits).reduce(op)
  zInt.bits := reducedResult

  // Task 4: Output Control Logic
  // Control the output valid signal
  zInt.valid := all_valid && zInt.ready

  // Control the ready signals of the inputs
  aInt.foreach(_.ready := zInt.ready)

  // Task 5: Interface the Output with DCOutput
  // Connect the intermediate output to the final output using DCOutput
  val zDcout = DCOutput(zInt)

  // Connect the final output
  io.z <> zDcout
}
