import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, n: Int) extends Module {
  require(n > 0, "The number of output destinations 'n' must be greater than 0.")

  val io = IO(new Bundle {
    val dst = Input(UInt(n.W)) // Bit vector specifying active output channels
    val c = Flipped(DecoupledIO(data.cloneType)) // Input channel
    val p = Vec(n, DecoupledIO(data.cloneType)) // Output channels
  })

  // Data Register to store the current payload
  val pData = Reg(data.cloneType)

  // Valid Register to track which outputs are holding valid data
  val pValid = RegInit(0.U(n.W))

  // Ready Vector from all output channels
  val pReady = Cat(io.p.map(_.ready).reverse)

  // Next Accept Signal - When the module can accept new data
  val nxtAccept = pValid === 0.U || (pValid & pReady) === pValid

  // Data Flow Control Logic
  when(nxtAccept) {
    when(io.c.valid) {
      pData := io.c.bits       // Capture the new data payload
      pValid := io.dst & Fill(n, io.c.valid.asUInt) // Set new valid bits based on dst and c.valid
    }.otherwise {
      pValid := 0.U            // Reset pValid if no new valid input
    }
  }.otherwise {
    pValid := pValid & ~pReady // Clear valid bits for outputs that have accepted the data
  }

  // Input ready signal is driven by nxtAccept
  io.c.ready := nxtAccept

  // Output Assignment
  for (i <- 0 until n) {
    io.p(i).valid := pValid(i)
    io.p(i).bits := pData
  }
}

