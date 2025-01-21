import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, n: Int) extends Module {
  val io = IO(new Bundle {
    val dst = Input(UInt(n.W))
    val c = Flipped(DecoupledIO(data.cloneType))
    val p = Vec(n, DecoupledIO(data.cloneType))
  })

  // Internal registers for data and valid tracking
  val pData = Reg(data.cloneType)
  val pValid = RegInit(0.U(n.W))

  // Concatenate ready signals from all outputs
  val pReady = VecInit(io.p.map(_.ready)).asUInt

  // Calculate next accept signal
  val nxtAccept = (pValid === 0.U) || (pValid & pReady) === pValid

  // Update data payload when accepting new data
  when(nxtAccept) {
    pData := io.c.bits
  }

  // Update valid register
  when(io.c.fire()) {
    pValid := io.dst & Fill(n, io.c.valid)
  } .otherwise {
    pValid := pValid & ~pReady
  }

  // Assign outputs
  io.c.ready := nxtAccept
  for(i <- 0 until n) {
    io.p(i).valid := pValid(i)
    io.p(i).bits := pData
  }
}


