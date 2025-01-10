import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, n: Int) extends Module {
  val io = IO(new Bundle {
    val dst = Input(UInt(n.W))
    val c = Flipped(Decoupled(data.cloneType))
    val p = Vec(n, Decoupled(data.cloneType))
  })

  // Registers to hold data and valid signals
  val pData = Reg(data.cloneType)
  val pValid = RegInit(0.U(n.W))

  // Wires for output ready signals and next accept signal
  val pReady = Cat(io.p.map(_.ready).reverse)
  val nxtAccept = (pValid === 0.U) || (pReady === pValid)

  // Data flow control logic
  when (nxtAccept && io.c.valid) {
    pData := io.c.bits
    pValid := io.dst & Fill(n, io.c.valid)
  }.otherwise {
    pValid := pValid & ~pReady
  }

  // Drive the ready signal for the input channel
  io.c.ready := nxtAccept

  // Output assignment
  for (i <- 0 until n) {
    io.p(i).valid := pValid(i)
    io.p(i).bits := pData
  }
}
