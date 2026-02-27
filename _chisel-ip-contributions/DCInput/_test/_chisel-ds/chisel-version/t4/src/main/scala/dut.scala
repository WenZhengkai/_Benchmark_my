import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(DecoupledIO(data)) // Input interface
    val deq = DecoupledIO(data)         // Output interface
  })

  // Internal registers and wires
  val ready_r = RegInit(true.B) // Indicates if the module is ready to accept new data
  val occupied = RegInit(false.B) // Indicates if the module is holding data
  val hold = Reg(data) // Register to temporarily store incoming data

  // Combinational wires
  val load = Wire(Bool()) // Determines if new data should be loaded
  val drain = Wire(Bool()) // Determines if data should be drained (outputted)

  // Data forwarding logic
  drain := occupied && io.deq.ready // Drain when data is occupied and downstream is ready
  load := io.enq.valid && ready_r && (!io.deq.ready || drain) // Load when new data is available, module is ready, and downstream might not be ready or data is being drained

  // Data handling logic
  io.deq.bits := Mux(occupied, hold, io.enq.bits) // Output data is either held data or incoming data
  io.deq.valid := io.enq.valid || occupied // Output is valid if input is valid or data is occupied

  // Control logic
  when(load) {
    occupied := true.B // Mark as occupied when loading new data
    hold := io.enq.bits // Store incoming data in the hold register
  }
  when(drain) {
    occupied := false.B // Mark as not occupied when data is drained
  }

  // Update ready_r based on load and drain conditions
  ready_r := !occupied || drain
  io.enq.ready := ready_r // Indicate readiness to accept new data
}

// Example instantiation for testing
/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(UInt(8.W)), Array("--target-dir", "generated"))
}
*/
