import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, n: Int) extends Module {
  val io = IO(new Bundle {
    val dst = Input(UInt(n.W))                          // Active output channels selection
    val c   = Flipped(DecoupledIO(data.cloneType))      // Input channel
    val p   = Vec(n, DecoupledIO(data.cloneType))       // Output channels
  })

  // Task 1: Define Registers and Signals
  // Register to hold incoming data
  val pData = Reg(data.cloneType)
  // Register to track valid status for output channels
  val pValid = RegInit(0.U(n.W))
  // Signal to represent readiness of all output channels
  val pReady = Wire(UInt(n.W))
  // Signal to determine when the module can accept new data
  val nxtAccept = Wire(Bool())

  // Task 2: Implement Data Register (`pData`)
  when(nxtAccept) {
    pData := io.c.bits  // Update `pData` with incoming data when accepting new data
  }

  // Task 3: Implement Valid Register (`pValid`)
  when(nxtAccept) {
    // Set `pValid` based on `dst` bits and input `valid`
    pValid := Mux(io.c.valid, io.dst, 0.U)
  }.otherwise {
    // Retain valid bits for outputs that aren't ready
    pValid := pValid & ~pReady
  }

  // Task 4: Compute the Next Accept Signal (`nxtAccept`)
  // Determine if the module can accept new data
  nxtAccept := (pValid === 0.U) || (pValid & pReady) === pValid

  // Task 5: Assign Outputs
  // Drive outputs based on registers and logic
  for (i <- 0 until n) {
    io.p(i).valid := pValid(i)   // Assign valid signal for each output
    io.p(i).bits := pData        // Assign data payload to each output
    pReady(i) := io.p(i).ready   // Gather readiness signals for all outputs
  }

  // Task 6: Integrate Flow Control
  // Drive input ready signal based on `nxtAccept`
  io.c.ready := nxtAccept
}