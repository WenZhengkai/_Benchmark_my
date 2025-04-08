// Importing necessary Chisel packages
import chisel3._
import chisel3.util._

/**
 * dut
 * 
 * A parameterized Chisel module implementing a decoupled input interface with internal buffering.
 * @param data Chisel data type for the data handled by the module
 */
class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(DecoupledIO(data)) // Incoming data interface
    val deq = DecoupledIO(data)         // Outgoing data interface
  })

  // Task 1: Register and Wire Declaration
  val ready_r = RegInit(true.B)              // Tracks input readiness
  val occupied = RegInit(false.B)            // Tracks buffer status
  val hold = Reg(data.cloneType)             // Temporary data storage
  val load = Wire(Bool())                    // Load condition wire
  val drain = Wire(Bool())                   // Drain condition wire

  // Task 2: Load/Drain Condition Logic
  drain := occupied && io.deq.ready          // Data is drained when buffer is occupied and consumer is ready
  load := io.enq.valid && ready_r && (!io.deq.ready || drain) // Load conditions based on readiness and output state

  // Task 3: Data Buffer Management
  when(load) {
    hold := io.enq.bits                      // Capture incoming data
  }

  // Task 4: Occupied State Control
  when(drain) {
    occupied := false.B                      // Clear buffer when data is drained
  }.elsewhen(load) {
    occupied := true.B                       // Mark buffer as occupied when data is loaded
  }

  // Task 5: Readiness Flag Update
  ready_r := (!occupied && !load) || (drain && !load) // Update ready signal based on buffer and input state

  // Task 6: Output Data Multiplexing
  io.deq.bits := Mux(occupied, hold, io.enq.bits)     // Forward buffer data if occupied, otherwise pass through input data
  io.deq.valid := occupied || (io.enq.valid && ready_r) // Output is valid if buffer is occupied or input is ready and valid

  // Task 7: Interface Signal Binding
  io.enq.ready := ready_r                             // Connect readiness signal for input

  // Task 8: Concurrency Validation
  assert(!(load && drain), "Simultaneous load-drain undefined behavior") // Ensure no conflict in load and drain conditions
}

