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
    // When pValid is false, accept new data if enq.valid is asserted
    when(io.enq.valid) {
      pData  := io.enq.bits // Capture the incoming data
      pValid := true.B     // Set pValid to indicate valid data is held
    }
  }

  // Output Assignments
  io.deq.valid := pValid          // deq.valid is driven by pValid
  io.deq.bits  := pData           // deq.bits is driven by pData
  io.enq.ready := !pValid         // enq.ready is driven by the negation of pValid
}

// Example usage with UInt as the data type
/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(UInt(8.W)), Array("--target-dir", "generated"))
}
*/
