import chisel3._
import chisel3.util._
import chisel.lib.dclib._

class dut[D <: Data](data: D, n: Int, op: (D, D) => D) extends Module {
  require(n >= 2, "dut must have at least two inputs")

  // I/O Definitions
  val io = IO(new Bundle {
    val a = Vec(n, Flipped(Decoupled(data.cloneType)))
    val z = Decoupled(data.cloneType)
  })

  // Task 1: Initialize Internal Interfaces
  // Create registered input interfaces using DCInput
  val aInt = VecInit(io.a.map(a => DCInput(a)))

  // Create intermediate wire for internal computation
  val zInt = Wire(Decoupled(data.cloneType))

  // Task 2: Generate Validation Signal
  // Compute the `all_valid` signal by AND-ing all input valid signals
  val all_valid = aInt.map(_.valid).reduce(_ && _)

  // Task 3: Implement Reduction Logic
  // Use the provided binary operator to perform a reduction on the input data
  zInt.bits := aInt.map(_.bits).reduce(op)

  // Task 4: Control Flow Logic
  // Manage handshaking between inputs and output
  when(all_valid && zInt.ready) {
    zInt.valid := true.B
    aInt.foreach(_.ready := true.B)
  }.otherwise {
    zInt.valid := false.B
    aInt.foreach(_.ready := false.B)
  }

  // Task 5: Output Registration
  // Wrap internal output wire with DCOutput for registered output
  val zDcout = DCOutput(zInt)

  // Connect the registered output to the module's output port
  io.z <> zDcout
}
