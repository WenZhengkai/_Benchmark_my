

import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data)) // Input interface
    val deq = Decoupled(data)          // Output interface
  })

  /* Task 1: Register and Wire Declaration */
  val ready_r = RegInit(true.B)       // Input readiness flag
  val occupied = RegInit(false.B)     // Buffer occupancy status
  val hold = Reg(data)                // Temporary buffer for data storage
  val load = Wire(Bool())             // Load enable signal
  val drain = Wire(Bool())            // Drain enable signal

  /* Task 2: Load/Drain Condition Logic */
  drain := occupied && io.deq.ready    // Drain when buffer is occupied and consumer is ready
  load := io.enq.valid && ready_r && (!io.deq.ready || drain) // Load when input is valid and conditions are met

  /* Task 3: Data Buffer Management */
  when(load) {
    hold := io.enq.bits               // Store incoming data in the buffer
  }

  /* Task 4: Occupied State Control */
  when(drain) {
    occupied := false.B               // Clear buffer when data is drained
  }.elsewhen(load) {
    occupied := true.B                // Mark buffer as occupied when data is loaded
  }

  /* Task 5: Readiness Flag Update */
  ready_r := (!occupied && !load) || (drain && !load) // Update readiness dynamically based on conditions

  /* Task 6: Output Data Multiplexing */
  io.deq.bits := Mux(occupied, hold, io.enq.bits) // Select buffer or passthrough input
  io.deq.valid := occupied || (io.enq.valid && ready_r) // Output valid flag based on occupancy and readiness

  /* Task 7: Interface Signal Binding */
  io.enq.ready := ready_r // Bind input ready signal

  /* Task 8: Concurrency Validation */
  // Add an assertion to detect undefined simultaneous load-drain behavior
  assert(!(load && drain), "Simultaneous load and drain detected; undefined behavior!")
}

// Testbench or Integration (optional)
// You can add a simple testbench wrapper around this to verify functionality during simulation.
// For example:
// object dutDriver extends App {
//   (new chisel3.stage.ChiselStage).emitVerilog(new dut(UInt(32.W)))
// }
