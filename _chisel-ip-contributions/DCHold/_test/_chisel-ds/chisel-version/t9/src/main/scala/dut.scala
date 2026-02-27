import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data))
    val deq = Decoupled(data)
  })

  // Internal registers
  val pValid = RegInit(false.B) // Indicates if there is valid data held
  val pData = Reg(data)         // Holds the data of type D

  // Data storage and flow control logic
  when(io.enq.valid && !pValid) {
    // Capture data from enq when pValid is not set
    pData := io.enq.bits
    pValid := true.B
  }.elsewhen(io.deq.ready && pValid) {
    // Unload data to deq when pValid is set and deq is ready
    pValid := false.B
  }

  // Output assignments
  io.deq.valid := pValid
  io.deq.bits := pData
  io.enq.ready := !pValid // Ready to accept new data only when no data is held
}

// Example instantiation for testing
/*
object dut extends App {
  println("Generating the dut module")
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(UInt(8.W)), args)
}
*/
