import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data))  // Input interface
    val deq = Decoupled(data)           // Output interface
  })

  // Internal registers and wires
  val ready_r = RegInit(true.B)
  val occupied = RegInit(false.B)
  val hold = Reg(data.cloneType)
  val load = Wire(Bool())
  val drain = Wire(Bool())

  // Data forwarding logic
  drain := occupied && io.deq.ready
  load := io.enq.valid && ready_r && (!io.deq.ready || drain)

  // Data handling logic
  when(occupied) {
    io.deq.bits := hold
  } .otherwise {
    io.deq.bits := io.enq.bits
  }

  io.deq.valid := io.enq.valid || occupied

  // Control logic
  when(load) {
    occupied := true.B
    hold := io.enq.bits
  } .elsewhen(drain) {
    occupied := false.B
  }

  ready_r := !load && (!occupied || drain)

  // Connecting ready signals
  io.enq.ready := ready_r
}

