import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, n: Int) extends Module {
  val io = IO(new Bundle {
    val dst = Input(UInt(n.W))
    val c = Flipped(new DecoupledIO(data.cloneType))
    val p = Vec(n, new DecoupledIO(data.cloneType))
  })

  // Internal registers
  val pData = Reg(data.cloneType)
  val pValid = RegInit(0.U(n.W))

  // Concatenated ready signals from all output channels
  val pReady = Cat(io.p.map(_.ready).reverse)

  // Next accept signal
  val nxtAccept = (pValid === 0.U) || (pValid & pReady).orR

  // Data flow control
  when(nxtAccept) {
    // Update data payload when ready to accept new data
    pData := io.c.bits
    // Update pValid based on dst and incoming data validity
    pValid := Mux(io.c.valid, io.dst, 0.U)
  }.otherwise {
    // Retain only bits of outputs that aren't ready
    pValid := pValid & ~pReady
  }

  // Output assignment
  for (i <- 0 until n) {
    io.p(i).valid := pValid(i)
    io.p(i).bits := pData
  }

  // Input ready signal
  io.c.ready := nxtAccept
}

/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(UInt(8.W), 4), Array("--target-dir", "generated"))
}
*/
