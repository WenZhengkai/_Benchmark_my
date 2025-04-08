
import chisel3._
import chisel3.util._
import chisel.lib.dclib._

class dut[D <: Data](data: D, n: Int, op: (D, D) => D) extends Module {
  require(n >= 2, "Number of inputs (n) must be at least 2")

  val io = IO(new Bundle {
    val a = Vec(n, Flipped(Decoupled(data.cloneType))) // Input vector
    val z = Decoupled(data.cloneType)                 // Output
  })

  // Task 1: Initialize Internal Interfaces
  val aInt = VecInit(io.a.map(a => DCInput(a)))        // Registered inputs
  val zInt = Wire(Decoupled(data.cloneType))           // Internal intermediate wire

  // Task 2: Generate Validation Signal
  val all_valid = aInt.map(_.valid).reduce(_ && _)     // Logical AND of all `valid` signals

  // Task 3: Implement Reduction Logic
  zInt.bits := aInt.map(_.bits).reduce(op)             // Perform tree reduction using `op`

  // Task 4: Control Flow Logic
  when(all_valid && zInt.ready) {
    zInt.valid := true.B                               // Output valid when all inputs are valid
    aInt.foreach(_.ready := true.B)                   // Mark all inputs as ready
  }.otherwise {
    zInt.valid := false.B                              // Output not valid otherwise
    aInt.foreach(_.ready := false.B)                  // Inputs not ready otherwise
  }

  // Task 5: Output Registration
  val zDcout = DCOutput(zInt)                          // Wrap internal wire with `DCOutput`
  io.z <> zDcout                                       // Connect internal output to module output
}

