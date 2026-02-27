import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data))
    val deq = Decoupled(data)
  })

  // Internal Registers
  val pValid = RegInit(false.B) // Indicates whether valid data is held
  val pData  = Reg(data)        // Holds the data of type D

  // Data Storage and Flow Control Logic
  when(pValid) {
    // When pValid is true, wait for deq.ready to unload the data
    when(io.deq.ready) {
      pValid := false.B // Clear pValid after unloading
    }
  }.otherwise {
    // When pValid is false, accept new data from enq if valid
    when(io.enq.valid) {
      pValid := true.B // Set pValid to indicate valid data is held
      pData  := io.enq.bits // Capture the data
    }
  }

  // Output Assignments
  io.deq.valid := pValid // Indicates whether data is available for deq
  io.deq.bits  := pData  // Provide the held data for consumption
  io.enq.ready := !pValid // Ready to accept new data only when no data is held
}

/*
object dut extends App {
  // Example instantiation with UInt as the data type
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(UInt(8.W)), Array("--target-dir", "generated"))
}
*/
