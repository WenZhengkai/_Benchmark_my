import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, n: Int) extends Module {
  require(n > 0, "There must be at least one output destination")

  val io = IO(new Bundle {
    val dst = Input(UInt(n.W))
    val c = Flipped(DecoupledIO(data.cloneType))
    val p = Vec(n, DecoupledIO(data.cloneType))
  })

  // Internal Registers
  val pData = Reg(data.cloneType)
  val pValid = RegInit(0.U(n.W))

  // Ready Vector
  val pReady = Cat(io.p.map(_.ready).reverse)

  // Next Accept Signal
  val nxtAccept = (pValid === 0.U) || (pReady & pValid) === pValid

  // Data Flow Control
  when(nxtAccept) {
    when(io.c.valid) {
      pData := io.c.bits
      pValid := io.dst & Fill(n, io.c.valid.asUInt)
    } .otherwise {
      pValid := 0.U
    }
  } .otherwise {
    pValid := pValid & ~pReady
  }
  
  // Output Assignment
  for (i <- 0 until n) {
    io.p(i).valid := pValid(i)
    io.p(i).bits := pData
  }

  // Input ready assignment
  io.c.ready := nxtAccept
}

