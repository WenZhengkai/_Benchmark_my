import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, n: Int) extends Module {
  val io = IO(new Bundle {
    val dst = Input(UInt(n.W))
    val c   = Flipped(new DecoupledIO(data.cloneType))
    val p   = Vec(n, new DecoupledIO(data.cloneType))
  })

  // Internal Registers
  val pData  = Reg(data.cloneType)
  val pValid = RegInit(0.U(n.W))

  // Ready Vector
  val pReady = VecInit(io.p.map(_.ready)).asUInt

  // Next Accept Signal
  val nxtAccept = (pValid === 0.U) || (pValid & pReady).andR

  // Data Flow Control
  when(nxtAccept) {
    // Update data payload and valid bits
    pData := io.c.bits
    pValid := Mux(io.c.valid, io.dst, 0.U)
  }.otherwise {
    // Clear valid bits for outputs that are ready
    pValid := pValid & ~pReady
  }

  // Output Assignment
  for (i <- 0 until n) {
    io.p(i).valid := pValid(i)
    io.p(i).bits  := pData
  }

  // Input Ready Signal
  io.c.ready := nxtAccept
}

// Example instantiation
/*
object dut extends App {
  val dataType = UInt(8.W)
  val n = 4
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(dataType, n), Array("--target-dir", "generated"))
}
*/
