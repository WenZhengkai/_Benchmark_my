import chisel3._
import chisel3.util._
import chisel.lib.dclib._

class dut[D <: Data](data: D, n: Int, op: (D, D) => D) extends Module {
  require(n >= 2, "The module requires at least two inputs (n >= 2)")

  // Input/Output Declarations
  val io = IO(new Bundle {
    val a = Vec(n, Flipped(Decoupled(data.cloneType))) // Input vector of n decoupled inputs
    val z = Decoupled(data.cloneType)                 // Decoupled output
  })

  // *** Task 1: Initialize Internal Interfaces ***
  // Create `aInt` vector of registered inputs using DCInput
  val aInt = VecInit(io.a.map(a => DCInput(a)))

  // Create intermediate decoupled output wire
  val zInt = Wire(Decoupled(data.cloneType))

  // *** Task 2: Generate Validation Signal ***
  // Combine valid signals from all inputs using AND
  val all_valid = aInt.map(_.valid).reduce(_ && _)

  // *** Task 3: Implement Reduction Logic ***
  // Perform reduction on input bits using the binary operator `op`
  zInt.bits := aInt.map(_.bits).reduce(op)

  // *** Task 4: Control Flow Logic ***
  // Manage handshaking signals for valid and ready
  zInt.valid := false.B
  aInt.foreach(_.ready := false.B)

  when(all_valid && zInt.ready) {
    zInt.valid := true.B
    aInt.foreach(_.ready := true.B)
  }

  // *** Task 5: Output Registration ***
  // Register the result using DCOutput and connect to module's output
  val zDcout = DCOutput(zInt)
  io.z <> zDcout
}

// Companion object to test the dut module
