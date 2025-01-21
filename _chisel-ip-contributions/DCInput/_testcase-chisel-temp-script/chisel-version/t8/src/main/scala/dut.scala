import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(DecoupledIO(data.cloneType))
    val deq = DecoupledIO(data.cloneType)
  })

  // Task 1: Set Up Registers and Wires
  val ready_r = RegInit(true.B)  // Ready to accept incoming data
  val occupied = RegInit(false.B)  // Track if module holds unsent data
  val hold = Reg(data.cloneType)  // Temporarily store incoming data
  val load = Wire(Bool())  // Condition to load data
  val drain = Wire(Bool())  // Condition to drain data

  // Task 2: Implement Data Forwarding Logic
  drain := occupied && io.deq.ready
  load := io.enq.valid && ready_r && (!io.deq.ready || drain)

  // Task 3: Implement Data Handling Logic
  io.deq.bits := Mux(occupied, hold, io.enq.bits)
  io.deq.valid := io.enq.valid || occupied

  // Task 4: Implement Control Logic
  when (load) {
    occupied := true.B
    hold := io.enq.bits
  }.elsewhen (drain) {
    occupied := false.B
  }

  ready_r := !load && (!occupied || drain)
  io.enq.ready := ready_r
}

