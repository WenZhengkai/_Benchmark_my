import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, n: Int) extends Module {
  val io = IO(new Bundle {
    val dst = Input(UInt(n.W))                           // Destination bit vector
    val c   = Flipped(DecoupledIO(data.cloneType))       // Input channel (DecoupledIO)
    val p   = Vec(n, DecoupledIO(data.cloneType))        // Output channels (DecoupledIO)
  })

  // *** Task 1: Define Registers and Signals ***
  val pData = Reg(data.cloneType)                        // Data register
  val pValid = RegInit(0.U(n.W))                         // Valid register (tracks active output channels)
  val pReady = Wire(Vec(n, Bool()))                      // Signal for output readiness
  val nxtAccept = Wire(Bool())                           // Signal to determine if new data can be accepted

  // *** Task 2: Implement Data Register (pData) ***
  when(nxtAccept && io.c.fire()) {                       // Update pData if new data is being accepted
    pData := io.c.bits
  }

  // *** Task 3: Implement Valid Register (pValid) ***
  when(nxtAccept) {                                      // When accepting new data:
    when(io.c.valid) {                                   // If input data is valid:
      pValid := io.dst                                   // Set pValid to match active bits in dst
    }.otherwise {
      pValid := 0.U                                      // Otherwise, clear pValid
    }
  }.otherwise {                                          // Retain valid bits for outputs not ready
    pValid := pValid & ~pReady.asUInt
  }

  // *** Task 4: Compute the Next Accept Signal (nxtAccept) ***
  // nxtAccept is true if there is no valid data or all valid data has been accepted
  nxtAccept := (pValid === 0.U) || (pValid & ~pReady.asUInt) === 0.U

  // *** Task 5: Assign Outputs ***
  for (i <- 0 until n) {
    io.p(i).valid := pValid(i)                           // Output channel valid signal follows pValid
    io.p(i).bits := pData                                // Output channel data is driven by pData
    pReady(i) := io.p(i).ready                           // Output readiness is passed through to pReady
  }

  // *** Task 6: Integrate Flow Control ***
  // Input ready depends on nxtAccept
  io.c.ready := nxtAccept                               // Only accept input when nxtAccept is true
}