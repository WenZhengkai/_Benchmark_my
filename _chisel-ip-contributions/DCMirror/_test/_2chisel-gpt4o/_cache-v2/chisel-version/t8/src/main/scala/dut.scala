import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, n: Int) extends Module {
  val io = IO(new Bundle {
    val dst = Input(UInt(n.W))
    val c = Flipped(DecoupledIO(data.cloneType))
    val p = Vec(n, DecoupledIO(data.cloneType))
  })

  // Register to hold incoming data
  val pData = Reg(data.cloneType)

  // Register to track which outputs are valid
  val pValid = RegInit(0.U(n.W))

  // Vector of ready signals from outputs
  val pReady = Cat(io.p.map(_.ready).reverse)

  // Determine the next accept condition
  val nxtAccept = (pValid === 0.U) || (pValid & pReady) === pValid

  // Handle incoming data and validity
  when(nxtAccept) {
    pData := io.c.bits
    // Update valid bits based on dst and io.c.valid
    pValid := Mux(io.c.valid, io.dst, 0.U)
  } .otherwise {
    // Clear valid bits that correspond to ready outputs
    pValid := pValid & ~pReady
  }

  // Drive output interfaces
  io.c.ready := nxtAccept

  for (i <- 0 until n) {
    io.p(i).valid := pValid(i)
    io.p(i).bits := pData
  }
}
