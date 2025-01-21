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

  // Concatenate all ready signals from outputs
  val pReady = VecInit(io.p.map(_.ready)).asUInt

  // Compute next accept signal
  val nxtAccept = (pValid === 0.U) || (pValid & pReady) === pValid

  // Data flow control
  when (nxtAccept) {
    pData := io.c.bits // Capture incoming data, irrespective of io.c.valid
    when (io.c.valid) {
      pValid := io.dst & Fill(n, io.c.valid) // Update valid register based on dst and c.valid
    } .otherwise {
      pValid := 0.U
    }
  } .otherwise {
    pValid := pValid & ~pReady // Clear valid bits for the ready outputs
  }

  // Connect input ready to nxtAccept
  io.c.ready := nxtAccept

  // Output assignment
  for (i <- 0 until n) {
    io.p(i).valid := pValid(i)
    io.p(i).bits := pData
  }
}

