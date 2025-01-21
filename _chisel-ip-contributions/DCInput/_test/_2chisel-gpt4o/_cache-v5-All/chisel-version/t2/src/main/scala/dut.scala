import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(DecoupledIO(data.cloneType))
    val deq = DecoupledIO(data.cloneType)
  })

  // Task 1: Set Up Registers and Wires
  // Initialize the ready_r register with default `true.B`
  val ready_r = RegInit(true.B)
  
  // Initialize registers for occupancy and holding data
  val occupied = RegInit(false.B)
  val hold = Reg(data.cloneType)

  // Wires for load and drain conditions
  val load = Wire(Bool())
  val drain = Wire(Bool())

  // Task 2: Implement Data Forwarding Logic
  // Condition for draining data: When occupied and downstream is ready
  drain := occupied && io.deq.ready

  // Condition for loading data: Valid input, ready to receive, and either drainable or downstream not ready
  load := io.enq.valid && ready_r && (!io.deq.ready || drain)

  // Task 3: Implement Data Handling Logic
  // Decide on the data to be output based on occupancy
  io.deq.bits := Mux(occupied, hold, io.enq.bits)
  
  // Output is valid when there is new data or stored data is pending
  io.deq.valid := io.enq.valid || occupied

  // Task 4: Implement Control Logic
  // Manage the occupied register based on load and drain conditions
  when(load) {
    occupied := true.B
  }.elsewhen(drain) {
    occupied := false.B
  }

  // Store new data in the hold register when the load condition is met
  when(load) {
    hold := io.enq.bits
  }

  // Define ready_r based on occupied, drain, and load conditions
  ready_r := !load && (!occupied || drain)

  // Connect the ready signal for the input
  io.enq.ready := ready_r
}
