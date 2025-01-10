import chisel3._
import chisel3.util._
import chisel.lib.dclib._

class dut[D <: Data](data: D, n: Int, op: (D, D) => D) extends Module {
  require(n >= 2, "The number of inputs (n) must be at least 2")

  val io = IO(new Bundle {
    val a = Input(Vec(n, Flipped(Decoupled(data.cloneType))))
    val z = Output(Decoupled(data.cloneType))
  })

  // Create internal decoupled inputs using DCInput
  val aInt = VecInit(io.a.map(DCInput(_)))

  // Create an internal wire for the reduction result
  val zInt = Wire(Decoupled(data.cloneType))

  // Compute all_valid signal
  val all_valid = aInt.forall(_.valid)

  // Connect the ready signals conditionally based on zInt.ready and all_valid
  for (input <- aInt) {
    input.ready := zInt.ready && all_valid
  }

  // Perform the reduction operation using the provided op function
  zInt.bits := aInt.map(_.bits).reduce(op)

  // Set the valid signal for the output
  zInt.valid := all_valid

  // Connect zInt to the output using DCOutput
  val zDcout = DCOutput(zInt)
  io.z <> zDcout
}

// Example usage:
// object DCReduceExample extends App {
//   chisel3.Driver.execute(Array("--target-dir", "generated"), () => new DCReduce(UInt(8.W), 4, (a: UInt, b: UInt) => a + b))
// }
