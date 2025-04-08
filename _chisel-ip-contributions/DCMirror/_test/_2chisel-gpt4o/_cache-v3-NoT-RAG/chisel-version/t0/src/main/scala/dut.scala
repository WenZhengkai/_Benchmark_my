import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, n: Int) extends Module {
  val io = IO(new Bundle {
    val dst = Input(UInt(n.W))                    // Bit vector indicating active output channels
    val c   = Flipped(Decoupled(data))            // Input channel with ready/valid interface
    val p   = Vec(n, Decoupled(data))             // Output channels with ready/valid interface
  })

  // Task 1: Define Registers and Signals
  val pData   = Reg(data.cloneType)               // Data register for captured payload
  val pValid  = RegInit(0.U(n.W))                 // Valid register (tracks valid outputs)
  val pReady  = Wire(Vec(n, Bool()))              // Ready vector (tracks ready signals of outputs)
  val nxtAccept = Wire(Bool())                    // Signal to determine when new data can be accepted

  // Task 2: Implement Data Register (pData)
  when (nxtAccept) {
    pData := io.c.bits                            // Update pData with incoming payload when nxtAccept is true
  }

  // Task 3: Implement Valid Register (pValid)
  when (nxtAccept) {
    // Set pValid based on the active bits in `dst` and input `c.valid`
    pValid := Mux(io.c.valid, io.dst, 0.U)
  } .otherwise {
    // Retain valid bits for outputs not ready by masking with ~pReady
    pValid := pValid & ~VecInit(pReady).asUInt
  }

  // Task 4: Compute the Next Accept Signal (nxtAccept)
  // nxtAccept is true when no valid data is held or when currently valid data has been accepted
  nxtAccept := (pValid === 0.U) || (pValid & ~VecInit(pReady).asUInt) === 0.U

  // Task 5: Assign Outputs
  for (i <- 0 until n) {
    io.p(i).valid := pValid(i)                    // Drive the valid signal of each output
    io.p(i).bits  := pData                        // Assign the same data payload to all outputs
    pReady(i) := io.p(i).ready                    // Capture the ready signal of each output
  }

  // Task 6: Integrate Flow Control
  // Drive the ready signal on the input based on the nxtAccept logic
  io.c.ready := nxtAccept
}
