import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, n: Int) extends Module {
  val io = IO(new Bundle {
    val dst = Input(UInt(n.W))
    val c = Flipped(DecoupledIO(data.cloneType))
    val p = Vec(n, DecoupledIO(data.cloneType))
  })

  // Register storing the data payload
  val pData = RegInit(0.U.asTypeOf(data))

  // Registers to track the valid output destinations
  val pValid = RegInit(0.U(n.W))

  // Vector signal for output readiness
  val pReady = VecInit(io.p.map(_.ready)).asUInt()

  // Determine when the module can accept new data
  val nxtAccept = (pValid === 0.U) || (pValid & pReady) === pValid

  // Control data flow
  when(nxtAccept && io.c.valid) {
    pData := io.c.bits // Capture the data payload from input
    pValid := io.dst   // Update pValid bits according to the active bits in `dst`
  }.otherwise {
    pValid := pValid & ~pReady // Retain only not-ready outputs
  }

  // Handle the ready/valid handshake
  io.c.ready := nxtAccept

  // Assign output channels
  for (i <- 0 until n) {
    io.p(i).valid := pValid(i)
    io.p(i).bits := pData
  }
}


