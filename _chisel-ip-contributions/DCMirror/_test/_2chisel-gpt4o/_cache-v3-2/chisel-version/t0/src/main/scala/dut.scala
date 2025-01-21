import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, n: Int) extends Module {
  val io = IO(new Bundle {
    val dst = Input(UInt(n.W))
    val c = Flipped(DecoupledIO(data.cloneType))
    val p = Vec(n, DecoupledIO(data.cloneType))
  })

  // Data Register to hold the incoming data
  val pData = Reg(data.cloneType)

  // Valid Register to track which outputs have valid data
  val pValid = RegInit(0.U(n.W))

  // Ready Vector, concatenating ready signals from all outputs
  val pReady = Cat(io.p.map(_.ready).reverse)

  // Next Accept Signal determines if module can accept new data
  val nxtAccept = (pValid === 0.U) || (pValid & pReady) === pValid

  // Data Flow Control Logic
  when(nxtAccept) {
    when(io.c.valid) {
      // Update data register when ready to accept, data is always captured
      pData := io.c.bits
      // Update pValid according to active dst bits and input valid
      pValid := io.dst & Fill(n, io.c.valid.asUInt)
    }
  }.otherwise {
    // Clear out accepted data
    pValid := pValid & ~pReady
  }

  // Drive the output ports
  for (i <- 0 until n) {
    io.p(i).valid := pValid(i)
    io.p(i).bits := pData
  }

  // Ready signal for input channel
  io.c.ready := nxtAccept
}
