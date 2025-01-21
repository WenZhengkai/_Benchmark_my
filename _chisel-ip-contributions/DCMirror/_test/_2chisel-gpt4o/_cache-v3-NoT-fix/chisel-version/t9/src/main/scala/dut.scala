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
  val pReady = Wire(UInt(n.W))
  pReady := Cat(io.p.map(_.ready).reverse)  // Corrected line

  // Task 3: Compute `nxtAccept` Signal
  val nxtAccept = (pValid === 0.U) || ((pValid & pReady) === pValid)

  // Task 4: Update Data and Validity
  when(nxtAccept) {
    pData := io.c.bits
    when(io.c.valid) {
      pValid := io.dst & Fill(n, io.c.valid)
    }.otherwise {
      pValid := 0.U
    }
  }.otherwise {
    pValid := pValid & ~pReady
  }

  // Task 5: Output Assignment
  for (i <- 0 until n) {
    io.p(i).valid := (pValid(i))
    io.p(i).bits := pData
  }

  // Task 6: Implement Ready/Valid Handshake
  io.c.ready := nxtAccept
}