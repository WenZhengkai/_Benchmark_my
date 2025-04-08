import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, n: Int) extends Module {
  val io = IO(new Bundle {
    val dst = Input(UInt(n.W))                       // Bit vector specifying active outputs
    val c = Flipped(DecoupledIO(data.cloneType))     // Input channel
    val p = Vec(n, DecoupledIO(data.cloneType))      // Output channels as a vector
  })

  // Task 1: Define Registers and Signals
  val pData = Reg(data.cloneType)                    // Register to store incoming data payload
  val pValid = RegInit(0.U(n.W))                     // Register to track which outputs hold valid data (initialized to 0)
  val pReady = Wire(UInt(n.W))                       // Signal to represent readiness of all outputs
  val nxtAccept = Wire(Bool())                       // Signal to determine when to accept new input

  // Task 2: Implement Data Register (`pData`)
  when (nxtAccept && io.c.valid) {                   // Update data register when module accepts new data
    pData := io.c.bits
  }

  // Task 3: Implement Valid Register (`pValid`)
  pReady := Cat(io.p.map(_.ready).reverse)           // Compute readiness vector from output "ready" signals
  when (nxtAccept) {                                 // Update valid register when module accepts new data
    pValid := io.dst & Fill(n, io.c.valid)           // Set valid bits based on `dst` and input validity
  } .otherwise {
    pValid := pValid & ~pReady                       // Retain valid bits for outputs that are not ready
  }

  // Task 4: Compute the Next Accept Signal (`nxtAccept`)
  nxtAccept := (pValid === 0.U) || (pValid & ~pReady) === 0.U
                                                  // Accept new data when no valid data is registered,
                                                  // or all valid data has been accepted

  // Task 5: Assign Outputs
  for (i <- 0 until n) {
    io.p(i).valid := pValid(i)                       // Drive `valid` signal for each output channel
    io.p(i).bits := pData                            // Assign `bits` (data payload) to each active output
  }
  io.c.ready := nxtAccept                            // Ready signal to input channel depends on `nxtAccept`

  // Task 6: Integrate Flow Control
  // Flow control logic is inherently embedded in the use of `nxtAccept`, `pValid`, and `pReady` signals
}