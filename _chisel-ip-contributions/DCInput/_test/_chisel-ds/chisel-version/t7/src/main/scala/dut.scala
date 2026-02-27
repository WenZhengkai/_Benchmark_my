import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data))
    val deq = Decoupled(data)
  })

  // Internal Registers and Wires
  val ready_r = RegInit(true.B) // Indicates if the module can accept new data
  val occupied = RegInit(false.B) // Indicates if the internal buffer holds unsent data
  val hold = Reg(data) // Register to store the held data
  val load = Wire(Bool()) // Determines if new data should be loaded
  val drain = Wire(Bool()) // Determines if data should be drained (outputted)

  // Data Forwarding Logic
  drain := occupied && io.deq.ready // Drain when occupied and downstream is ready
  load := io.enq.valid && ready_r && (!io.deq.ready || drain) // Load when new data is available, module is ready, and downstream is not ready or data is being drained

  // Data Handling Logic
  io.deq.bits := Mux(occupied, hold, io.enq.bits) // Output held data if occupied, else output incoming data
  io.deq.valid := occupied || io.enq.valid // Output is valid if data is occupied or new data is available

  // Control Logic
  when(load) {
    occupied := true.B // Mark as occupied when loading new data
    hold := io.enq.bits // Store incoming data in hold register
  }
  when(drain) {
    occupied := false.B // Mark as not occupied when data is drained
  }

  // Update ready_r
  ready_r := !occupied || drain // Ready to accept new data if not occupied or data is being drained

  // Handshake signals
  io.enq.ready := ready_r // Indicate readiness to accept new data
}

/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(UInt(8.W)), args)
}
*/
