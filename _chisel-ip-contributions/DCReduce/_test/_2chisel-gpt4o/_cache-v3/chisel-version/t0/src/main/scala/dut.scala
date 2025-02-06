import chisel3._
import chisel3.util._
import chisel.lib.dclib._

class dut[D <: Data](data: D, n: Int, op: (D, D) => D) extends Module {
  require(n >= 2, "The number of inputs n must be at least 2")

  val io = IO(new Bundle {
    val a = Vec(n, Flipped(Decoupled(data.cloneType)))
    val z = Decoupled(data.cloneType)
  })

  // Initialize internal decoupled inputs using DCInput
  val aInt = io.a.map(DCInput(_))

  // Create an intermediary decoupled wire for the output computation
  val zInt = Wire(Decoupled(data.cloneType))

  // Logic Computation
  val all_valid = aInt.map(_.valid).reduce(_ && _)

  // Perform reduction operation
  when(all_valid) {
    zInt.bits := aInt.map(_.bits).reduce(op)
    zInt.valid := true.B
    aInt.foreach(_.ready := zInt.ready)
  } .otherwise {
    zInt.valid := false.B
    aInt.foreach(_.ready := false.B)
  }

  // Output Control
  val zDcout = DCOutput(zInt)
  io.z <> zDcout

}

