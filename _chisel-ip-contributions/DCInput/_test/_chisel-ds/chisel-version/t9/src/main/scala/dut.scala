import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data))
    val deq = Decoupled(data)
  })

  // Internal Registers and Wires
  val ready_r = RegInit(true.B)
  val occupied = RegInit(false.B)
  val hold = Reg(data)

  val load = Wire(Bool())
  val drain = Wire(Bool())

  // Data Forwarding Logic
  drain := occupied && io.deq.ready
  load := io.enq.valid && ready_r && (!io.deq.ready || drain)

  // Data Handling Logic
  io.deq.bits := Mux(occupied, hold, io.enq.bits)
  io.deq.valid := occupied || io.enq.valid

  // Control Logic
  when(load) {
    occupied := true.B
    hold := io.enq.bits
  }

  when(drain) {
    occupied := false.B
  }

  // Update ready_r
  ready_r := !occupied || drain

  // Enqueue ready signal
  io.enq.ready := ready_r
}

// Example instantiation with UInt as the data type
/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(UInt(8.W)), args)
}
*/
