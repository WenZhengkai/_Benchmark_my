import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, n: Int) extends Module {
  val io = IO(new Bundle {
    val dst = Input(UInt(n.W))
    val c   = Flipped(DecoupledIO(data.cloneType))
    val p   = Vec(n, DecoupledIO(data.cloneType))
  })

  // Register to hold the current data to be mirrored to outputs
  val pData = Reg(data.cloneType)
  val pValid = RegInit(0.U(n.W)) // Track which outputs have valid data

  // Vector concatenating ready signals from all outputs
  val pReady = VecInit(io.p.map(_.ready)).asUInt

  // Determine if the module can accept new data
  val nxtAccept = (pValid === 0.U) || ((pValid & pReady) === pValid)

  when (nxtAccept) {
    pData := io.c.bits
    pValid := Mux(io.c.valid, io.dst & Fill(n, true.B), 0.U)
  } .otherwise {
    pValid := pValid & ~pReady // Clear any outputs that have accepted data
  }

  // Connect output channels
  for (i <- 0 until n) {
    io.p(i).valid := pValid(i)
    io.p(i).bits := pData
    io.p(i).ready := DontCare // Ready is fed back via pReady vector
  }

  // Input ready signal indicates if module can accept new incoming data
  io.c.ready := nxtAccept
}

