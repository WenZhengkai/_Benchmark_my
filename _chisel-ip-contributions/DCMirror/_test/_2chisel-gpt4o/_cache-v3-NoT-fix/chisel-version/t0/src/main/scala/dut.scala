
import chisel3._
import chisel3.util._

class dut[D <: Data](dataType: D, n: Int) extends Module {
  val io = IO(new Bundle {
    val dst = Input(UInt(n.W))
    val c = Flipped(Decoupled(dataType))
    val p = Vec(n, Decoupled(dataType))
  })

  // Task 1: Define Registers
  val pData = Reg(dataType)
  val pValid = RegInit(0.U(n.W))

  // Task 2: Compute pReady Vector
  val pReady = Wire(Vec(n, Bool()))
  for (i <- 0 until n) {
    pReady(i) := io.p(i).ready
  }

  // Convert Vec to UInt
  val pReadyVec = VecInit(pReady.toSeq).asUInt

  // Task 3: Compute nxtAccept Signal
  val nxtAccept = (pValid === 0.U || ((pValid & pReadyVec) === pValid))

  // Task 4: Update Data and Validity
  when(nxtAccept) {
    pData := io.c.bits
    pValid := io.dst & Fill(n, io.c.valid)
  } .otherwise {
    pValid := pValid & ~pReadyVec
  }

  // Task 5: Output Assignment
  for (i <- 0 until n) {
    io.p(i).valid := pValid(i)
    io.p(i).bits := pData
  }

  // Task 6: Implement Ready/Valid Handshake
  io.c.ready := nxtAccept
}
