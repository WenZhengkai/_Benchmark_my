import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, n: Int) extends Module {
  val io = IO(new Bundle {
    val dst = Input(UInt(n.W))
    val c = Flipped(Decoupled(data.cloneType))
    val p = Vec(n, Decoupled(data.cloneType))
  })

  // Internal data register
  val pData = Reg(data.cloneType) // Stores the payload data
  // Valid signals for each output channel
  val pValid = RegInit(0.U(n.W)) // Initialized to zero

  // Ready signal vector for all output channels
  val pReady = VecInit(io.p.map(_.ready)).asUInt

  // Determine when the module can accept new data
  val nxtAccept = (pValid === 0.U) || ((pValid & ~pReady) === 0.U)

  // Control flow logic
  when(nxtAccept) {
    when(io.c.fire()) { // New data is accepted
      pData := io.c.bits // Update data register
      pValid := io.dst & Fill(n, io.c.valid) // Update valid bits based on `dst` and incoming validity
    }
  }.otherwise {
    // Retain only the valid bits for outputs that aren't ready
    pValid := pValid & ~pReady
  }

  // Connect the input channel ready signal
  io.c.ready := nxtAccept

  // Connect the output channels
  for (i <- 0 until n) {
    io.p(i).valid := pValid(i)
    io.p(i).bits := pData
  }
}


