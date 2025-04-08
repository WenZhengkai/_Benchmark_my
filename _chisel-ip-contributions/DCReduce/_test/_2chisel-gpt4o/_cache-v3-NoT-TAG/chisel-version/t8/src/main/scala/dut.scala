import chisel3._
import chisel3.util._
import chisel.lib.dclib._

class dut[D <: Data](data: D, n: Int, op: (D, D) => D) extends Module {
  require(n >= 2, "The number of inputs (n) must be at least 2.")

  val io = IO(new Bundle {
    val a = Vec(n, Flipped(Decoupled(data.cloneType)))
    val z = Decoupled(data.cloneType)
  })

  // Task 1: Initialize Internal Interfaces
  val aInt = VecInit(io.a.map(a => DCInput(a))) // Registered inputs using DCInput
  val zInt = Wire(Decoupled(data.cloneType))    // Intermediate decoupled wire for output

  // Task 2: Generate Validation Signal
  val all_valid = aInt.map(_.valid).reduce(_ && _) // Combine all input valid signals using AND

  // Task 3: Implement Reduction Logic
  zInt.bits := aInt.map(_.bits).reduce(op) // Perform tree reduction using the provided binary operator

  // Task 4: Control Flow Logic
  when(all_valid && zInt.ready) {
    zInt.valid := true.B
    aInt.foreach(_.ready := true.B) // Set input ready signals to true
  }.otherwise {
    zInt.valid := false.B
    aInt.foreach(_.ready := false.B) // Set input ready signals to false
  }

  // Task 5: Output Registration
  val zDcout = DCOutput(zInt) // Wrap the internal decoupled wire with DCOutput
  io.z <> zDcout              // Connect to the module's output port
}
