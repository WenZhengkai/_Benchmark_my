import chisel3._
import chisel3.util._

// Parameterized dut Module
class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(DecoupledIO(data)) // Input interface (consumer)
    val deq = DecoupledIO(data)         // Output interface (producer)
  })

  // Task 1: Register and Wire Declaration
  val ready_r = RegInit(true.B)       // Tracks input readiness
  val occupied = RegInit(false.B)    // Tracks buffer status
  val hold = Reg(data.cloneType)     // Temporary data storage register
  val load = Wire(Bool())            // Load control signal
  val drain = Wire(Bool())           // Drain control signal

  // Task 2: Load/Drain Condition Logic
  drain := occupied && io.deq.ready // Drain condition: buffer occupied and consumer ready
  load := io.enq.valid && ready_r && (!io.deq.ready || drain) // Load condition: input valid, ready, buffer state

  // Task 3: Data Buffer Management
  when(load) {
    hold := io.enq.bits // Capture incoming data on load condition
  }

  // Task 4: Occupied State Control
  when(drain) {
    occupied := false.B // Reset occupancy when draining data
  }.elsewhen(load) {
    occupied := true.B // Set occupancy when loading data
  }

  // Task 5: Readiness Flag Update
  ready_r := (!occupied && !load) || (drain && !load)

  // Task 6: Output Data Multiplexing
  io.deq.bits := Mux(occupied, hold, io.enq.bits) // Output data from buffer or directly from input
  io.deq.valid := occupied || (io.enq.valid && ready_r) // Output valid when buffer full or input valid + ready

  // Task 7: Interface Signal Binding
  io.enq.ready := ready_r // Connect internal readiness to input interface

  // Task 8: Concurrency Validation
  assert(!(load && drain), "Simultaneous load-drain undefined behavior") // Ensure no concurrent load/drain
}

// Example instantiation of the dut module
// class MyTopLevel extends Module {
//   val io = IO(new Bundle {
//     val in = Flipped(Decoupled(UInt(8.W)))  // Example input interface
//     val out = Decoupled(UInt(8.W))          // Example output interface
//   })

//   val dut = Module(new dut(UInt(8.W)))
//   dut.io.enq <> io.in       // Connect input to dut
//   io.out <> dut.io.deq      // Connect dut to output
// }
