import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, n: Int) extends Module {
  require(n > 0, "Number of output destinations 'n' must be greater than zero")

  val io = IO(new Bundle {
    val dst = Input(UInt(n.W)) // Bit vector to determine active output channels
    val c = Flipped(Decoupled(data.cloneType)) // Input channel for data payload
    val p = Vec(n, Decoupled(data.cloneType)) // Output channels
  })

  // Register to hold data payload
  val pData = Reg(data.cloneType)

  // Register to track valid status of each output
  val pValid = RegInit(0.U(n.W)) // Starts with no outputs valid

  // Ready vector concatenated from individual output ready signals
  val pReady = VecInit(io.p.map(_.ready)).asUInt()

  // Next accept signal: true if no valid data (`pValid` empty) or if all current valid channels are accepted
  val nxtAccept = (pValid === 0.U) || ((pValid & ~pReady) === 0.U)

  // Update pValid and pData: latch incoming data when nxtAccept is true
  when(nxtAccept) {
    // Only set valid bits for outputs specified in `dst` that match when input is valid
    pValid := Mux(io.c.valid, io.dst, 0.U)
    pData := io.c.bits
  }.otherwise {
    // Clear valid bits for outputs that have been accepted
    pValid := pValid & ~pReady
  }

  // Backpressure handling for input channel (ready signal)
  io.c.ready := nxtAccept

  // Output logic: Assign valid and bits for each output channel
  for (i <- 0 until n) {
    io.p(i).valid := pValid(i)
    io.p(i).bits := pData
  }
}
