import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(DecoupledIO(data))
    val deq = DecoupledIO(data)
  })

  // Registers and initializations
  val ready_r = RegInit(true.B)
  val occupied = RegInit(false.B)
  val hold = Reg(data.cloneType)

  // Wires for load and drain conditions
  val load = Wire(Bool())
  val drain = Wire(Bool())

  // Load condition: New data can be loaded if the input is valid, ready_r is high, and either 
  // the output is not ready or drain condition is true.
  load := io.enq.valid && ready_r && (!io.deq.ready || drain)

  // Drain condition: Data can be output if there is data occupied and output is ready.
  drain := occupied && io.deq.ready

  // Data Handling Logic
  when(load) {
    hold := io.enq.bits
    occupied := true.B
  }

  when(drain) {
    occupied := false.B
  }

  // Determine ready signal based on current state
  ready_r := !load && (!occupied || drain)

  // Output logic
  io.deq.bits := Mux(occupied, hold, io.enq.bits)
  io.deq.valid := io.enq.valid || occupied
  io.enq.ready := ready_r
}


