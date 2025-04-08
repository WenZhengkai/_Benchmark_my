import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data)) // Input
    val deq = Decoupled(data)          // Output
  })

  // Task 1: Register and Wire Declaration
  val ready_r = RegInit(true.B)        // Flag to indicate input readiness
  val occupied = RegInit(false.B)      // Flag for buffer occupancy
  val hold = Reg(data.cloneType)       // Register to temporarily hold data

  val load = Wire(Bool())              // Wire for load condition
  val drain = Wire(Bool())             // Wire for drain condition

  // Task 2: Load/Drain Condition Logic
  drain := occupied && io.deq.ready                // Drain when buffer is occupied & consumer is ready
  load := io.enq.valid && ready_r && (!io.deq.ready || drain) // Load when input is valid + ready + output path available

  // Task 3: Data Buffer Management
  when(load) {
    hold := io.enq.bits                              // Capture incoming data when load is active
  }

  // Task 4: Occupied State Control
  when(drain) {                                     // Priority: Drain first
    occupied := false.B
  }.elsewhen(load) {                                // Otherwise, load when applicable
    occupied := true.B
  }

  // Task 5: Readiness Flag Update
  ready_r := (!occupied && !load) || (drain && !load) // Readiness depends on the buffer state and flow conditions

  // Task 6: Output Data Multiplexing
  io.deq.bits := Mux(occupied, hold, io.enq.bits)    // Output data: buffer if occupied, else forward
  io.deq.valid := occupied || (io.enq.valid && ready_r) // Output valid: true if data is buffered or passthrough condition met

  // Task 7: Interface Signal Binding
  io.enq.ready := ready_r                            // Connect dynamic readiness to input handshake signal

  // Task 8: Concurrency Validation
  assert(!(load && drain), "Simultaneous load and drain detected, undefined behavior") // Ensure no simultaneous load and drain
}
