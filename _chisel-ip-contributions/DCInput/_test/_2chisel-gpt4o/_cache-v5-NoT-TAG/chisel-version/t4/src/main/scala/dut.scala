import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data)) // Input interface
    val deq = Decoupled(data)          // Output interface
  })

  // Task 1: Register and Wire Declaration
  val ready_r = RegInit(true.B)                // Tracks input readiness
  val occupied = RegInit(false.B)             // Tracks buffer status
  val hold = Reg(data)                        // Temporary data storage
  val load = Wire(Bool())                     // Load condition
  val drain = Wire(Bool())                    // Drain condition

  // Task 2: Load/Drain Condition Logic
  drain := occupied && io.deq.ready           // Drain if buffer full and consumer ready
  load := io.enq.valid && ready_r && (!io.deq.ready || drain) // Load if valid, ready, and appropriate conditions

  // Task 3: Data Buffer Management
  when(load) {
    hold := io.enq.bits                       // Capture incoming data on load condition
  }

  // Task 4: Occupied State Control
  when(drain) {
    occupied := false.B                       // Free the buffer on drain
  }.elsewhen(load) {
    occupied := true.B                        // Occupy the buffer on load
  }

  // Task 5: Readiness Flag Update
  ready_r := (!occupied && !load) || (drain && !load) // Dynamically update ready state

  // Task 6: Output Data Multiplexing
  io.deq.bits := Mux(occupied, hold, io.enq.bits)    // Select between buffer and input data
  io.deq.valid := occupied || (io.enq.valid && ready_r) // Set validity based on state

  // Task 7: Interface Signal Binding
  io.enq.ready := ready_r                     // Bind input ready signal

  // Task 8: Concurrency Validation
  assert(!(load && drain), "Simultaneous load-drain undefined behavior") // Add assertion to avoid conflicts
}

