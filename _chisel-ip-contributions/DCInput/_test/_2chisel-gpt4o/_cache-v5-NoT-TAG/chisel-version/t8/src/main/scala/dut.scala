import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data)) // Input interface
    val deq = Decoupled(data)          // Output interface
  })

  // Task 1: Register and Wire Declaration
  val ready_r = RegInit(true.B)       // Signal for input readiness
  val occupied = RegInit(false.B)    // Tracks buffer usage status
  val hold = Reg(data)               // Temporary data storage register
  val load = Wire(Bool())            // Signal to load data into the buffer
  val drain = Wire(Bool())           // Signal to drain data out of the buffer

  // Task 2: Load/Drain Condition Logic
  drain := occupied && io.deq.ready                    // Drain if buffer is full and consumer is ready
  load := io.enq.valid && ready_r && (!io.deq.ready || drain) // Load when producer valid and ready, and output path available

  // Task 3: Data Buffer Management
  when(load) {
    hold := io.enq.bits     // Load incoming data into the buffer
  }

  // Task 4: Occupied State Control
  when(drain) {
    occupied := false.B      // Empty the buffer when draining
  }.elsewhen(load) {
    occupied := true.B       // Mark buffer as occupied when loading new data
  }

  // Task 5: Readiness Flag Update
  ready_r := (!occupied && !load) || (drain && !load) // Update input readiness based on buffer state

  // Task 6: Output Data Multiplexing
  io.deq.bits := Mux(occupied, hold, io.enq.bits)        // Output the buffered data if occupied, else bypass input
  io.deq.valid := occupied || (io.enq.valid && ready_r)  // Output is valid if buffer occupied or input ready and valid

  // Task 7: Interface Signal Binding
  io.enq.ready := ready_r  // Bind readiness flag to input interface

  // Task 8: Concurrency Validation
  assert(!(load && drain), "Simultaneous load and drain detected, undefined behavior") // Ensure no conflicting load/drain
}
