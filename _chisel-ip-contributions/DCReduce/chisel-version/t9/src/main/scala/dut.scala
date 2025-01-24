import chisel3._
import chisel3.util._
import chisel.lib.dclib._

class dut[D <: Data](data: D, n: Int, op: (D, D) => D) extends Module {
  require(n >= 2, "Number of inputs (n) must be at least 2")
  
  val io = IO(new Bundle {
    val a = Vec(n, Flipped(Decoupled(data.cloneType)))
    val z = Decoupled(data.cloneType)
  })

  // Task 1: Implement Initialization of Internal Inputs
  // Use the DCInput helper to interface external inputs
  val aInt: Vec[DecoupledIO[D]] = VecInit(io.a.map(DCInput(_)))

  // Task 2: Establish Intermediate Output Wire
  // Declare an internal wire to manage computation results
  val zInt: DecoupledIO[D] = Wire(Decoupled(data.cloneType))

  // Task 3: Compute Validity Signal
  // Develop logic for when all inputs are valid
  val all_valid = aInt.forall(_.valid)

  // Task 4: Implement Reduction Operation
  // Use the specified binary operator to reduce inputs
  when (all_valid) {
    val initialValue: D = aInt.head.bits
    zInt.bits := aInt.tail.map(_.bits).foldLeft(initialValue)(op)
  }

  // Task 5: Manage Output Control and Validity
  // Control validity and readiness of the output
  zInt.valid := all_valid && io.z.ready
  aInt.foreach(_.ready := zInt.valid)

  // Task 6: Connect and Interface Output
  // Connect the intermediate output with the final module output
  val zDcout = DCOutput(zInt)
  io.z <> zDcout
}

// Usage example
// Assuming a binary operator function like addition for a specific data type
// val myModule = Module(new DCReduce(UInt(8.W), 4, (a, b) => a + b))
