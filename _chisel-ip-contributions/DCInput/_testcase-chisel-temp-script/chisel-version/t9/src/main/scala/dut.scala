import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data))
    val deq = Decoupled(data)
  })

  // Task 1: Set Up Registers and Wires
  val ready_r = RegInit(true.B)  // Initialized as true to accept data initially
  val occupied = RegInit(false.B) // Register to track if data is held
  val hold = Reg(data.cloneType)  // Register to hold data temporarily
  val load = Wire(Bool())         // Wire for determining load condition
  val drain = Wire(Bool())        // Wire for determining drain condition

  // Task 2: Implement Data Forwarding Logic
  drain := occupied && io.deq.ready
  load := io.enq.valid && ready_r && (!io.deq.ready || drain)

  // Task 3: Implement Data Handling Logic
  io.deq.bits := Mux(occupied, hold, io.enq.bits)
  io.deq.valid := io.enq.valid || occupied

  // Task 4: Implement Control Logic
  when(load) {
    hold := io.enq.bits
  }

  occupied := Mux(load, true.B, Mux(drain, false.B, occupied))
  ready_r := !load && (!occupied || drain)
  
  // Tie ready signal of input
  io.enq.ready := ready_r
}

