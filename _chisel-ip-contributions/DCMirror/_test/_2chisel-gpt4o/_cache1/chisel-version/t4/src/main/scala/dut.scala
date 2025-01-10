import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, n: Int) extends Module {
  val io = IO(new Bundle {
    val dst = Input(UInt(n.W))
    val c = Flipped(DecoupledIO(data.cloneType))
    val p = Vec(n, DecoupledIO(data.cloneType))
  })

  // Register to hold the incoming data
  val pData = RegInit(0.U.asTypeOf(data.cloneType))
  
  // Register to track which outputs have valid data
  val pValid = RegInit(0.U(n.W))

  // Vector of ready signals from output channels
  val pReady = Cat(io.p.map(_.ready).reverse)

  // Determine when to accept new data
  val nxtAccept = (pValid === 0.U || (pValid & pReady) === pValid)

  // Handle input data acceptance and pValid updating
  when (nxtAccept) {
    pValid := Mux(io.c.valid, io.dst, 0.U)
    when (io.c.valid) {
      pData := io.c.bits
    }
  } .otherwise {
    pValid := pValid & ~pReady
  }

  // Drive the ready signal for the input channel
  io.c.ready := nxtAccept

  // Assign output channels
  for (i <- 0 until n) {
    io.p(i).valid := pValid(i)
    io.p(i).bits := pData
  }
}


