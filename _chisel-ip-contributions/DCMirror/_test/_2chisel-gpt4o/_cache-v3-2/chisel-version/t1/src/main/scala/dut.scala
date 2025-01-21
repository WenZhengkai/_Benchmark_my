import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, n: Int) extends Module {
  require(n > 0, "Number of destinations (n) must be greater than 0.")
  val io = IO(new Bundle {
    val dst = Input(UInt(n.W))
    val c = Flipped(Decoupled(data.cloneType))
    val p = Vec(n, Decoupled(data.cloneType))
  })

  // Registers to hold the current valid data payload and valid output channels
  val pData = Reg(data.cloneType)
  val pValid = RegInit(0.U(n.W))

  // Calculate which outputs are ready to receive data
  val pReady = Cat(io.p.map(_.ready).reverse)

  // Compute the next accept signal
  val nxtAccept = (pValid === 0.U) || (pValid & pReady) === pValid

  // Control logic to update registers and interfaces
  when(nxtAccept) {
    pData := io.c.bits
    pValid := Mux(io.c.valid, io.dst, 0.U)
  }.otherwise {
    pValid := pValid & ~pReady
  }

  // Assign outputs based on valid register and data
  for (i <- 0 until n) {
    io.p(i).bits := pData
    io.p(i).valid := pValid(i)
  }

  // Control the ready signal for the input channel
  io.c.ready := nxtAccept
}
