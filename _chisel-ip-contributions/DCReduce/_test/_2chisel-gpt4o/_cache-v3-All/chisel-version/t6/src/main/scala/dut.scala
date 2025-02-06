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
  // Create internal DCInput for each a in io.a
  val aInt = io.a.map(DCInput(_))

  // Intermediate wire to carry the result
  val zInt = Wire(Decoupled(data.cloneType))

  // Task 2: Signal Generation for Validity Checking
  // Check the validity of all inputs
  val all_valid = aInt.map(_.valid).reduce(_ && _)

  // Task 3: Implement Reduction Operation
  // Perform the reduction operation on valid inputs
  val reducedResult = aInt.map(_.bits).reduce(op)
  zInt.bits := reducedResult

  // Task 4: Output Control Logic
  when(all_valid && zInt.ready) {
    zInt.valid := true.B
    aInt.foreach(_.ready := true.B)
  } .otherwise {
    zInt.valid := false.B
    aInt.foreach(_.ready := false.B)
  }

  // Task 5: Interface the Output with DCOutput
  // Use DCOutput to connect zInt to output io.z
  val zDcout = DCOutput(zInt)

  // Connect the output interface
  io.z <> zDcout
}

