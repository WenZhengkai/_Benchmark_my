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
  val pReady = VecInit(io.p.map(_.ready)).asUInt

  // Task 3: Compute `nxtAccept` Signal
  val allValidAccepted = (pReady & pValid) === pValid
  val nxtAccept = (pValid === 0.U) || allValidAccepted

  // Task 4: Update Data and Validity
  when(io.c.valid && nxtAccept) {
    pData := io.c.bits
    pValid := io.dst & Fill(n, io.c.valid) // Only update valid for active dst
  }.otherwise {
    pValid := pValid & ~pReady // Retain only outputs that aren't ready
  }

  // Task 5: Output Assignment
  io.p.zipWithIndex.foreach { case (out, i) =>
    out.valid := pValid(i)
    out.bits := pData
  }

  // Task 6: Implement Ready/Valid Handshake
  io.c.ready := nxtAccept
}

