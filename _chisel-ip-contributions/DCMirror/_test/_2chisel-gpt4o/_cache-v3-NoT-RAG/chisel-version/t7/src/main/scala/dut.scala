import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, n: Int) extends Module {
  val io = IO(new Bundle {
    val dst = Input(UInt(n.W)) // Destination bit vector
    val c   = Flipped(Decoupled(data.cloneType)) // Input channel
    val p   = Vec(n, Decoupled(data.cloneType)) // Output channels
  })

  // Task 1: Define Registers and Signals
  val pData     = Reg(data.cloneType) // Register to store payload data
  val pValid    = RegInit(0.U(n.W)) // Register to track valid bits per output (initialized to 0)
  val pReady    = Wire(Vec(n, Bool())) // Signal for ready vector from output destinations
  val nxtAccept = Wire(Bool()) // Signal for when the module can accept new data

  // Task 2: Implement Data Register (pData)
  when(nxtAccept) {
    pData := io.c.bits
  }

  // Task 3: Implement Valid Register (pValid)
  when(nxtAccept) {
    // Update valid bits based on `dst` and `io.c.valid`
    pValid := Mux(io.c.valid, io.dst, 0.U)
  } .otherwise {
    // Retain valid bits for outputs that are not ready
    pValid := pValid & ~VecInit(pReady).asUInt
  }

  // Task 4: Compute the Next Accept Signal (nxtAccept)
  nxtAccept := (pValid === 0.U) || (pValid & VecInit(pReady).asUInt) === pValid

  // Task 5: Assign Outputs
  for (i <- 0 until n) {
    io.p(i).valid := pValid(i) // Output valid signal
    io.p(i).bits  := pData // Output payload data
    pReady(i)     := io.p(i).ready // Map output ready signals
  }

  // Task 6: Integrate Flow Control
  io.c.ready := nxtAccept // Allow new input when next accept signal is true
}