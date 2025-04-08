import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, n: Int) extends Module {
  val io = IO(new Bundle {
    val dst = Input(UInt(n.W))                               // Active output channels
    val c = Flipped(DecoupledIO(data.cloneType))             // Input channel
    val p = Vec(n, DecoupledIO(data.cloneType))              // Output channels
  })

  // ====================================================================
  // Task 1: Define Registers and Signals
  // ====================================================================
  val pData = Reg(data.cloneType)                            // Holds the current data payload
  val pValid = RegInit(0.U(n.W))                             // Validity of each output channel
  val pReady = Wire(UInt(n.W))                               // Readiness of all output channels as a vector
  val nxtAccept = Wire(Bool())                               // Signal for accepting new data

  for (i <- 0 until n) {
    pReady(i) := io.p(i).ready                               // Aggregate `ready` signals from all outputs
  }

  // ====================================================================
  // Task 2: Implement Data Register (pData)
  // ====================================================================
  when(nxtAccept) {                                          // Update data register if new data is accepted
    pData := io.c.bits
  }

  // ====================================================================
  // Task 3: Implement Valid Register (pValid)
  // ====================================================================
  when(nxtAccept) {
    pValid := io.dst & Fill(n, io.c.valid)                   // Set valid bits based on `dst` and `io.c.valid`
  }.otherwise {
    pValid := pValid & ~pReady                               // Retain only outputs that aren't ready
  }

  // ====================================================================
  // Task 4: Compute the Next Accept Signal (nxtAccept)
  // ====================================================================
  nxtAccept := (pValid === 0.U) || (pValid & pReady) === pValid

  // ====================================================================
  // Task 5: Assign Outputs
  // ====================================================================
  for (i <- 0 until n) {
    io.p(i).valid := pValid(i)                               // Drive `valid` from the `pValid` register
    io.p(i).bits := pData                                    // Drive `bits` with the payload
  }

  io.c.ready := nxtAccept                                    // Drive `io.c.ready` based on `nxtAccept`

  // ====================================================================
  // Task 6: Integrate Flow Control
  // ====================================================================
  // No additional steps needed as flow control is already integrated
  // through the interaction of `pValid`, `pReady`, and `nxtAccept`.

  // Ensure robust handling of corner cases
  assert(io.dst.orR, "At least one `dst` bit must be set.") // Ensure `dst` is non-zero for valid operation
}