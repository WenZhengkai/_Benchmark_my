import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, n: Int) extends Module {
  val io = IO(new Bundle {
    val dst  = Input(UInt(n.W)) // Bit vector for active output channels
    val c    = Flipped(DecoupledIO(data)) // Input channel for incoming data
    val p    = Vec(n, DecoupledIO(data))  // Output channels
  })

  // Task 1: Define Registers and Signals
  val pData = Reg(data.cloneType) // Register to hold the payload data
  val pValid = RegInit(0.U(n.W))  // Register to indicate valid output channels
  val pReady = Wire(Vec(n, Bool())) // Wire vector to represent output readiness
  val nxtAccept = Wire(Bool()) // Signal to indicate when new data can be accepted

  // Task 2: Implement Data Register (`pData`)
  when(nxtAccept) {
    pData := io.c.bits
  }

  // Task 3: Implement Valid Register (`pValid`)
  when(nxtAccept) {
    pValid := io.dst & Fill(n, io.c.valid) // Set valid bits based on dst and c.valid
  }.otherwise {
    pValid := pValid & ~pReady.asUInt // Mask out bits for outputs that are ready
  }

  // Task 4: Compute the Next Accept Signal (`nxtAccept`)
  nxtAccept := (pValid === 0.U) || (pValid & ~pReady.asUInt) === 0.U

  // Task 5: Assign Outputs
  for (i <- 0 until n) {
    // Drive `valid` signal
    io.p(i).valid := pValid(i)
    // Assign the data payload (same for all active outputs)
    io.p(i).bits := pData
    // Connect the `ready` signal to pReady
    pReady(i) := io.p(i).ready
  }

  // Task 6: Integrate Flow Control
  // Drive the input channel's `ready` signal
  io.c.ready := nxtAccept
}