import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, n: Int) extends Module {
  val io = IO(new Bundle {
    val dst = Input(UInt(n.W)) // Control vector for active output destinations
    val c = Flipped(DecoupledIO(data.cloneType)) // Input channel
    val p = Vec(n, DecoupledIO(data.cloneType))  // Output channels
  })

  // Task 1: Define Registers and Signals
  val pData = Reg(data.cloneType)            // Register to hold incoming data
  val pValid = RegInit(0.U(n.W))             // Tracks valid status for output channels
  val pReady = Wire(UInt(n.W))               // Readiness vector of all outputs
  val nxtAccept = Wire(Bool())               // Signal to determine acceptance of new data

  // Task 2: Implement Data Register (pData)
  when (nxtAccept) {
    pData := io.c.bits
  }

  // Task 3: Implement Valid Register (pValid)
  pValid := Mux(
    nxtAccept,
    Mux(io.c.valid, io.dst, 0.U),                  // Update pValid when nxtAccept is true
    pValid & ~pReady                               // Retain valid bits for outputs not yet ready
  )

  // Task 4: Compute Next Accept Signal (nxtAccept)
  nxtAccept := (pValid === 0.U) || (pValid & pReady) === pValid // Allows new data when old data is fully accepted

  // Task 5: Assign Outputs
  for (i <- 0 until n) {
    io.p(i).valid := pValid(i)                     // Set valid signal for each output
    io.p(i).bits := pData                          // Assign payload from pData register
    pReady := Cat(io.p.map(_.ready).reverse)       // Collect all output readiness into pReady
  }

  // Task 6: Integrate Flow Control
  io.c.ready := nxtAccept                          // Input ready when module accepts new data
}
