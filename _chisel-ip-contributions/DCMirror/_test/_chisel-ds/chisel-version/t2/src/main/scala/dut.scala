import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, n: Int) extends Module {
  val io = IO(new Bundle {
    val dst = Input(UInt(n.W)) // Bit vector specifying active output channels
    val c = Flipped(new DecoupledIO(data.cloneType)) // Input channel for data payload
    val p = Vec(n, new DecoupledIO(data.cloneType)) // Output channels
  })

  // Internal Registers
  val pData = Reg(data.cloneType) // Register to store incoming data
  val pValid = RegInit(0.U(n.W)) // Register to track valid outputs

  // Ready Vector
  val pReady = Cat(io.p.map(_.ready).reverse) // Concatenated ready signals from all outputs

  // Next Accept Signal
  val nxtAccept = (pValid === 0.U) || (pValid & pReady).andR // Ready to accept new data when no data is valid or all valid data has been accepted

  // Data Flow Control
  when(nxtAccept) {
    // Update data payload and valid bits when ready to accept new data
    pData := io.c.bits
    pValid := io.dst & Fill(n, io.c.valid)
  }.otherwise {
    // Retain only the bits of outputs that aren't ready
    pValid := pValid & ~pReady
  }

  // Output Assignment
  for (i <- 0 until n) {
    io.p(i).valid := pValid(i)
    io.p(i).bits := pData
  }

  // Input Ready Signal
  io.c.ready := nxtAccept
}

// Example usage
/*
object dut extends App {
  val dataType = UInt(8.W) // Example data type
  val n = 4 // Example number of outputs
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(dataType, n), Array("--target-dir", "generated"))
}
*/
