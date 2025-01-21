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
  val pReady = Cat(io.p.map(_.ready).reverse)

  // Task 3: Compute `nxtAccept` Signal
  // Can accept new data when no current valid data or all valid data can be accepted
  val nxtAccept = (pValid === 0.U) || (pValid.asUInt & pReady.asUInt) === pValid.asUInt

  // Task 4: Update Data and Validity
  when(nxtAccept) {
    pData := io.c.bits
    pValid := Mux(io.c.valid, io.dst & Fill(n, true.B), 0.U)
  }.otherwise {
    pValid := pValid & ~pReady
  }

  // Task 5: Output Assignment
  for (i <- 0 until n) {
    io.p(i).valid := pValid(i)
    io.p(i).bits := pData
  }

  // Task 6: Implement Ready/Valid Handshake
  io.c.ready := nxtAccept
  for (i <- 0 until n) {
    io.p(i).valid := pValid(i)
  }
}

