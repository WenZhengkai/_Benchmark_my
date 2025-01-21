import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, n: Int) extends Module {
  val io = IO(new Bundle {
    val dst = Input(UInt(n.W))
    val c = Flipped(DecoupledIO(data.cloneType))
    val p = Vec(n, DecoupledIO(data.cloneType))
  })

  // Internal Registers
  val pData = Reg(data.cloneType)
  val pValid = RegInit(0.U(n.W))

  // Concatenate ready signals from all output channels
  val pReady = Cat(io.p.map(_.ready).reverse)

  // Compute next accept signal
  val nxtAccept = (pValid === 0.U) || (pValid === pReady)

  // Logic to update valid and data registers
  when(nxtAccept) {
    // Update data register
    pData := io.c.bits
    // Calculate new valid state
    pValid := Mux(io.c.valid, io.dst, 0.U)
  } .otherwise {
    // Retain valid bits for channels that aren't ready
    pValid := pValid & ~pReady
  }

  // Update ready signal
  io.c.ready := nxtAccept

  // Assign each output channel
  (io.p.zipWithIndex).foreach { case (out, i) =>
    out.valid := pValid(i)
    out.bits := pData
  }
}

