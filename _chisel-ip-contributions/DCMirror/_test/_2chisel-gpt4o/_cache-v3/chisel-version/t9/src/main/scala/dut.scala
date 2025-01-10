import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, n: Int) extends Module {
  require(n > 0, "The number of output destinations (n) must be greater than 0.")

  val io = IO(new Bundle {
    val dst = Input(UInt(n.W))            // Active output destination bit vector
    val c = Flipped(Decoupled(data))      // Input channel (DecoupledIO interface)
    val p = Vec(n, Decoupled(data))       // Array of output channels (DecoupledIO interface)
  })

  // Registers to hold internal state
  val pData = Reg(data.cloneType)         // Register to store the current payload
  val pValid = RegInit(0.U(n.W))          // Validity register for outputs, initialized to 0

  // Ready vector from all output channels
  val pReady = Cat(io.p.map(_.ready).reverse) // Concatenate 'ready' signals from all outputs

  // Compute the next accept signal
  val nxtAccept = (pValid === 0.U) || (pValid & pReady === pValid)

  // Data flow logic
  when(nxtAccept) {
    // Update the data payload register with the incoming data bits when nxtAccept is true
    pData := io.c.bits
    // Update pValid based on dst and input validity
    pValid := Mux(io.c.valid, io.dst & Fill(n, 1.U(1.W)), 0.U)
  } .otherwise {
    // Clear out pValid for outputs that are ready
    pValid := pValid & ~pReady
  }

  // Input channel ready signal: Accept new data if nxtAccept is true
  io.c.ready := nxtAccept

  // Output assignment logic
  for (i <- 0 until n) {
    io.p(i).valid := pValid(i)               // Output valid based on pValid register
    io.p(i).bits := pData                    // All outputs share the same payload from pData
  }
}
