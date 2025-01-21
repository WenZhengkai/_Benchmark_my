import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data))
    val deq = Decoupled(data)
  })

  // Task 1: Set Up Registers and Wires
  val ready_r = RegInit(true.B) // Indicate readiness to accept incoming data
  val occupied = RegInit(false.B) // Track whether the module currently holds unsent data
  val hold = Reg(data) // Temporarily store incoming data

  val load = Wire(Bool()) // Combinational logic to manage data load condition
  val drain = Wire(Bool()) // Combinational logic to manage data drain condition

  // Task 2: Implement Data Forwarding Logic
  drain := occupied && io.deq.ready
  load := io.enq.valid && ready_r && (!io.deq.ready || drain)

  // Task 3: Implement Data Handling Logic
  io.deq.bits := Mux(occupied, hold, io.enq.bits)
  io.deq.valid := io.enq.valid || occupied

  // Task 4: Implement Control Logic
  when(load) {
    hold := io.enq.bits // Update hold with new data when load condition is met
  }

  when(load) {
    occupied := true.B // Occupied if load condition is met
  } .elsewhen(drain) {
    occupied := false.B // Not occupied if drain condition occurs
  }

  ready_r := !load && (!occupied || drain)
  io.enq.ready := ready_r
}
