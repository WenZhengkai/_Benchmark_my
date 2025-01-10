import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(DecoupledIO(data)) // Input interface
    val deq = DecoupledIO(data)          // Output interface
  })

  // Internal registers and wires
  val ready_r = RegInit(true.B)
  val occupied = RegInit(false.B)
  val hold = Reg(data)
  
  // Combinational logic for load and drain
  val load = io.enq.valid && ready_r && (!io.deq.ready || io.deq.valid)
  val drain = occupied && io.deq.ready

  // Output logic
  io.deq.bits := Mux(occupied, hold, io.enq.bits)
  io.deq.valid := io.enq.valid || occupied

  // Ready logic
  ready_r := (!occupied && !load) || (drain && !load)
  io.enq.ready := ready_r

  // State updates
  when(load) {
    hold := io.enq.bits
  }

  when(drain) {
    occupied := false.B
  }

  when(load) {
    occupied := true.B
  }
}

