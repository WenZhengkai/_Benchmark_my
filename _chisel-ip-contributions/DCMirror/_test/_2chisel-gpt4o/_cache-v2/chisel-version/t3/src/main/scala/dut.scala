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

  // Concatenated ready signals vector from all outputs
  val pReady = VecInit(io.p.map(_.ready)).asUInt

  // Compute nextAccept signal
  val nxtAccept = (pValid === 0.U || pValid & pReady === pValid) && io.c.valid

  // Data Flow Control Logic
  when(nxtAccept) {
    pData := io.c.bits
    pValid := io.c.valid & io.dst
  }.otherwise {
    pValid := pValid & ~pReady
  }

  // Connect the input ready signal
  io.c.ready := nxtAccept

  // Output Assignment Logic
  for (i <- 0 until n) {
    io.p(i).valid := pValid(i)
    io.p(i).bits := pData
  }
}
