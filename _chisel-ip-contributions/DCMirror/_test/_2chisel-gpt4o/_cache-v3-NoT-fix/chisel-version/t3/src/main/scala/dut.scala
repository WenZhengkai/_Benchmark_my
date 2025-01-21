import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, n: Int) extends Module {
  val io = IO(new Bundle {
    val dst = Input(UInt(n.W))
    val c = Flipped(DecoupledIO(data.cloneType))
    val p = Vec(n, DecoupledIO(data.cloneType))
  })

  // Task 1: Define Registers
  val pData = Reg(data.cloneType)
  val pValid = RegInit(0.U(n.W))

  // Task 2: Compute `pReady` Vector
  val pReadyVec = VecInit(io.p.map(_.ready))
  val pReady = pReadyVec.asUInt()

  // Task 3: Compute `nxtAccept` Signal
  val nxtAccept = (pValid === 0.U) || (pValid & pReady) === pValid

  // Task 4: Update Data and Validity
  when(io.c.valid && nxtAccept) {
    pData := io.c.bits
    pValid := io.dst & Fill(n, io.c.valid.asUInt()) // Only set valid for active outputs
  }.otherwise {
    pValid := pValid & ~pReady // Clear valid for any outputs that are ready
  }

  // Task 5: Output Assignment
  for (i <- 0 until n) {
    io.p(i).valid := pValid(i)
    io.p(i).bits := pData
  }

  // Task 6: Implement Ready/Valid Handshake
  io.c.ready := nxtAccept
}