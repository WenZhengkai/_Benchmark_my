import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data))
    val deq = Decoupled(data)
  })

  // Internal Registers
  val pValid = RegInit(false.B) // Indicates if valid data is being held
  val pData  = Reg(data)        // Holds the data of type D

  // Data Storage and Flow Control Logic
  when(pValid) {
    // When there is valid data, wait for deq.ready to unload it
    when(io.deq.ready) {
      pValid := false.B // Clear pValid after unloading
    }
  }.otherwise {
    // When there is no valid data, accept new data if enq.valid is asserted
    when(io.enq.valid) {
      pValid := true.B  // Set pValid to indicate valid data
      pData  := io.enq.bits // Capture the incoming data
    }
  }

  // Output Assignments
  io.deq.valid := pValid       // Indicate whether data is available
  io.deq.bits  := pData        // Provide the held data for consumption
  io.enq.ready := !pValid      // Ready to accept new data only if no data is being held
}

/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(UInt(8.W)), args)
}
*/
