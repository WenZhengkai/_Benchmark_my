import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, n: Int) extends Module {
  val io = IO(new Bundle {
    val dst = Input(UInt(n.W))
    val c = Flipped(Decoupled(data))
    val p = Vec(n, Decoupled(data))
  })

  // Task 1: Define Registers
  val pData = Reg(data.cloneType)
  val pValid = RegInit(0.U(n.W))

  // Task 2: Compute `pReady` Vector
  val pReady = Wire(Vec(n, Bool()))
  for (i <- 0 until n) {
    pReady(i) := io.p(i).ready
  }

  // Task 3: Compute `nxtAccept` Signal
  val pReadyVec = pReady.asUInt
  val nxtAccept = (pValid === 0.U) || (pValid & pReadyVec) === pValid

  // Task 4: Update Data and Validity
  when (nxtAccept) {
    pData := io.c.bits
    when (io.c.valid) { // Only update when incoming data is valid
      pValid := io.dst & Fill(n, io.c.valid)
    } .otherwise {
      pValid := 0.U // No valid data being set if not valid input
    }
  } .otherwise {
    // Clear valid signals for destinations that are ready
    pValid := pValid & ~pReadyVec
  }

  // Task 5: Output Assignment
  for (i <- 0 until n) {
    io.p(i).valid := pValid(i)
    io.p(i).bits := pData
  }

  // Task 6: Implement Ready/Valid Handshake
  io.c.ready := nxtAccept // The input channel is ready when nxtAccept is true
}


