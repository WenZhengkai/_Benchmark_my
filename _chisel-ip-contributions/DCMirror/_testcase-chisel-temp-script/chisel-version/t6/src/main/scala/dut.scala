import chisel3._
import chisel3.util._

class dut[D <: Data](dataType: D, n: Int) extends Module {
  val io = IO(new Bundle {
    val dst = Input(UInt(n.W))
    val c = Flipped(DecoupledIO(dataType.cloneType))
    val p = Vec(n, DecoupledIO(dataType.cloneType))
  })

  // Task 1: Define Registers
  val pData = Reg(dataType.cloneType)
  val pValid = RegInit(0.U(n.W))

  // Task 2: Compute `pReady` Vector
  val pReady = VecInit(io.p.map(_.ready)).asUInt

  // Task 3: Compute `nxtAccept` Signal
  val nxtAccept = (pValid === 0.U) || ((pValid & pReady) === pValid)

  // Task 4: Update Data and Validity
  when(nxtAccept) {
    when(io.c.valid) {
      pData := io.c.bits
      pValid := io.dst
    }
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

  // Ensure that `pValid` properly reacts to the ready conditions of output channels
}