import chisel3._
import chisel3.util._
import chisel.lib.dclib._

class dut[D <: Data](data: D, n: Int, op: (D, D) => D) extends Module {
  require(n >= 2, "DCReduce requires at least two inputs (n >= 2).")

  val io = IO(new Bundle {
    val a = Input(Vec(n, Flipped(Decoupled(data.cloneType)))) // Input vector of decoupled inputs
    val z = Output(Decoupled(data)) // Decoupled output for the reduction result
  })

  // Step 1: Generate the internal decoupled input using DCInput
  val aInt = Wire(Vec(n, Decoupled(data)))
  for (i <- 0 until n) {
    aInt(i) := DCInput(io.a(i))
  }

  // Step 2: Generate intermediate wire for output using DCOutput
  val zInt = Wire(Decoupled(data))

  // Step 3: Compute the all_valid signal to check if all inputs are valid
  val allValid = aInt.map(_.valid).reduce(_ && _)

  // Step 4: Perform the reduction operation on all valid input bits
  // Use a fold-left operation to apply the binary operator across all inputs
  val reducedResult = aInt.map(_.bits).reduce(op)

  // Step 5: Drive zInt signals based on logic computation
  zInt.bits := reducedResult
  zInt.valid := allValid
  for (i <- 0 until n) {
    aInt(i).ready := zInt.ready && allValid
  }

  // Step 6: Connect zInt to the output using DCOutput
  val zDcout = DCOutput(zInt)
  io.z <> zDcout
}

