import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(DecoupledIO(data)) // Input interface
    val deq = DecoupledIO(data)         // Output interface
  })

  // Task 1: Register and Wire Declaration
  val ready_r = RegInit(true.B)            // Tracks input readiness
  val occupied = RegInit(false.B)          // Tracks buffer occupancy
  val hold = Reg(data.cloneType)           // Temporary data storage
  val load = Wire(Bool())                  // Load condition
  val drain = Wire(Bool())                 // Drain condition

  // Task 2: Load/Drain Condition Logic
  drain := occupied && io.deq.ready        // Output when buffer full and consumer is ready
  load := io.enq.valid && ready_r && (!io.deq.ready || drain) // Load when input is valid & ready

  // Task 3: Data Buffer Management
  when(load) {
    hold := io.enq.bits                    // Capture incoming data
  }

  // Task 4: Occupied State Control
  when(drain) {
    occupied := false.B                    // Buffer drained
  }.elsewhen(load) {
    occupied := true.B                     // Buffer occupied
  }

  // Task 5: Readiness Flag Update
  ready_r := (!occupied && !load) || (drain && !load) // Dynamically adjust readiness

  // Task 6: Output Data Multiplexing
  io.deq.bits := Mux(occupied, hold, io.enq.bits)    // Forward data based on occupancy
  io.deq.valid := occupied || (io.enq.valid && ready_r) // Valid flag for output

  // Task 7: Interface Signal Binding
  io.enq.ready := ready_r                  // Connect input ready signal

  // Task 8: Concurrency Validation
  assert(!(load && drain), "Simultaneous load-drain undefined behavior") // Check for conflict
}
