import chisel3._
import chisel3.util._
import chisel.lib.dclib._

class dut[D <: Data](data: D, n: Int, op: (D, D) => D) extends Module {
  require(n >= 2, "The number of inputs must be at least 2.")
  
  val io = IO(new Bundle {
    val a = Vec(n, Flipped(Decoupled(data.cloneType))) // Input vector of decoupled data
    val z = Decoupled(data.cloneType)                  // Output of decoupled data
  })
  
  // Create internal decoupled inputs using DCInput for functional inference
  val aInt = VecInit(io.a.map(DCInput(_)))
  
  // Wire for intermediate result
  val zInt = Wire(Decoupled(data.cloneType))
  
  // Compute all_valid signal to check if all inputs are valid
  val all_valid = aInt.map(_.valid).reduce(_ && _)
  
  // Reduction logic using the specified binary operator
  val result = aInt.map(_.bits).reduce(op)
  
  // Populate intermediate result wire zInt
  zInt.bits := result
  zInt.valid := all_valid && io.z.ready
  
  // Propagate ready signals back to inputs based on output's readiness
  aInt.foreach(_.ready := zInt.valid && io.z.ready)
  
  // Connect internal decoupled output zInt to external output z through DCOutput
  io.z <> DCOutput(zInt)
}

