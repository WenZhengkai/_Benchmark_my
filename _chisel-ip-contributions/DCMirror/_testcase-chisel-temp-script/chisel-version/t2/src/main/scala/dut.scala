import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, n: Int) extends Module {
  val io = IO(new Bundle {
    val dst = Input(UInt(n.W))
    val c = Flipped(new DecoupledIO(data.cloneType))
    val p = Vec(n, new DecoupledIO(data.cloneType))
  })

  // Data register to store the incoming payload
  val pData = Reg(data.cloneType)
  
  // Valid register to track which outputs hold valid data
  val pValid = RegInit(0.U(n.W))
  
  // Ready vector from all output channels
  val pReady = Cat(io.p.map(_.ready).reverse)
  
  // Determine when the module can accept new data
  val nxtAccept = (pValid === 0.U) || ((pValid & pReady) === pValid)
  
  // Flow control logic
  when (nxtAccept) {
    // Store incoming data when module is ready to accept it
    pData := io.c.bits
    // Update valid bits based on destination and incoming validity
    pValid := Mux(io.c.valid, io.dst, 0.U)
  } .otherwise {
    // Clear valid bits for outputs that have accepted the data
    pValid := pValid & ~pReady
  }
  
  // Connect input ready signal
  io.c.ready := nxtAccept
  
  // Connect output channels
  for (i <- 0 until n) {
    io.p(i).valid := pValid(i)
    io.p(i).bits := pData
  }
}
