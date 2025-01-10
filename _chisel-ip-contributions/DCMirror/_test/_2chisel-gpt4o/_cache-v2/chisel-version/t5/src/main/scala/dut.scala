import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, n: Int) extends Module {
  val io = IO(new Bundle {
    val dst = Input(UInt(n.W))
    val c = Flipped(DecoupledIO(data.cloneType))
    val p = Vec(n, DecoupledIO(data.cloneType))
  })

  // Internal registers
  val pData = Reg(data.cloneType)
  val pValid = RegInit(0.U(n.W))

  // Concatenated ready signals from all output channels
  val pReady = VecInit(io.p.map(_.ready)).asUInt

  // Determine when to accept new data
  val nxtAccept = (pValid === 0.U) || ((pValid & pReady) === pValid)

  // Handle accepting new data
  when(io.c.valid && nxtAccept) {
    // Updates when we accept new data
    pData := io.c.bits
    pValid := io.dst & Fill(n, io.c.valid)
  } .otherwise {
    // Retain only the bits that are not yet accepted
    pValid := pValid & ~pReady
  }

  // Assign input ready based on nxtAccept
  io.c.ready := nxtAccept

  // Drive each output channel
  for (i <- 0 until n) {
    io.p(i).valid := pValid(i)
    io.p(i).bits := pData
  }
}


