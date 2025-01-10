import chisel3._
import chisel3.util._

// Define the DCMirror module
class dut[D <: Data](data: D, n: Int) extends Module {
  // Define the input/output interface
  val io = IO(new Bundle {
    val dst = Input(UInt(n.W))
    val c = Flipped(Decoupled(data.cloneType))
    val p = Vec(n, Decoupled(data.cloneType))
  })

  // Data register to hold the incoming data when accepted
  val pData = RegInit(0.U.asTypeOf(data))

  // Register to track valid outputs, initialized to zero
  val pValid = RegInit(0.U(n.W))
  
  // Ready vector collecting all output ready signals
  val pReady = Cat(io.p.map(_.ready).reverse)

  // Calculate next accept signal
  val nxtAccept = (pValid === 0.U) || ((pValid & pReady) === pValid)

  // Logic for accepting new data
  when(io.c.valid && nxtAccept) {
    pData := io.c.bits
    pValid := Mux(io.c.valid, io.dst & Fill(n, 1.U), 0.U)
  }.otherwise {
    pValid := pValid & ~pReady
  }

  // Assign input ready signal
  io.c.ready := nxtAccept

  // Assign output valid and data signals
  for (i <- 0 until n) {
    io.p(i).valid := pValid(i)
    io.p(i).bits := pData
  }
}

