import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, n: Int) extends Module {
  val io = IO(new Bundle {
    val dst = Input(UInt(n.W))                      // Destination bit vector
    val c = Flipped(DecoupledIO(data.cloneType))    // Input channel
    val p = Vec(n, DecoupledIO(data.cloneType))     // Output channels
  })

  // Internal registers and signals
  val pData = Reg(data.cloneType)                   // Register to store incoming payload
  val pValid = RegInit(0.U(n.W))                    // Validity register for output channels
  val pReady = Wire(UInt(n.W))                      // Ready vector for all output channels
  val nxtAccept = Wire(Bool())                      // Signal to determine acceptance of new data

  // Compute the next accept signal
  // `nxtAccept` is true when either no data is valid or all valid data has been accepted
  nxtAccept := (pValid === 0.U) || ((pValid & pReady) === pValid)

  // Data register: update only when `nxtAccept` is true and input is valid
  when(io.c.valid && nxtAccept) {
    pData := io.c.bits
  }

  // Valid register: update based on active destinations and ready signal
  when(nxtAccept) {
    pValid := Mux(io.c.valid, io.dst & Fill(n, 1.U(1.W)), 0.U)
  }.otherwise {
    // Keep valid bits for outputs that aren't ready
    pValid := pValid & ~pReady
  }

  // Drive outputs
  for (i <- 0 until n) {
    io.p(i).valid := pValid(i)                      // Output `valid` comes from `pValid`
    io.p(i).bits := pData                           // All outputs share the same `pData`
    pReady(i) := io.p(i).ready                      // Collect `ready` signals from outputs
  }

  // Drive input `ready` signal
  io.c.ready := nxtAccept                           // Ready to accept new data when `nxtAccept` is true
}
