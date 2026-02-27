import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data))
    val deq = Decoupled(data)
  })

  // Internal registers and wires
  val ready_r = RegInit(true.B) // Indicates if the module can accept new data
  val occupied = RegInit(false.B) // Indicates if the internal buffer holds unsent data
  val hold = Reg(data) // Register to store temporarily held data
  val load = Wire(Bool()) // Determines if new data should be loaded
  val drain = Wire(Bool()) // Determines if data should be drained (outputted)

  // Data forwarding logic
  drain := occupied && io.deq.ready // Drain when there is data and downstream is ready
  load := io.enq.valid && ready_r && (!io.deq.ready || drain) // Load when new data is available and conditions are met

  // Data handling logic
  io.deq.bits := Mux(occupied, hold, io.enq.bits) // Output stored data if occupied, else input data
  io.deq.valid := occupied || io.enq.valid // Output is valid if there is data or new input is valid

  // Control logic
  when(load) {
    occupied := true.B // Mark as occupied when loading new data
    hold := io.enq.bits // Store incoming data in hold register
  }.elsewhen(drain) {
    occupied := false.B // Mark as not occupied when data is drained
  }

  // Update ready_r based on occupied, drain, and load
  ready_r := !occupied || drain

  // Connect enq.ready to ready_r
  io.enq.ready := ready_r
}

// Example usage with UInt data type
/*
object dut extends App {
  val dataType = UInt(8.W) // Example data type
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(dataType), Array("--target-dir", "generated"))
}
*/
