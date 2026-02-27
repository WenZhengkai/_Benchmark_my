import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data))
    val deq = Decoupled(data)
  })

  // Internal Registers and Wires
  val ready_r = RegInit(true.B) // Indicates if the module can accept new data
  val occupied = RegInit(false.B) // Indicates if the module holds unsent data
  val hold = Reg(data) // Stores the held data
  val load = Wire(Bool()) // Determines if new data should be loaded
  val drain = Wire(Bool()) // Determines if data should be drained (outputted)

  // Data Forwarding Logic
  drain := occupied && io.deq.ready // Drain when occupied and downstream is ready
  load := io.enq.valid && ready_r && (!io.deq.ready || drain) // Load when valid, ready, and (downstream not ready or draining)

  // Data Handling Logic
  io.deq.bits := Mux(occupied, hold, io.enq.bits) // Output held data if occupied, else input data
  io.deq.valid := occupied || io.enq.valid // Output is valid if occupied or input is valid

  // Control Logic
  when(load) {
    occupied := true.B // Mark as occupied when loading new data
    hold := io.enq.bits // Store the incoming data
  }
  when(drain) {
    occupied := false.B // Mark as not occupied when draining data
  }

  // Update ready_r based on load and drain conditions
  ready_r := !occupied || drain

  // Handshake signals
  io.enq.ready := ready_r
}

/*
object dut extends App {
  println("Generating Verilog for dut module...")
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(UInt(8.W)), args)
}
*/
