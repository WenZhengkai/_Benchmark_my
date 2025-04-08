import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, n: Int) extends Module {
  val io = IO(new Bundle {
    val dst = Input(UInt(n.W))                          // Bit vector of output destinations
    val c = Flipped(DecoupledIO(data.cloneType))        // Input DecoupledIO interface
    val p = Vec(n, DecoupledIO(data.cloneType))         // Output Vec of DecoupledIO interfaces
  })

  // Task 1: Define Registers and Signals
  val pData = Reg(data.cloneType)                      // Register to hold the incoming data
  val pValid = RegInit(0.U(n.W))                       // Valid register for the outputs
  val pReady = Wire(Vec(n, Bool()))                    // Signal for readiness of all outputs
  val nxtAccept = Wire(Bool())                         // Signal to determine when the module can accept new data

  // Connect `pReady` to the output ready signals
  pReady := io.p.map(_.ready)

  // Task 2: Implement Data Register (`pData`)
  when(nxtAccept) {
    pData := io.c.bits                                  // Update `pData` when new data is accepted
  }

  // Task 3: Implement Valid Register (`pValid`)
  when(nxtAccept) {
    pValid := Mux(io.c.valid, io.dst, 0.U)             // Update `pValid` when accepting new data
  }.otherwise {
    // Retain valid bits for outputs that aren't ready
    pValid := pValid & ~pReady.asUInt                   // Mask out bits that are ready
  }

  // Task 4: Compute the Next Accept Signal (`nxtAccept`)
  nxtAccept := (pValid === 0.U) || (pValid & pReady.asUInt) === pValid

  // Task 5: Assign Outputs
  for (i <- 0 until n) {
    io.p(i).valid := pValid(i)                          // Connect the `valid` signal
    io.p(i).bits := pData                               // Assign the payload
  }

  // Task 6: Integrate Flow Control
  io.c.ready := nxtAccept                               // Input is ready when `nxtAccept` is true
}