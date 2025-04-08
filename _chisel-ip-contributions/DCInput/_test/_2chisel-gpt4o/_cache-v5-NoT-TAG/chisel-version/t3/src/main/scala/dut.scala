import chisel3._
import chisel3.util._

/** dut
  * A parameterized Chisel module for decoupled input interface
  * with internal buffering and selective forwarding logic.
  *
  * @param data Type of data the module will handle
  * @tparam D Data type parameter
  */
class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(DecoupledIO(data))  // Input interface (consumer)
    val deq = DecoupledIO(data)          // Output interface (producer)
  })

  // Task 1: Register and Wire Declaration
  val ready_r = RegInit(true.B)          // Tracks if the module can accept inputs
  val occupied = RegInit(false.B)        // Tracks if buffer is occupied
  val hold = Reg(data.cloneType)         // Temporary storage for incoming data
  val load = Wire(Bool())                // Load condition wire
  val drain = Wire(Bool())               // Drain condition wire

  // Task 2: Load/Drain Condition Logic
  drain := occupied && io.deq.ready      // Drain when buffer is occupied and consumer is ready
  load := io.enq.valid && ready_r && (!io.deq.ready || drain) // Load with valid input and conditions met

  // Task 3: Data Buffer Management
  when(load) {
    hold := io.enq.bits                  // Capture incoming data into the hold register
  }

  // Task 4: Occupied State Control
  when(drain) {
    occupied := false.B                  // Clear buffer when draining data
  }.elsewhen(load) {
    occupied := true.B                   // Mark buffer as occupied when loading data
  }

  // Task 5: Readiness Flag Update
  ready_r := (!occupied && !load) || (drain && !load) // Update readiness dynamically

  // Task 6: Output Data Multiplexing
  io.deq.bits := Mux(occupied, hold, io.enq.bits)    // Output: either from buffer or directly from input
  io.deq.valid := occupied || (io.enq.valid && ready_r) // Validity is true if buffer has data or input is valid and ready

  // Task 7: Interface Signal Binding
  io.enq.ready := ready_r                            // Bind input ready signal to readiness flag

  // Task 8: Concurrency Validation
  assert(!(load && drain), "Simultaneous load and drain detected: undefined behavior")
}
