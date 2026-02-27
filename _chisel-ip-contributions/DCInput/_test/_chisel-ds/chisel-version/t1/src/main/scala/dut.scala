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
  val hold = Reg(data.cloneType) // Register to temporarily hold data
  val load = Wire(Bool()) // Determines if new data should be loaded
  val drain = Wire(Bool()) // Determines if data should be drained (outputted)

  // Data Forwarding Logic
  drain := occupied && io.deq.ready // Drain when data is occupied and downstream is ready
  load := io.enq.valid && ready_r && (!io.deq.ready || drain) // Load when new data is available and conditions are met

  // Data Handling Logic
  io.deq.bits := Mux(occupied, hold, io.enq.bits) // Output stored data if occupied, else input data
  io.deq.valid := occupied || io.enq.valid // Output is valid if data is occupied or new data is valid

  // Control Logic
  when(load) {
    occupied := true.B // Mark as occupied when loading new data
    hold := io.enq.bits // Store incoming data in hold register
  }.elsewhen(drain) {
    occupied := false.B // Mark as not occupied when data is drained
  }

  // Update ready_r based on occupied, drain, and load
  ready_r := !occupied || drain || load

  // Update enq.ready based on ready_r
  io.enq.ready := ready_r
}

// Companion object for easier instantiation
object dut {
  def apply[D <: Data](data: D): dut[D] = new dut(data)
}
