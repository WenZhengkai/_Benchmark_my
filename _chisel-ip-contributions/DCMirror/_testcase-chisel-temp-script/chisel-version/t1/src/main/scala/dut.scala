import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, n: Int) extends Module {
  val io = IO(new Bundle {
    val dst = Input(UInt(n.W))
    val c = Flipped(Decoupled(data.cloneType))
    val p = Vec(n, Decoupled(data.cloneType))
  })

  // Task 1: Define Registers
  val pData = Reg(data.cloneType)
  val pValid = RegInit(0.U(n.W))

  // Task 2: Compute `pReady` Vector
  // Concatenate ready signals from all output channels
  val pReady = VecInit(io.p.map(_.ready)).asUInt()

  // Task 3: Compute `nxtAccept` Signal
  // Can accept new data when no data is currently valid or all valid data has been accepted
  val nxtAccept = (pValid === 0.U) || ((pValid & pReady) === pValid)

  // Task 4: Update Data and Validity
  when(nxtAccept) {
    pData := io.c.bits
    pValid := io.c.valid & io.dst
  } .otherwise {
    pValid := pValid & ~pReady // Retain outputs not yet ready
  }

  // Task 5: Output Assignment
  io.c.ready := nxtAccept
  for (i <- 0 until n) {
    io.p(i).valid := pValid(i)
    io.p(i).bits := pData
  }

  // Task 6: Implement Ready/Valid Handshake
  // This is implicitly handled by the assignment above where
  // output valid and ready signals are coordinated
}

