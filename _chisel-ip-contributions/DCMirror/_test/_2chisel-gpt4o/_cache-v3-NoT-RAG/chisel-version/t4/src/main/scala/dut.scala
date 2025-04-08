import chisel3._
import chisel3.util._

/**
 * dut Module: Distributes tokens (data payloads) to multiple output destinations.
 * 
 * @param data defines the type of the payload (`D <: Data`).
 * @param n    number of output channels (width of the `dst` bit vector).
 */
class dut[D <: Data](data: D, n: Int) extends Module {
  val io = IO(new Bundle {
    val dst = Input(UInt(n.W))                   // Bit vector specifying active output channels
    val c = Flipped(Decoupled(data.cloneType))   // Input channel with DecoupledIO interface
    val p = Vec(n, Decoupled(data.cloneType))    // Output channels (array of DecoupledIO)
  })

  // === Task 1: Define Registers and Signals ===
  val pData = Reg(data.cloneType)                // Data register to store incoming payload
  val pValid = RegInit(0.U(n.W))                 // Valid register to track active output channels
  val pReady = Wire(Vec(n, Bool()))              // Signal to capture readiness of each output
  val nxtAccept = Wire(Bool())                   // Signal to determine if new data can be accepted

  // === Task 2: Implement Data Register (`pData`) ===
  when (nxtAccept) {                             // Update data register when module accepts new data
    pData := io.c.bits
  }

  // === Task 3: Implement Valid Register (`pValid`) ===
  when (nxtAccept) {                             // Update valid bits on new data acceptance
    pValid := Mux(io.c.valid, io.dst, 0.U)       // Set valid outputs based on `dst` and `io.c.valid`
  } .otherwise {
    pValid := pValid & ~pReady.asUInt            // Clear valid bits for outputs that are ready
  }

  // === Task 4: Compute the Next Accept Signal (`nxtAccept`) ===
  nxtAccept := (pValid === 0.U) ||               // Accept new data if no outputs are currently valid, OR
               (pValid & pReady.asUInt) === pValid // All current valid outputs have been accepted

  // === Task 5: Assign Outputs ===
  for (i <- 0 until n) {
    io.p(i).valid := pValid(i)                   // Drive valid signal based on pValid
    io.p(i).bits := pData                        // All outputs share the same payload data
    pReady(i) := io.p(i).ready                   // Capture readiness from each output
  }

  // === Task 6: Integrate Flow Control ===
  io.c.ready := nxtAccept                        // Indicate readiness to accept new data from input
}