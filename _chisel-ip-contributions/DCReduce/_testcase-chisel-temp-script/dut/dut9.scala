

import chisel3._
import chisel3.util._
import chisel.lib.dclib._

class dut[D <: Data](data: D, n: Int, op: (D, D) => D) extends Module {
  require(n >= 2, "The number of inputs 'n' must be at least 2.")

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
  when(all_valid) {
    zInt.bits := aInt.map(_.bits).reduce(op)
  }.otherwise {
    zInt.bits := 0.U.asTypeOf(data) // Default value when inputs are not valid
  }

  // Task 4: Output Control Logic
  zInt.valid := all_valid && io.z.ready
  aInt.foreach(_.ready := zInt.ready)

  // Task 5: Interface the Output with DCOutput
  val zDcout = DCOutput(zInt)
  io.z <> zDcout
}

