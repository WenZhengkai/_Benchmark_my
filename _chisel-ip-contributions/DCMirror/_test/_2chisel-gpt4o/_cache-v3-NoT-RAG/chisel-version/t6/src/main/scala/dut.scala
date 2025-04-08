import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, n: Int) extends Module {
  val io = IO(new Bundle {
    val dst = Input(UInt(n.W))
    val c   = Flipped(DecoupledIO(data.cloneType))
    val p   = Vec(n, DecoupledIO(data.cloneType))
  })

  // Task 1: Define Registers and Signals
  // Register to store the incoming data payload
  val pData    = Reg(data.cloneType)
  // Register to track which output channels are holding valid data
  val pValid   = RegInit(0.U(n.W))
  // Wire to compute the readiness vector of all output channels
  val pReady   = Wire(Vec(n, Bool()))
  // Signal to determine when the module can accept new data
  val nxtAccept = Wire(Bool())

  // Task 2: Implement Data Register (pData)
  // Update pData when the module is ready to accept new data
  when(nxtAccept) {
    pData := io.c.bits
  }

  // Task 3: Implement Valid Register (pValid)
  when(nxtAccept) {
    // When accepting new data, set pValid based on the active `dst` bits and `io.c.valid`
    pValid := io.dst & Fill(n, io.c.valid)
  }.otherwise {
    // Retain valid bits for outputs that aren't ready
    pValid := pValid & ~VecInit(pReady).asUInt
  }

  // Task 4: Compute the Next Accept Signal (nxtAccept)
  // Accept new data if no data is valid (`pValid === 0.U`) or all valid data has been accepted
  nxtAccept := (pValid === 0.U) || (pValid & ~VecInit(pReady).asUInt) === 0.U

  // Task 5: Assign Outputs
  for (i <- 0 until n) {
    // Drive the ready signal vector from each output channel
    pReady(i) := io.p(i).ready

    // Drive the valid signal for each output channel based on pValid
    io.p(i).valid := pValid(i)
    // Assign the data bits to each output channel
    io.p(i).bits := pData
  }

  // Task 6: Integrate Flow Control
  // Propagate the ready signal using nxtAccept
  io.c.ready := nxtAccept
}