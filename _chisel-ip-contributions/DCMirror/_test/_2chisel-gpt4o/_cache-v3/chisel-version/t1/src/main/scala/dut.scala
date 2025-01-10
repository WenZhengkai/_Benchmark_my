import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, n: Int) extends Module {
  require(n > 0, "Number of output destinations (n) must be greater than 0")
  require(data != null, "Data type for payload cannot be null")

  val io = IO(new Bundle {
    val dst = Input(UInt(n.W)) // Destination bit vector
    val c = Flipped(Decoupled(data.cloneType)) // Input channel
    val p = Vec(n, Decoupled(data.cloneType)) // Output channels
  })

  // --- Registers to store internal state ---
  val pData = Reg(data.cloneType) // Register to hold the data payload
  val pValid = RegInit(0.U(n.W)) // Register to track which output channels are valid

  // --- Concatenate ready signals of all outputs ---
  val pReady = Cat(io.p.map(_.ready).reverse)

  // --- Compute next accept signal ---
  val nxtAccept = (pValid === 0.U) || (pValid & pReady === pValid)

  // --- Handle data transfer ---
  when(nxtAccept) {
    when(io.c.fire()) {
      pData := io.c.bits // Update data register with incoming data
      pValid := io.dst & Fill(n, io.c.valid.asUInt) // Update valid register based on `dst` and `valid`
    }.otherwise {
      pValid := 0.U // Clear valid register if no incoming data and accepting new data
    }
  }.otherwise {
    pValid := pValid & ~pReady // Clear valid bits for outputs that are ready
  }

  // --- Assign values to input channel `ready` ---
  io.c.ready := nxtAccept

  // --- Connect each output channel ---
  for (i <- 0 until n) {
    io.p(i).valid := pValid(i) // Provide valid signal based on `pValid`
    io.p(i).bits := pData // Always provide payload stored in `pData`
  }
}

