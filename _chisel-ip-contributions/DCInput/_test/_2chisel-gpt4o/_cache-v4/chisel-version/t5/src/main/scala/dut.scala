import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data))
    val deq = Decoupled(data)
  })

  // Registers and wires
  val ready_r = RegInit(true.B)
  val occupied = RegInit(false.B)
  val hold = Reg(data)
  val load = Wire(Bool())
  val drain = Wire(Bool())

  // Data forwarding logic
  drain := occupied && io.deq.ready
  load := io.enq.valid && ready_r && (!io.deq.ready || drain)
  
  // Data handling logic
  io.deq.bits := Mux(occupied, hold, io.enq.bits)
  io.deq.valid := io.enq.valid || occupied
  
  // Control logic
  when(load) {
    hold := io.enq.bits
    occupied := true.B
  }

  when(drain) {
    occupied := false.B
  }

  ready_r := !load && (!occupied || drain)

  // Setting ready signal for input
  io.enq.ready := ready_r
}

