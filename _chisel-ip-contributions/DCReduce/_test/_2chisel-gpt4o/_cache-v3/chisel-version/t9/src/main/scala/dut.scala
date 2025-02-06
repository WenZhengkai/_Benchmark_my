import chisel3._
import chisel3.util._
import chisel.lib.dclib._

class dut[D <: Data](data: D, n: Int, op: (D, D) => D) extends Module {
  require(n >= 2, "n must be at least 2")
  
  val io = IO(new Bundle {
    val a = Vec(n, Flipped(Decoupled(data.cloneType)))
    val z = Decoupled(data.cloneType)
  })

  // Internal decoupled inputs
  val aInt = VecInit(io.a.map(DCInput(_)))
  
  // Intermediate wire for output
  val zInt = Wire(Decoupled(data.cloneType))
  
  // Valid signals for all inputs
  val allValid = aInt.map(_.valid).reduce(_ && _)
  
  // Reduction operation
  zInt.bits := aInt.map(_.bits).reduce(op)
  
  // Output control logic
  zInt.valid := allValid
  aInt.foreach(_.ready := zInt.ready && allValid)
  
  // Connecting zInt to output using DCOutput
  val zDcout = DCOutput(zInt)
  io.z <> zDcout
}


