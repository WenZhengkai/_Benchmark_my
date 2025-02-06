import chisel3._
import chisel3.util._
import chisel.lib.dclib._

class dut[D <: Data](data: D, n: Int, op: (D, D) => D) extends Module {
  require(n >= 2, "The number of inputs must be at least 2.")

  val io = IO(new Bundle {
    val a = Vec(n, Flipped(Decoupled(data.cloneType)))
    val z = Decoupled(data.cloneType)
  })

  // Task 1: Initialization of Internal Structures
  val aInt = VecInit(io.a.map(a => DCInput(a)))
  val zInt = Wire(Decoupled(data.cloneType))

  // Task 2: Signal Generation for Validity Checking
  val all_valid = aInt.map(_.valid).reduce(_ && _)

  // Task 3: Implement Reduction Operation
  val reducedResult = aInt.map(_.bits).reduce(op)
  zInt.bits := reducedResult

  // Task 4: Output Control Logic
  zInt.valid := all_valid && zInt.ready
  aInt.foreach(_.ready := zInt.ready)

  // Task 5: Interface the Output with DCOutput
  val zDcout = DCOutput(zInt)
  io.z <> zDcout
}

// Define an example binary operator for testing purposes, e.g., addition for UInt
// val reductionModule = Module(new DCReduce(UInt(32.W), 2, (x, y) => x + y))

