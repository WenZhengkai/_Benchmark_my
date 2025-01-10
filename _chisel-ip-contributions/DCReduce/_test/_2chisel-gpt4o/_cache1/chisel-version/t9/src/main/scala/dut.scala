import chisel3._
import chisel3.util._
import chisel.lib.dclib._

class dut[D <: Data](data: D, n: Int, op: (D, D) => D) extends Module {
  require(n >= 2, "The number of inputs must be at least 2")

  val io = IO(new Bundle {
    val a = Vec(n, Flipped(Decoupled(data.cloneType)))
    val z = Decoupled(data)
  })

  // Initialize internal decoupled inputs using DCInput
  val aInt = io.a.map(DCInput(_))
  
  // Create an internal wire for the reduction result
  val zInt = Wire(Decoupled(data))

  // Compute all_valid signal
  val allValid = aInt.map(_.valid).reduce(_ && _)

  // Initialize reduction and ready signals
  val reductionResult = RegInit(data.cloneType, 0.U.asTypeOf(data))
  val readyReg = RegInit(false.B)

  // Perform reduction operation when all inputs are valid and output is ready
  when(allValid && zInt.ready) {
    reductionResult := aInt.map(_.bits).reduce(op)
    readyReg := true.B
  } .otherwise {
    readyReg := false.B
  }

  // Assign zInt values
  zInt.bits := reductionResult
  zInt.valid := readyReg

  // Connect ready signals
  aInt.foreach(_.ready := zInt.ready && allValid)

  // Use DCOutput to connect the intermediate zInt to the output
  val zDcout = DCOutput(zInt)
  io.z <> zDcout
}


