import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, n: Int) extends Module {
  val io = IO(new Bundle {
    val dst = Input(UInt(n.W))
    val c = Flipped(DecoupledIO(data.cloneType))
    val p = Vec(n, DecoupledIO(data.cloneType))
  })

  // Register to hold the current data payload
  val pData = Reg(data.cloneType)
  
  // Register to track valid status of each output
  val pValid = RegInit(0.U(n.W))
  
  // Concatenate the ready signals from outputs
  val pReady = VecInit(io.p.map(_.ready)).asUInt()
  
  // Determine when to accept new data
  val nxtAccept = (pValid === 0.U) || (pValid & pReady) === pValid

  // Control logic for capturing and propagating data
  when (nxtAccept && io.c.valid) {
    pData := io.c.bits
    pValid := io.dst & Fill(n, io.c.valid.asUInt())
  }
  .otherwise {
    pValid := pValid & ~pReady
  }
  
  // Connect the ready signal for input to the next acceptance signal
  io.c.ready := nxtAccept
  
  // Drive output channels
  for (i <- 0 until n) {
    io.p(i).valid := pValid(i)
    io.p(i).bits := pData
  }
}
