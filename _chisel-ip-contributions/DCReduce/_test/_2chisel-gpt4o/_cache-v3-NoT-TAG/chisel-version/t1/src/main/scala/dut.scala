import chisel3._
import chisel3.util._
import chisel.lib.dclib._

class dut[D <: Data](data: D, n: Int, op: (D, D) => D) extends Module {
  require(n >= 2, "The number of inputs (n) must be at least 2.")
  val io = IO(new Bundle {
    val a = Vec(n, Flipped(Decoupled(data.cloneType))) // Input Vector
    val z = Decoupled(data.cloneType)                // Output
  })

  // Task 1: Initialize Internal Interfaces
  val aInt = VecInit(io.a.map(a => DCInput(a)))           // Registered inputs
  val zInt = Wire(Decoupled(data.cloneType))              // Intermediate decoupled output

  // Task 2: Generate Validation Signal
  val all_valid = aInt.map(_.valid).reduce(_ && _)        // Combined valid signal for inputs

  // Task 3: Implement Reduction Logic
  zInt.bits := aInt.map(_.bits).reduce(op)                // Reduce input bits using the binary operator

  // Task 4: Control Flow Logic
  when(all_valid && zInt.ready) {
    zInt.valid := true.B                                 // Output valid when all inputs are valid and ready
    aInt.foreach(_.ready := true.B)                      // Set all input ready signals
  }.otherwise {
    zInt.valid := false.B                                // Otherwise output is not valid
    aInt.foreach(_.ready := false.B)                     // Set all input ready signals to false
  }

  // Task 5: Output Registration
  val zDcout = DCOutput(zInt)                            // Wrap intermediate output for registered timing
  io.z <> zDcout                                         // Connect to module's output port
}

