import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data))  // Decoupled input interface (producer -> this module)
    val deq = Decoupled(data)          // Decoupled output interface (this module -> consumer)
  })

  // Task 1: Register and Wire Declaration
  val ready_r = RegInit(true.B)                      // Tracks input readiness
  val occupied = RegInit(false.B)                   // Tracks buffer occupancy status
  val hold = Reg(data.cloneType)                     // Temporary data storage
  val load = Wire(Bool())                           // Combinational signal for load condition
  val drain = Wire(Bool())                          // Combinational signal for drain condition

  // Task 2: Load/Drain Condition Logic
  drain := occupied && io.deq.ready                 // Output when buffer is full and consumer is ready
  load := io.enq.valid && ready_r && (!io.deq.ready || drain) // Input accepted when valid & ready & output path available

  // Task 3: Data Buffer Management
  when(load) {                                       // Capture incoming data when `load` is true
    hold := io.enq.bits
  }

  // Task 4: Occupied State Control
  when(drain) {
    occupied := false.B                              // Clear occupancy on output drain
  }.elsewhen(load) {
    occupied := true.B                               // Set occupancy on input load
  }

  // Task 5: Readiness Flag Update
  ready_r := (!occupied && !load) || (drain && !load) // Update input readiness based on buffer state

  // Task 6: Output Data Multiplexing
  io.deq.bits := Mux(occupied, hold, io.enq.bits)   // Select output data from `hold` or pass-through
  io.deq.valid := occupied || (io.enq.valid && ready_r) // Output is valid if buffer is occupied or if input is valid and ready

  // Task 7: Interface Signal Binding
  io.enq.ready := ready_r                           // Bind input readiness signal to the internal readiness flag

  // Task 8: Concurrency Validation
  assert(!(load && drain), "Simultaneous load and drain - undefined behavior") // Ensure no simultaneous load and drain operations
}


