import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, n: Int) extends Module {
  val io = IO(new Bundle {
    val dst = Input(UInt(n.W))
    val c = Flipped(Decoupled(data.cloneType))
    val p = Vec(n, Decoupled(data.cloneType))
  })

  // Data register to hold the incoming data payload
  val pData = Reg(data.cloneType)

  // Valid register to indicate which outputs have valid data
  val pValid = RegInit(0.U(n.W))

  // Create a vector of ready signals from the outputs
  val pReady = VecInit(io.p.map(_.ready)).asUInt

  // Compute the next accept condition
  val nxtAccept = (pValid === 0.U) || ((pValid & pReady) === pValid)

  // Update logic for pData and pValid
  when (nxtAccept) {
    when (io.c.valid) {
      pValid := io.dst & Fill(n, io.c.valid)
      pData := io.c.bits
    } .otherwise {
      pValid := 0.U
    }
  } .otherwise {
    pValid := pValid & ~pReady
  }

  // Connect the input ready signal based on nxtAccept
  io.c.ready := nxtAccept

  // Assign the outputs
  for (i <- 0 until n) {
    io.p(i).valid := pValid(i)
    io.p(i).bits := pData
  }
}


