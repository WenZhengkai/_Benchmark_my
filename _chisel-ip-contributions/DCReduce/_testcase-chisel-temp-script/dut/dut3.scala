import chisel3._
import chisel3.util._
import chisel.lib.dclib._

class dut[D <: Data](data: D, n: Int, op: (D, D) => D) extends Module {
  require(n >= 2, "Number of inputs (n) must be at least 2")

  val io = IO(new Bundle {
    val a = Vec(n, Flipped(Decoupled(data.cloneType)))
    val z = Decoupled(data.cloneType)
  })

  // Task 1: Initialization of Internal Structures
  val aInt = io.a.map(DCInput(_))
  val zInt = Wire(Decoupled(data.cloneType))

  // Task 2: Signal Generation for Validity Checking
  val all_valid = aInt.map(_.valid).reduce(_ && _)

  // Task 3: Implement Reduction Operation
  val reductionResult = aInt.map(_.bits).reduce(op)
  zInt.bits := reductionResult

  // Task 4: Output Control Logic
  zInt.valid := all_valid && zInt.ready
  aInt.foreach(_.ready := zInt.ready && all_valid)

  // Task 5: Interface the Output with DCOutput
  val zDcout = DCOutput(zInt)
  io.z <> zDcout
}

