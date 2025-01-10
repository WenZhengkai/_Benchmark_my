import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(DecoupledIO(data))
    val deq = DecoupledIO(data)
  })

  // Registers and wires
  val ready_r = RegInit(true.B)
  val occupied = RegInit(false.B)
  val hold = Reg(data.cloneType)
  val load = Wire(Bool())
  val drain = Wire(Bool())

  // Load condition: ready to accept new data
  load := io.enq.valid && ready_r && (!io.deq.ready || drain)
  
  // Drain condition: ready to output data
  drain := occupied && io.deq.ready

  // Data handling logic
  when(load) {
    hold := io.enq.bits
  }

  io.deq.bits := Mux(occupied, hold, io.enq.bits)
  io.deq.valid := io.enq.valid || occupied

  // Control logic
  when(load) {
    occupied := true.B
  }.elsewhen(drain) {
    occupied := false.B
  }

  // Update ready signal
  ready_r := (!occupied && !load) || (drain && !load)
  io.enq.ready := ready_r
}


