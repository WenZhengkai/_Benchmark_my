import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, n: Int) extends Module {
  val io = IO(new Bundle {
    val dst = Input(UInt(n.W))
    val c = Flipped(new DecoupledIO(data))
    val p = Vec(n, new DecoupledIO(data.cloneType))
  })

  // Internal Registers and Signals
  val pData = Reg(data.cloneType)
  val pValid = RegInit(0.U(n.W))
  val pReady = Cat((0 until n).map(i => io.p(i).ready).reverse)
  val nxtAccept = pValid === 0.U || (pValid & ~pReady) === 0.U

  // Accept new data when module is ready
  when (nxtAccept) {
    when (io.c.valid) {
      pData := io.c.bits
    }
    pValid := io.c.valid & io.dst
  }.otherwise {
    pValid := pValid & ~pReady
  }

  // Assign outputs based on internal registers
  for (i <- 0 until n) {
    io.p(i).valid := pValid(i)
    io.p(i).bits := pData
  }

  // Indicate readiness to accept new data
  io.c.ready := nxtAccept
}


