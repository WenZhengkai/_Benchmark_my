import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, n: Int) extends Module {
  val io = IO(new Bundle {
    val dst = Input(UInt(n.W))
    val c = Flipped(new DecoupledIO(data.cloneType))
    val p = Vec(n, new DecoupledIO(data.cloneType))
  })

  // Internal Registers
  val pData = Reg(data.cloneType)
  val pValid = RegInit(0.U(n.W))

  // Ready Vector
  val pReady = VecInit(io.p.map(_.ready)).asUInt

  // Next Accept Signal
  val nxtAccept = (pValid === 0.U) || ((pValid & pReady) === pValid)

  // Data Flow Control
  when (nxtAccept) {
    pData := io.c.bits
    pValid := Mux(io.c.valid, io.dst, 0.U)
  } .otherwise {
    pValid := pValid & ~pReady
  }

  // Output Assignment
  for (i <- 0 until n) {
    io.p(i).valid := pValid(i)
    io.p(i).bits := pData
  }

  // Input Ready Signal
  io.c.ready := nxtAccept
}

/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(UInt(8.W), 4), Array("--target-dir", "generated"))
}
*/
