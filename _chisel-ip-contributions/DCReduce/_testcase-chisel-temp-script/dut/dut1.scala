import chisel3._
import chisel3.util._
import chisel.lib.dclib._

class dut[D <: Data](data: D, n: Int, op: (D, D) => D) extends Module {
  require(n >= 2, "The module requires at least two inputs")

  val io = IO(new Bundle {
    val a = Vec(n, Flipped(Decoupled(data.cloneType)))
    val z = Decoupled(data.cloneType)
  })

  // Task 1: Initialization of Internal Structures
  val aInt = io.a.map(DCInput(_))
  val zInt = Wire(Decoupled(data.cloneType))

  // Task 2: Signal Generation for Validity Checking
  val allValid = aInt.map(_.valid).reduce(_ && _)

  // Task 3: Implement Reduction Operation
  zInt.bits := aInt.map(_.bits).reduce(op)

  // Task 4: Output Control Logic
  zInt.valid := allValid && io.z.ready
  io.z.valid := zInt.valid
  io.z.bits := zInt.bits

  // Iterate over inputs to set ready signals based on output acceptance
  for (input <- aInt) {
    input.ready := zInt.ready && allValid
  }

  // Task 5: Interface the Output with DCOutput
  val zDcout = DCOutput(zInt)
  io.z <> zDcout
}

// Usage example:
// val myDCReduce = Module(new DCReduce(UInt(8.W), 4, (a: UInt, b: UInt) => a + b))
