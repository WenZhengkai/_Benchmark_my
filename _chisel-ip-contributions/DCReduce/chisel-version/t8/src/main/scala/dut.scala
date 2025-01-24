import chisel3._
import chisel3.util._
import chisel.lib.dclib._

class dut[D <: Data](data: D, n :Int, op: (D, D) => D) extends Module {
  require(n >= 2, "The number of inputs must be at least 2") // Ensure n is at least 2

  val io = IO(new Bundle {
    val a = Vec(n, Flipped(Decoupled(data.cloneType))) // Vector of decoupled inputs
    val z = Decoupled(data) // Decoupled output
  })

  // Task 1: Implement Initialization of Internal Inputs
  val aInt = VecInit(io.a.map(DCInput(_)))

  // Task 2: Establish Intermediate Output Wire
  val zInt = Wire(Decoupled(data))

  // Task 3: Compute Validity Signal
  val all_valid = aInt.map(_.valid).reduce(_ && _)

  // Task 4: Implement Reduction Operation
  zInt.bits := aInt.map(_.bits).reduce(op)
  
  // Task 5: Manage Output Control and Validity
  zInt.valid := all_valid && io.z.ready
  for (i <- 0 until n) {
    aInt(i).ready := all_valid && io.z.ready
  }

  // Task 6: Connect and Interface Output
  val zDcout = DCOutput(zInt)
  io.z <> zDcout
}
