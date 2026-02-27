import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, n: Int) extends Module {
  require(n > 0, "Number of output destinations must be greater than 0")

  val io = IO(new Bundle {
    val dst = Input(UInt(n.W))
    val c   = Flipped(new DecoupledIO(data.cloneType))
    val p   = Vec(n, new DecoupledIO(data.cloneType))
  })

  // Internal registers
  val pData  = Reg(data.cloneType)
  val pValid = RegInit(0.U(n.W))

  // Concatenated ready signals from all output channels
  val pReady = Cat(io.p.map(_.ready).reverse)

  // Next accept signal
  val nxtAccept = (pValid === 0.U) || (pValid & pReady).andR

  // Data flow control logic
  when(nxtAccept) {
    // Update data payload
    pData := io.c.bits
    // Update valid bits based on dst and incoming data validity
    pValid := io.dst & Fill(n, io.c.valid)
  }.otherwise {
    // Retain only bits of outputs that aren't ready
    pValid := pValid & ~pReady
  }

  // Output assignment
  for (i <- 0 until n) {
    io.p(i).valid := pValid(i)
    io.p(i).bits  := pData
  }

  // Input ready signal
  io.c.ready := nxtAccept
}

// Example instantiation
/*
object dut extends App {
  val dataType = UInt(8.W)
  val numOutputs = 4
  chisel3.Driver.execute(args, () => new dut(dataType, numOutputs))
}
*/
