import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, n: Int) extends Module {
  val io = IO(new Bundle {
    val dst = Input(UInt(n.W))  // Destination bit vector
    val c = Flipped(Decoupled(data.cloneType))  // Input channel with Ready/Valid
    val p = Vec(n, Decoupled(data.cloneType))  // Output channels
  })

  // ------------------------------------------
  // Task 1: Define Registers and Signals
  // ------------------------------------------

  // Data register to store the payload
  val pData = RegInit(0.U.asTypeOf(data.cloneType))

  // Valid register to track active output channels
  val pValid = RegInit(0.U(n.W))

  // Ready vector signal from all outputs
  val pReady = Wire(Vec(n, Bool()))

  // Compute `nxtAccept`: When the module can accept new data
  val nxtAccept = Wire(Bool())

  // ------------------------------------------
  // Task 2: Implement Data Register (`pData`)
  // ------------------------------------------

  when(nxtAccept) {
    pData := io.c.bits
  }

  // ------------------------------------------
  // Task 3: Implement Valid Register (`pValid`)
  // ------------------------------------------

  when(nxtAccept) {
    // Set pValid based on `dst` and `io.c.valid`
    pValid := Mux(io.c.valid, io.dst & Fill(n, true.B), 0.U)
  } .otherwise {
    // Retain valid bits for outputs that aren't ready
    pValid := pValid & ~pReady.asUInt
  }

  // ------------------------------------------
  // Task 4: Compute the Next Accept Signal (`nxtAccept`)
  // ------------------------------------------

  // `nxtAccept` is true when either:
  // - No outputs are currently holding valid data (`pValid === 0.U`), or
  // - All currently valid data has been accepted by their respective outputs
  nxtAccept := (pValid === 0.U) || (pValid & ~pReady.asUInt) === 0.U

  // ------------------------------------------
  // Task 5: Assign Outputs
  // ------------------------------------------

  // Drive the outputs
  for (i <- 0 until n) {
    // Valid signal is asserted if the corresponding bit in `pValid` is set
    io.p(i).valid := pValid(i)

    // Data payload is broadcast to all outputs
    io.p(i).bits := pData

    // Collect the `ready` signal for this output
    pReady(i) := io.p(i).ready
  }

  // ------------------------------------------
  // Task 6: Integrate Flow Control
  // ------------------------------------------

  // Drive the `ready` signal for the input channel
  // The module is ready to accept new data when `nxtAccept` is true
  io.c.ready := nxtAccept
}