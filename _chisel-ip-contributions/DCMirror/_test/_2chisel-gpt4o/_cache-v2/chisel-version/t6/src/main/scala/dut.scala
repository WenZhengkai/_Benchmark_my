import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, n: Int) extends Module {
  val io = IO(new Bundle {
    val dst = Input(UInt(n.W))             // Control bit vector for active outputs
    val c = Flipped(Decoupled(data))       // Input channel
    val p = Vec(n, Decoupled(data.cloneType)) // Output channels
  })

  // Internal registers
  val pData = Reg(data.cloneType)         // Register to hold the incoming data
  val pValid = RegInit(0.U(n.W))          // Register to track valid output channels
  val pReady = Wire(UInt(n.W))            // Ready vector for all outputs

  // Compute next accept signal
  val nxtAccept = (pValid === 0.U) || (pValid & pReady) === pValid

  // Update pData and pValid
  when(nxtAccept) {
    when(io.c.valid) {
      pData := io.c.bits   // Store incoming data
      pValid := io.dst     // Set valid outputs according to dst
    }.otherwise {
      pValid := 0.U        // Clear valid if no incoming data
    }
  }.otherwise {
    pValid := pValid & ~pReady // Retain only non-ready valid outputs
  }

  // Define output logic
  for (i <- 0 until n) {
    io.p(i).bits := pData
    io.p(i).valid := pValid(i)
    pReady(i) := io.p(i).ready
  }

  // Determine input channel readiness
  io.c.ready := nxtAccept
}

