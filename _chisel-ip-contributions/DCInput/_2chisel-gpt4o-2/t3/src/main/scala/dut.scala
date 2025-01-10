import chisel3._
import chisel3.util._

class dut[D <: Data](dataType: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(dataType))
    val deq = Decoupled(dataType)
  })

  // Registers and internal wires
  val ready_r = RegInit(true.B)
  val occupied = RegInit(false.B)
  val hold = Reg(dataType)
  val load = Wire(Bool())
  val drain = Wire(Bool())

  // Data forwarding logic
  drain := occupied && io.deq.ready
  load := io.enq.valid && ready_r && (!io.deq.ready || drain)
  
  // Data handling logic
  io.deq.bits := Mux(occupied, hold, io.enq.bits)
  io.deq.valid := io.enq.valid || occupied

  // Control logic
  when (load) {
    occupied := true.B
    hold := io.enq.bits
  } .elsewhen (drain) {
    occupied := false.B
  }

  ready_r := (!occupied && !load) || (drain && !load)
  io.enq.ready := ready_r
}

// To use this module, instantiate it with a concrete data type, e.g.:
// val myDCInput = Module(new DCInput(UInt(8.W)))
