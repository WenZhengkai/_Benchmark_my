import chisel3._
import chisel3.util._
import chisel.lib.dclib._

class dut[D <: Data](data: D, n: Int, op: (D, D) => D) extends Module {
  require(n >= 2, "The number of inputs (n) must be at least 2.")
  val io = IO(new Bundle {
    val a = Vec(n, Flipped(Decoupled(data.cloneType))) // Input vector of Decoupled
    val z = Decoupled(data.cloneType)                 // Output Decoupled
  })

  // Task 1: Initialize Internal Interfaces
  val aInt = VecInit(io.a.map(a => DCInput(a))) // Registered inputs
  val zInt = Wire(Decoupled(data.cloneType))    // Intermediate wire for output

  // Task 2: Generate Validation Signal
  val all_valid = aInt.map(_.valid).reduce(_ && _) // Combine valid signals for all inputs

  // Task 3: Implement Reduction Logic
  zInt.bits := aInt.map(_.bits).reduce(op) // Perform reduction using binary operator

  // Task 4: Control Flow Logic
  when(all_valid && zInt.ready) { // When all inputs are valid and output is ready
    zInt.valid := true.B
    aInt.foreach(_.ready := true.B) // Set input ready signals to true
  }.otherwise { // Otherwise, handshake is not active
    zInt.valid := false.B
    aInt.foreach(_.ready := false.B) // Set input ready signals to false
  }

  // Task 5: Output Registration
  val zDcout = DCOutput(zInt) // Wrap zInt with DCOutput for registered output
  io.z <> zDcout             // Connect the registered output to module's final output
}
