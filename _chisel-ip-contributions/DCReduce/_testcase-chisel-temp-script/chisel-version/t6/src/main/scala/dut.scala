import chisel3._
import chisel3.util._
import chisel.lib.dclib._

class dut[D <: Data](data: D, n: Int, op: (D, D) => D) extends Module {
  require(n >= 2, s"The number of inputs `n` must be at least 2, but got $n.")
  
  val io = IO(new Bundle {
    val a = Vec(n, Flipped(Decoupled(data.cloneType)))
    val z = Decoupled(data.cloneType)
  })

  // Step 1: Initialization
  // Create a vector of decoupled inputs using DCInput
  val aInt = VecInit(io.a.map(a => DCInput(a)))
  val zInt = Wire(Decoupled(data.cloneType))

  // Step 2: Logic Computation
  // Compute `all_valid` signal to check if all inputs are valid
  val allValid = aInt.map(_.valid).reduce(_ && _)

  // Perform reduction operation using the provided binary operator
  val reducedResult = aInt.map(_.bits).reduce(op)

  // zInt holds the result of the reduction
  zInt.valid := allValid && io.z.ready
  zInt.bits := reducedResult

  // All inputs are ready when the output is ready to consume data
  aInt.foreach(_.ready := zInt.valid)

  // Step 3: Output Control
  // Connect zInt to zDcout using DCOutput
  val zDcout = DCOutput(zInt)

  // Interface io.z with the result of the DCOutput stage
  io.z <> zDcout
}

// Example of instantiating the DCReduce module
// val reduceModule = Module(new DCReduce(UInt(8.W), 4, (a: UInt, b: UInt) => a + b))
