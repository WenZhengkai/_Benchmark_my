import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(DecoupledIO(data))
    val deq = DecoupledIO(data)
  })

  // Registers and Wires
  val ready_r = RegInit(true.B)
  val occupied = RegInit(false.B)
  val hold = Reg(data.cloneType)
  val load = Wire(Bool())
  val drain = Wire(Bool())

  // Load condition
  load := io.enq.valid && ready_r && (!io.deq.ready || drain)
  
  // Drain condition
  drain := occupied && io.deq.ready

  // Data Handling Logic
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

  // Ready condition: not in load and either not occupied or in drain
  ready_r := !load && (!occupied || drain)
  io.enq.ready := ready_r
}

