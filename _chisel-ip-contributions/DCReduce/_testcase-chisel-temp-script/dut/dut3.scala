import chisel3._
import chisel3.util._
import chisel.lib.dclib._

class dut[D <: Data](data: D, n: Int, op: (D, D) => D) extends Module {
  require(n >= 2, "The number of inputs (n) must be at least 2.") // Enforce n >= 2
  val io = IO(new Bundle {
    val a = Vec(n, Flipped(Decoupled(data.cloneType))) // Input vector of decoupled data
    val z = Decoupled(data.cloneType)                 // Single decoupled output
  })

  // Task 1: Initialize Internal Interfaces
  val aInt = VecInit(io.a.map(a => DCInput(a)))       // Create DCInput wrappers for all inputs
  val zInt = Wire(Decoupled(data.cloneType))          // Internal wire for result

  // Task 2: Generate Validation Signal
  val all_valid = aInt.map(_.valid).reduce(_ && _)    // Combine all valid signals

  // Task 3: Implement Reduction Logic
  zInt.bits := aInt.map(_.bits).reduce(op)           // Perform reduction using the provided binary operator

  // Task 4: Control Flow Logic
  when(all_valid && zInt.ready) {                    // If all inputs are valid and output is ready
    zInt.valid := true.B                             // Mark output as valid
    aInt.foreach(_.ready := true.B)                  // Set all inputs ready
  }.otherwise {
    zInt.valid := false.B                            // Otherwise, mark output as invalid
    aInt.foreach(_.ready := false.B)                 // Set all inputs not ready
  }

  // Task 5: Output Registration
  val zDcout = DCOutput(zInt)                        // Wrap internal wire with DCOutput
  io.z <> zDcout                                     // Connect output to module's output port
}

