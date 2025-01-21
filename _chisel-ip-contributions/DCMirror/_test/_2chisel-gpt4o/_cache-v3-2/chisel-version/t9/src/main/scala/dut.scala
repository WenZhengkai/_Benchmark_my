import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, n: Int) extends Module {
  val io = IO(new Bundle {
    val dst = Input(UInt(n.W))
    val c = Flipped(DecoupledIO(data.cloneType))
    val p = Vec(n, DecoupledIO(data.cloneType))
  })

  // Register to hold data
  val pData = Reg(data.cloneType)
  // Register to track which outputs are valid
  val pValid = RegInit(0.U(n.W))

  // Collect the ready status from each of the output channels
  val pReady = Cat(io.p.map(_.ready).reverse)

  // Compute the nextAccept condition
  val nxtAccept = (pValid === 0.U) || (pValid & pReady === pValid)

  // Logic for accepting new data
  when(nxtAccept) {
    // Update data register when ready to accept new data
    pData := io.c.bits
    // Update valid register depending on destination and input valid signal
    when(io.c.valid) {
      pValid := io.dst
    }.otherwise {
      pValid := 0.U
    }
  }.otherwise {
    // Clear valid bits for outputs that are ready
    pValid := pValid & ~pReady
  }

  // Set input ready signal
  io.c.ready := nxtAccept

  // Assign outputs
  for (i <- 0 until n) {
    io.p(i).valid := pValid(i)
    io.p(i).bits := pData
  }
}

