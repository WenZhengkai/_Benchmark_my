import chisel3._
import chisel3.util._
import chisel.lib.dclib._

class dut[D <: Data](data: D, n: Int, op: (D, D) => D) extends Module {
  // Require at least two inputs
  require(n >= 2, "The number of inputs must be at least two.")

  val io = IO(new Bundle {
    val a = Vec(n, Flipped(Decoupled(data.cloneType)))
    val z = Decoupled(data.cloneType)
  })

  // Task 1: Initialization of Internal Structures
  // Create an internal vector of inputs with DCInput wrapping
  val aInt = io.a.map(DCInput(_))
  // Define an intermediate wire for the result
  val zInt = Wire(Decoupled(data.cloneType))

  // Task 2: Signal Generation for Validity Checking
  // Compute all_valid as a boolean signal ensuring all inputs are valid
  val all_valid = aInt.map(_.valid).reduce(_ && _)

  // Task 3: Implement Reduction Operation
  // Perform the fold operation using the binary operator op
  zInt.bits := aInt.map(_.bits).reduce(op)

  // Task 4: Output Control Logic
  // Set zInt valid signal based on all_valid and zInt ready signal
  zInt.valid := all_valid && io.z.ready
  // Set all aInt ready signals based on zInt ready and all_valid
  aInt.foreach(_.ready := zInt.ready && all_valid)

  // Task 5: Interface the Output with DCOutput
  // Create a DCOutput instance to handle the output decoupling
  val zDcout = DCOutput(zInt)
  // Connect the final output to io.z
  io.z <> zDcout
}

