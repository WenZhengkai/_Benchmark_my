import chisel3._
import chisel3.util._
import chisel.lib.dclib._

class dut[D <: Data](data: D, n: Int, op: (D, D) => D) extends Module {
  require(n >= 2, "dut module requires at least two inputs (`n >= 2`).")
  
  val io = IO(new Bundle {
    val a = Vec(n, Flipped(Decoupled(data.cloneType))) // Input ports
    val z = Decoupled(data.cloneType)                 // Output port
  })

  // === Task 1: Initialize Internal Interfaces ===

  // Wrap each input using DCInput wrapper
  val aInt = VecInit(io.a.map(a => DCInput(a)))
  // Create intermediate decoupled output wire
  val zInt = Wire(Decoupled(data.cloneType))

  // === Task 2: Generate Validation Signal ===

  // Generate `all_valid` signal by combining valid signals from all inputs
  val all_valid = aInt.map(_.valid).reduce(_ && _)

  // === Task 3: Implement Reduction Logic ===

  // Perform tree reduction on input data using the provided binary operator `op`
  zInt.bits := aInt.map(_.bits).reduce(op)

  // === Task 4: Control Flow Logic ===

  // Manage handshaking signals to control `valid` and `ready` states
  when(all_valid && zInt.ready) {
    zInt.valid := true.B
    aInt.foreach(_.ready := true.B)
  }.otherwise {
    zInt.valid := false.B
    aInt.foreach(_.ready := false.B)
  }

  // === Task 5: Output Registration ===

  // Wrap the intermediate wire with DCOutput wrapper
  val zDcout = DCOutput(zInt)
  // Connect the registered output to the module's output interface
  io.z <> zDcout
}

// === Example Usage ===

