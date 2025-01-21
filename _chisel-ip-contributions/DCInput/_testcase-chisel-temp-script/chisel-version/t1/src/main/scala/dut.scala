import chisel3._
import chisel3.util._

class dut[D <: Data](dataType: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(dataType))
    val deq = Decoupled(dataType)
  })

  // Task 1: Set Up Registers and Wires
  val ready_r  = RegInit(true.B) // Ready to accept incoming data
  val occupied = RegInit(false.B) // Tracks whether unsent data is present
  val hold     = Reg(dataType) // Temporarily stores incoming data
  val load = Wire(Bool()) // For combinational logic to determine load conditions
  val drain = Wire(Bool()) // For combinational logic to determine drain conditions

  // Task 2: Implement Data Forwarding Logic
  drain := occupied && io.deq.ready
  load := io.enq.valid && ready_r && (!io.deq.ready || drain)

  // Task 3: Implement Data Handling Logic
  when (occupied) {
    io.deq.bits := hold
  } .otherwise {
    io.deq.bits := io.enq.bits
  }

  io.deq.valid := io.enq.valid || occupied

  // Task 4: Implement Control Logic
  when (load) {
    hold := io.enq.bits
  }

  when (load && !drain) {
    occupied := true.B
  } .elsewhen (drain) {
    occupied := false.B
  }

  ready_r := !load && (!occupied || drain)

  io.enq.ready := ready_r
}
