import chisel3._
import chisel3.util._

/**
 * Token Distributor module that sends data to multiple destinations based on a bit vector.
 *
 * @param data The data type to be distributed
 * @param n The number of output destinations
 */
class dut[D <: Data](data: D, n: Int) extends Module {
  val io = IO(new Bundle {
    // Bit vector indicating active output channels
    val dst = Input(UInt(n.W))
    // Input channel carrying the data payload
    val c = Flipped(new DecoupledIO(data.cloneType))
    // Vector of output channels
    val p = Vec(n, new DecoupledIO(data.cloneType))
  })

  // Data register to store the incoming payload
  val pData = Reg(data.cloneType)
  
  // Valid register to track which outputs have valid data
  val pValid = RegInit(0.U(n.W))
  
  // Concatenate ready signals from all output channels
  val pReady = Cat(io.p.map(_.ready).reverse)
  
  // Next accept signal - true when no data is valid or all valid data has been accepted
  val nxtAccept = (pValid === 0.U) || ((pValid & pReady) === pValid)
  
  // Input ready when we can accept new data
  io.c.ready := nxtAccept
  
  // Logic to update data and valid signals
  when(nxtAccept) {
    // Update data register with incoming data (regardless of validity)
    pData := io.c.bits
    
    // Update valid register based on dst and incoming valid signal
    when(io.c.valid) {
      pValid := io.dst
    }.otherwise {
      pValid := 0.U
    }
  }.otherwise {
    // Clear valid bits for outputs that are ready, keep others
    pValid := pValid & ~pReady
  }
  
  // Connect data and valid signals to outputs
  for (i <- 0 until n) {
    io.p(i).valid := pValid(i)
    io.p(i).bits := pData
  }
}
