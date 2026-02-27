import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, n: Int) extends Module {
  val io = IO(new Bundle {
    val dst = Input(UInt(n.W))
    val c = Flipped(new DecoupledIO(data.cloneType))
    val p = Vec(n, new DecoupledIO(data.cloneType))
  })
  
  // Data register to store the incoming payload
  val pData = RegInit(0.U.asTypeOf(data.cloneType))
  
  // Register to track which output channels have valid data
  val pValid = RegInit(0.U(n.W))
  
  // Concatenate all ready signals from output channels
  val pReady = Cat(io.p.map(_.ready).reverse)
  
  // Determine when the module is ready to accept new data
  val nxtAccept = (pValid === 0.U) || ((pValid & ~pReady) === 0.U)
  
  // Update the input ready signal
  io.c.ready := nxtAccept
  
  // Logic for updating pValid and pData
  when (nxtAccept) {
    // Update data register unconditionally (not controlled by incoming data validity)
    pData := io.c.bits
    
    // Update valid register based on incoming data validity and dst bits
    when (io.c.valid) {
      pValid := io.dst
    } .otherwise {
      pValid := 0.U
    }
  } .otherwise {
    // Maintain valid bits only for outputs that aren't ready yet
    pValid := pValid & ~pReady
  }
  
  // Connect output channels
  for (i <- 0 until n) {
    io.p(i).valid := pValid(i)
    io.p(i).bits := pData
  }
}
