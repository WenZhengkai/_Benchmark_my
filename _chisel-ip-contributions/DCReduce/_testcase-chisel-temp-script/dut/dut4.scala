import chisel3._
import chisel3.util._
import chisel.lib.dclib._

// Define the DCReduce module
class dut[D <: Data](data: D, n: Int, op: (D, D) => D) extends Module {
  require(n >= 2, "The module requires at least two inputs.")

  val io = IO(new Bundle {
    val a = Vec(n, Flipped(Decoupled(data.cloneType)))
    val z = Decoupled(data.cloneType)
  })

  // Task 1: Initialization of Internal Structures
  // Create a vector `aInt` using the `DCInput` helper function for each input in `io.a`.
  val aInt = io.a.map(DCInput(_))
  
  // Define an intermediate wire `zInt` to carry the reduction result
  val zInt = Wire(Decoupled(data.cloneType))
  
  // Task 2: Signal Generation for Validity Checking
  // Compute `all_valid` signal ensuring that every input is valid
  val all_valid = aInt.map(_.valid).reduce(_ && _)

  // Task 3: Implement Reduction Operation
  // Perform a fold operation to apply the binary operator `op`
  zInt.bits := aInt.map(_.bits).reduce(op)
  
  // Task 4: Output Control Logic
  // Set zInt.valid based on all_valid and zInt.ready
  zInt.valid := all_valid && io.z.ready

  // Manage the ready signals of inputs in aInt
  aInt.foreach(_.ready := zInt.valid)

  // Task 5: Interface the Output with DCOutput
  // Connect the intermediate output `zInt` to the final module output `io.z`
  io.z <> DCOutput(zInt)
}

