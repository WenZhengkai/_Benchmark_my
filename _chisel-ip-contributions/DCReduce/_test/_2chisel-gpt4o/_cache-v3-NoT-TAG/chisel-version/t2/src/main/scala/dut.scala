import chisel3._
import chisel3.util._
import chisel.lib.dclib._

/**
 * dut Module
 *
 * A Chisel-based hardware module that performs a reduction operation on multiple decoupled inputs
 * using a user-specified binary operator and outputs the result using decoupled handshaking.
 * The module uses registered output timing.
 */
class dut[D <: Data](data: D, n: Int, op: (D, D) => D) extends Module {
  require(n >= 2, "The number of inputs (n) must be at least 2")

  val io = IO(new Bundle {
    val a = Vec(n, Flipped(Decoupled(data.cloneType))) // Input ports
    val z = Decoupled(data.cloneType)                 // Output port
  })

  // Task 1: Initialize Internal Interfaces
  // Create registered inputs and output wire infrastructure
  val aInt = VecInit(io.a.map(a => DCInput(a)))       // Wrap inputs using DCInput
  val zInt = Wire(Decoupled(data.cloneType))          // Internal wire for reduction result

  // Task 2: Generate Validation Signal
  // Create a combined valid signal indicating whether all inputs are valid
  val all_valid = aInt.map(_.valid).reduce(_ && _)

  // Task 3: Implement Reduction Logic
  // Perform tree reduction on input bits using the provided binary operator
  zInt.bits := aInt.map(_.bits).reduce(op)

  // Task 4: Control Flow Logic
  // Manage handshaking and data flow signals
  when(all_valid && zInt.ready) {
    zInt.valid := true.B                             // Set output valid when all inputs are valid
    aInt.foreach(_.ready := true.B)                 // Set inputs ready for new data
  }.otherwise {
    zInt.valid := false.B                            // Output not valid
    aInt.foreach(_.ready := false.B)                // Inputs not ready
  }

  // Task 5: Output Registration
  // Wrap intermediate wire using DCOutput for registered output
  val zDcout = DCOutput(zInt)
  io.z <> zDcout                                    // Connect internal output to IO output
}

