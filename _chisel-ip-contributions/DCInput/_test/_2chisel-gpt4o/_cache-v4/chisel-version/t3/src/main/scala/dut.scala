import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  // Define the module's I/O
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data))
    val deq = Decoupled(data)
  })

  // Registers and wires for internal logic
  val ready_r = RegInit(true.B)
  val occupied = RegInit(false.B)
  val hold = Reg(data.cloneType)

  // Wires for load and drain conditions
  val load = Wire(Bool())
  val drain = Wire(Bool())

  // Define the load and drain conditions
  load := io.enq.valid && ready_r && (!io.deq.ready || drain)
  drain := occupied && io.deq.ready

  // Data forwarding logic
  io.deq.bits := Mux(occupied, hold, io.enq.bits)
  io.deq.valid := io.enq.valid || occupied

  // Control Logic
  when(load) {
    hold := io.enq.bits
    occupied := true.B
  }

  when(drain) {
    occupied := false.B
  }

  ready_r := !load && (!occupied || drain)

  // Connect ready signal to the input interface
  io.enq.ready := ready_r
}


