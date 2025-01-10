import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, n: Int) extends Module {
  val io = IO(new Bundle {
    val dst = Input(UInt(n.W))
    val c   = Flipped(DecoupledIO(data.cloneType))
    val p   = Vec(n, DecoupledIO(data.cloneType))
  })

  // Register to store input data
  val pData = Reg(data.cloneType)

  // Register to store valid status for each output
  val pValid = RegInit(0.U(n.W))

  // Concatenated ready signals from each output
  val pReady = VecInit(io.p.map(_.ready)).asUInt

  // Next accept logic
  val nxtAccept = (pValid === 0.U) || (pValid & pReady) === pValid

  // Update logic
  when(nxtAccept) {
    when(io.c.valid) {
      pData := io.c.bits
      pValid := io.dst & Fill(n, io.c.valid)
    }
  }.otherwise {
    pValid := pValid & ~pReady
  }

  // Connect input c ready signal
  io.c.ready := nxtAccept

  // Connect each output
  for (i <- 0 until n) {
    io.p(i).bits := pData
    io.p(i).valid := pValid(i)
  }
}
