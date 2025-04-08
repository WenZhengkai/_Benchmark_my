import chisel3._
import chisel3.util._
import chisel.lib.dclib._

class dut[D <: Data](data: D, n: Int, op: (D, D) => D) extends Module {
  require(n >= 2, "The dut module requires at least two inputs.")

  val io = IO(new Bundle {
    val a = Vec(n, Flipped(Decoupled(data.cloneType))) // Input ports
    val z = Decoupled(data.cloneType)                 // Output port
  })

  // Task 1: Initialize Internal Interfaces
  // Wrap inputs using DCInput and create a wire for intermediate output
  val aInt = VecInit(io.a.map(a => DCInput(a)))        // Registered inputs
  val zInt = Wire(Decoupled(data.cloneType))           // Intermediate decoupled output

  // Task 2: Generate Validation Signal
  // Combine all input valid signals
  val all_valid = aInt.map(_.valid).reduce(_ && _)

  // Task 3: Implement Reduction Logic
  // Perform reduction operation and assign result to zInt.bits
  zInt.bits := aInt.map(_.bits).reduce(op)

  // Task 4: Control Flow Logic
  // Manage handshake signals for ready/valid flow
  when(all_valid && zInt.ready) {                      // When all inputs are valid and output is ready
    zInt.valid := true.B                               // Set intermediate output valid
    aInt.foreach(_.ready := true.B)                   // Set all inputs ready
  }.otherwise {                                        // Otherwise
    zInt.valid := false.B                              // Set intermediate output invalid
    aInt.foreach(_.ready := false.B)                  // Set all inputs not ready
  }

  // Task 5: Output Registration
  // Wrap intermediate output with DCOutput (registered output) and connect to module output
  val zDcout = DCOutput(zInt)
  io.z <> zDcout
}

// Example Usage
