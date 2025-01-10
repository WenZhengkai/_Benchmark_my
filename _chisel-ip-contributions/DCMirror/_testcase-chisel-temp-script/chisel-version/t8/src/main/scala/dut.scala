import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, n: Int) extends Module {
  require(n > 0, "Number of output destinations (n) must be greater than 0")

  val io = IO(new Bundle {
    val dst = Input(UInt(n.W))                     // `dst` bit vector for selecting active output channels
    val c = Flipped(Decoupled(data.cloneType))     // Input channel
    val p = Vec(n, Decoupled(data.cloneType))      // Output channels
  })

  // Register to hold the incoming data payload
  val pData = Reg(data.cloneType)

  // Register to track validity of outputs
  val pValid = RegInit(0.U(n.W))

  // Concatenate the `ready` signals from all outputs
  val pReady = VecInit(io.p.map(_.ready)).asUInt()

  // When we are ready to accept new data
  val nxtAccept = (pValid === 0.U) || (pValid & pReady === pValid)

  // Default values for input ready signal and output channels
  io.c.ready := nxtAccept
  for (i <- 0 until n) {
    io.p(i).valid := pValid(i)
    io.p(i).bits := pData
  }

  // Logic for accepting new data
  when(nxtAccept) {
    when(io.c.fire()) { // Accept new data and update pValid with dst bit vector
      pData := io.c.bits
      pValid := io.dst & Fill(n, io.c.valid.asUInt) // Set `pValid` only for active `dst` channels
    }.otherwise { // No new data, clear pValid
      pValid := 0.U
    }
  }.otherwise {
    // Retain only the channels that aren't ready
    pValid := pValid & ~pReady
  }
}
