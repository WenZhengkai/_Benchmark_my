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

  // Concatenated ready signals from all output channels
  val pReady = Cat(io.p.map(_.ready).reverse)

  // Next Accept Signal
  val nxtAccept = (pValid === 0.U) || (pValid & pReady).andR

  // Data Flow Control
  when(nxtAccept) {
    // Update data payload and valid bits when ready to accept new data
    pData := io.c.bits
    pValid := io.dst & Fill(n, io.c.valid)
  }.otherwise {
    // Retain only the bits of outputs that aren't ready
    pValid := pValid & ~pReady
  }

  // Output Assignment
  for (i <- 0 until n) {
    io.p(i).valid := pValid(i)
    io.p(i).bits  := pData
  }

  // Ready signal for the input channel
  io.c.ready := nxtAccept
}

// Example usage
/*
object dut extends App {
  val dataType = UInt(8.W)
  val numOutputs = 4
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(dataType, numOutputs), Array("--target-dir", "generated"))
}
*/
