import chisel3._
import chisel3.util._
import chisel.lib.dclib._

class dut[D <: Data](data: D, n: Int, op: (D, D) => D) extends Module {
  require(n >= 2, "The number of inputs must be at least 2")
  
  val io = IO(new Bundle {
    val a = Vec(n, Flipped(Decoupled(data.cloneType)))
    val z = Decoupled(data.cloneType)
  })

  // Task 1: Implement Initialization of Internal Inputs
  // Create internal decoupled inputs using `DCInput` for interfacing with external inputs
  val aInt = io.a.map(DCInput(_))

  // Task 2: Establish Intermediate Output Wire
  // Set up an internal wire to manage the computation results of the reduction operation
  val zInt = Wire(Decoupled(data.cloneType))

  // Task 3: Compute Validity Signal
  // Develop the logic to determine when all inputs are valid and ready for computation
  val all_valid = aInt.map(_.valid).reduce(_ && _)

  // Task 4: Implement Reduction Operation
  // Use the specified binary operator to perform a reduction across the valid inputs
  val reductionResult = RegInit(data.cloneType, 0.U.asTypeOf(data))
  when (all_valid) {
    reductionResult := aInt.map(_.bits).reduce(op)
  }
  zInt.bits := reductionResult

  // Task 5: Manage Output Control and Validity
  // Control when the reduction result is valid and ready for output, and manage input readiness signals
  zInt.valid := all_valid && io.z.ready
  for (in <- aInt) {
    in.ready := zInt.valid
  }

  // Task 6: Connect and Interface Output
  // Connect the intermediate output with the module's defined output interface
  val zDcout = DCOutput(zInt)
  io.z <> zDcout
}

