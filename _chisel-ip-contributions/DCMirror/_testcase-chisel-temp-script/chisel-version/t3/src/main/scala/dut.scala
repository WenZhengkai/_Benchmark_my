import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, n: Int) extends Module {
  val io = IO(new Bundle {
    val dst = Input(UInt(n.W))                         // Input bit vector indicating active outputs
    val c   = Flipped(DecoupledIO(data.cloneType))     // Input channel for the data payload
    val p   = Vec(n, DecoupledIO(data.cloneType))      // Output channels for the destinations
  })

  // Task 1: Registers and Signals
  val pData   = Reg(data.cloneType)                   // Register to hold the data payload
  val pValid  = RegInit(0.U(n.W))                     // Valid register to track active outputs
  val pReady  = Wire(UInt(n.W))                       // Ready signal vector for all outputs
  val nxtAccept = Wire(Bool())                        // Signal to determine when to accept new data

  // Task 2: Implement Data Register (`pData`)
  when(nxtAccept) {
    pData := io.c.bits                               // Update pData when new data is accepted
  }

  // Task 3: Implement Valid Register (`pValid`)
  when(nxtAccept) {
    // Set valid bits for active outputs based on `dst` when accepting new data
    pValid := Mux(io.c.valid, io.dst, 0.U)
  } .elsewhen(pValid =/= 0.U) {
    // Retain valid bits for outputs that aren't ready, mask with ~pReady
    pValid := pValid & ~pReady
  }

  // Task 4: Compute the Next Accept Signal (`nxtAccept`)
  // nxtAccept is true if no valid data is stored or all valid output data has been accepted
  nxtAccept := (pValid === 0.U) || (pValid & ~pReady) === 0.U

  // Task 5: Assign Outputs
  for (i <- 0 until n) {
    io.p(i).valid := pValid(i)                        // Drive `valid` signal based on `pValid`
    io.p(i).bits  := pData                            // Assign data payload from `pData`
    pReady(i)      := io.p(i).ready                   // Update ready signal from corresponding output
  }

  // Task 6: Integrate Flow Control
  io.c.ready := nxtAccept                            // Input is ready when nxtAccept is true
}