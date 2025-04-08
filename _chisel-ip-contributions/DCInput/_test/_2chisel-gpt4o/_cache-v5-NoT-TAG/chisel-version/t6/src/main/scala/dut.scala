import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data)) // Input interface for incoming data
    val deq = Decoupled(data)         // Output interface for processed data
  })

  // Task 1: Register and Wire Declaration
  val ready_r   = RegInit(true.B)       // Register to track input readiness
  val occupied  = RegInit(false.B)      // Register to track buffer status
  val hold      = Reg(data.cloneType)   // Register to act as temporary data buffer
  val load      = Wire(Bool())          // Wire to control loading new data
  val drain     = Wire(Bool())          // Wire to control draining data to output

  // Task 2: Load/Drain Condition Logic
  drain := occupied && io.deq.ready // Drain when buffer is full and consumer is ready
  load := io.enq.valid && ready_r && (!io.deq.ready || drain) 
  // Load when input is valid, ready, and output path available

  // Task 3: Data Buffer Management
  when(load) {
    hold := io.enq.bits // Capture incoming data into the buffer
  }

  // Task 4: Occupied State Control
  when(drain) {
    occupied := false.B // Clear the buffer when data is drained
  }.elsewhen(load) {
    occupied := true.B  // Mark buffer as occupied when new data is loaded
  }

  // Task 5: Readiness Flag Update
  ready_r := (!occupied && !load) || (drain && !load)
  // Update readiness based on buffer state

  // Task 6: Output Data Multiplexing
  io.deq.bits := Mux(occupied, hold, io.enq.bits) // Select between stored or incoming data
  io.deq.valid := occupied || (io.enq.valid && ready_r) // Output is valid if buffer is occupied or input is valid and ready

  // Task 7: Interface Signal Binding
  io.enq.ready := ready_r // Connect the internal readiness signal to the input ready output

  // Task 8: Concurrency Validation
  assert(!(load && drain), "Simultaneous load-drain undefined behavior") 
  // Ensure no simultaneous load and drain events
  
  // Optional: Additional simulation-only debug prints
  when(load) {
    printf(p"[INFO] Load: Data = ${io.enq.bits}\n")
  }
  when(drain) {
    printf(p"[INFO] Drain: Data = ${io.deq.bits}\n")
  }
}

