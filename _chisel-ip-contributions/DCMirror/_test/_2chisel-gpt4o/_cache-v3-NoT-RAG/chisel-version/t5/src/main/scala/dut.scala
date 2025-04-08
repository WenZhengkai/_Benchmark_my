import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, n: Int) extends Module {
  val io = IO(new Bundle {
    val dst = Input(UInt(n.W))
    val c = Flipped(Decoupled(data.cloneType))
    val p = Vec(n, Decoupled(data.cloneType))
  })

  // -----------------------
  // Task 1: Define Registers and Signals
  // -----------------------
  // Define a register to store the incoming data payload
  val pData = Reg(data.cloneType)

  // Define a register to track the valid status of each output channel
  val pValid = RegInit(0.U(n.W))

  // Create a signal to represent the readiness of all output channels
  val pReady = Wire(Vec(n, Bool()))
  for (i <- 0 until n) {
    pReady(i) := io.p(i).ready
  }

  // Compute the next accept signal: when the module can accept new data
  val nxtAccept = Wire(Bool())
  nxtAccept := (pValid === 0.U) || (pValid & ~pReady.asUInt) === 0.U

  // ------------------------
  // Task 2: Implement Data Register (`pData`)
  // ------------------------
  when(nxtAccept) {
    pData := io.c.bits // Update pData with new payload when ready to accept
  }

  // ------------------------
  // Task 3: Implement Valid Register (`pValid`)
  // ------------------------
  when(nxtAccept) {
    // Set pValid according to the `dst` bits and the validity of incoming data
    pValid := Mux(io.c.valid, io.dst, 0.U)
  }.otherwise {
    // Retain data for channels that aren't ready using ~pReady mask
    pValid := pValid & ~pReady.asUInt
  }

  // ------------------------
  // Task 4: Compute the Next Accept Signal (`nxtAccept`)
  // ------------------------
  // (Already computed as part of Task 1)

  // ------------------------
  // Task 5: Assign Outputs
  // ------------------------
  for (i <- 0 until n) {
    // Drive the valid signal using the corresponding bit in `pValid`
    io.p(i).valid := pValid(i)

    // Assign the data payload from `pData`
    io.p(i).bits := pData

    // Connect the ready signal from `io.p` to `pReady` (already done earlier)
  }

  // ------------------------
  // Task 6: Integrate Flow Control
  // ------------------------
  // Drive the ready signal from `io.c` based on `nxtAccept`
  io.c.ready := nxtAccept
}