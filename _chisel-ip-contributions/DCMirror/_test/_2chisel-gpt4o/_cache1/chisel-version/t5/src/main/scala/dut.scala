import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, n: Int) extends Module {
  val io = IO(new Bundle {
    val dst = Input(UInt(n.W))
    val c = Flipped(DecoupledIO(data.cloneType))
    val p = Vec(n, DecoupledIO(data.cloneType))
  })

  // Data register to store incoming data
  val pData = Reg(data.cloneType)
  // Valid register to track which output paths are signaling valid data
  val pValid = RegInit(0.U(n.W))
  // Ready vector from outputs
  val pReady = Cat(io.p.map(_.ready).reverse).asUInt

  // Calculate when to accept new data
  val nxtAccept = (pValid === 0.U) || ((pValid & pReady) === pValid)

  // Data flow control: update pValid and pData
  when (nxtAccept) {
    when (io.c.valid) {
      pData := io.c.bits
      pValid := io.dst & Fill(n, io.c.valid.asUInt)
    }.otherwise {
      pValid := 0.U
    }
  } otherwise {
    pValid := pValid & ~pReady
  }

  // Assign output ports
  for (i <- 0 until n) {
    io.p(i).valid := pValid(i)
    io.p(i).bits := pData
  }
  
  // Connect the ready signal back to the input
  io.c.ready := nxtAccept
}
