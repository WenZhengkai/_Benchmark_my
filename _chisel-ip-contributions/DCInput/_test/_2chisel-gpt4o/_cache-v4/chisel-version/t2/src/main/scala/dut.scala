import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data))
    val deq = Decoupled(data)
  })

  // Registers & Wires
  val ready_r = RegInit(true.B)
  val occupied = RegInit(false.B)
  val hold = Reg(data)
  val load = Wire(Bool())
  val drain = Wire(Bool())

  // Load and Drain Logic
  load := io.enq.valid && ready_r && (!io.deq.ready || drain)
  drain := occupied && io.deq.ready

  // Data Handling Logic
  when(load) {
    hold := io.enq.bits
  }

  io.deq.bits := Mux(occupied, hold, io.enq.bits)
  io.deq.valid := io.enq.valid || occupied

  // Control Logic
  when(load) {
    occupied := true.B
  } .elsewhen(drain) {
    occupied := false.B
  }

  ready_r := !load && (!occupied || drain)

  // Connect ready for enq
  io.enq.ready := ready_r
}


