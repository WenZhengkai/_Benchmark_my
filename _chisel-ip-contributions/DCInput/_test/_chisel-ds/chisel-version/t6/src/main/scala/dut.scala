import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(DecoupledIO(data))
    val deq = DecoupledIO(data)
  })

  // Internal Registers and Wires
  val ready_r = RegInit(true.B) // Indicates if the module can accept new data
  val occupied = RegInit(false.B) // Indicates if the module holds unsent data
  val hold = Reg(data) // Register to temporarily hold data
  val load = Wire(Bool()) // Determines if new data should be loaded
  val drain = Wire(Bool()) // Determines if data should be outputted

  // Data Forwarding Logic
  drain := occupied && io.deq.ready // Drain when data is occupied and downstream is ready
  load := io.enq.valid && ready_r && (!io.deq.ready || drain) // Load when new data is available and conditions are met

  // Data Handling Logic
  io.deq.bits := Mux(occupied, hold, io.enq.bits) // Output stored data if occupied, else input data
  io.deq.valid := occupied || io.enq.valid // Output is valid if data is occupied or new data is available

  // Control Logic
  when(load) {
    occupied := true.B // Mark as occupied when loading new data
    hold := io.enq.bits // Store incoming data in hold register
  }
  when(drain) {
    occupied := false.B // Mark as not occupied when data is drained
  }
  ready_r := !occupied || drain // Update ready_r based on occupied and drain conditions

  // Enqueue ready signal
  io.enq.ready := ready_r
}

// Example usage
/*
object dut extends App {
  val dataType = UInt(8.W) // Example data type
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(dataType), Array("--target-dir", "generated"))
}
*/
