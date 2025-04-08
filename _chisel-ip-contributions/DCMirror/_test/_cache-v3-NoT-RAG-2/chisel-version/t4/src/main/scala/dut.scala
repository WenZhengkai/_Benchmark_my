import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, n: Int) extends Module {
  val io = IO(new Bundle {
    val dst = Input(UInt(n.W))                         // Bit vector to select active outputs
    val c = Flipped(DecoupledIO(data.cloneType))       // Input payload channel (DecoupledIO)
    val p = Vec(n, DecoupledIO(data.cloneType))        // Array of output payload channels
  })

  // Task 1: Define Registers and Signals
  val pData = Reg(data.cloneType)                     // Register to store payload data
  val pValid = RegInit(0.U(n.W))                      // Register to track valid outputs
  val pReady = Wire(UInt(n.W))                        // Signal for output readiness
  val nxtAccept = Wire(Bool())                        // Signal to determine when to accept new data

  // Task 2: Implement Data Register (pData)
  when(nxtAccept) {                                   // Update data register when accepting new data
    pData := io.c.bits
  }

  // Task 3: Implement Valid Register (pValid)
  when(nxtAccept) {
    // Set valid bits for active destinations in `dst` when new data is accepted
    pValid := io.dst & Fill(n, io.c.valid)
  } .otherwise {
    // Retain valid bits for destinations that are not yet ready
    pValid := pValid & ~pReady
  }

  // Task 4: Compute the Next Accept Signal (nxtAccept)
  nxtAccept := (pValid === 0.U) || (pValid & pReady === pValid)

  // Task 5: Assign Outputs
  for (i <- 0 until n) {
    io.p(i).valid := pValid(i)                        // Drive valid signal from pValid register
    io.p(i).bits := pData                             // Drive payload data from pData register
    pReady(i) := io.p(i).ready                        // Capture readiness of each output
  }

  // Task 6: Integrate Flow Control
  io.c.ready := nxtAccept                             // Input channel ready when module can accept new data
}