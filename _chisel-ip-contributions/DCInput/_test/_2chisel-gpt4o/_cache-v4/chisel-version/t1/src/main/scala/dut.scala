import chisel3._
import chisel3.util._

/**
 * DCInput: A Chisel module that implements a decoupled input interface
 * with internal load and store logic, useful for buffering data.
 *
 * @param data The data type (subclass of Data) for the module
 */
class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data)) // Consumer input interface
    val deq = Decoupled(data)          // Producer output interface
  })

  // Registers and Wires
  val ready_r = RegInit(true.B)       // Ready register (initially true)
  val occupied = RegInit(false.B)     // Occupancy state register (initially false)
  val hold = Reg(data.cloneType)      // Register to hold data when occupied
  val load = Wire(Bool())             // Load signal
  val drain = Wire(Bool())            // Drain signal

  // Combinational Logic for Load and Drain
  load := io.enq.valid && ready_r && (!io.deq.ready || drain)
  drain := occupied && io.deq.ready

  // Control Logic for Ready
  ready_r := !load && (!occupied || drain)

  // Data Handling Logic
  when(load) {
    hold := io.enq.bits
    occupied := true.B
  }.elsewhen(drain) {
    occupied := false.B
  }

  // Output Data and Validity
  io.deq.bits := Mux(occupied, hold, io.enq.bits)
  io.deq.valid := io.enq.valid || occupied

  // Ready Signal for the Consumer
  io.enq.ready := ready_r
}

