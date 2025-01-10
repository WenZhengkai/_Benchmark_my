import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(DecoupledIO(data))
    val deq = DecoupledIO(data)
  })

  // Internal state registers
  val ready_r = RegInit(true.B)
  val occupied = RegInit(false.B)
  val hold = Reg(data.cloneType)

  // Combinational logic to determine load and drain conditions
  val load = Wire(Bool())
  val drain = Wire(Bool())

  // Load condition: New data is available, module is ready to accept it,
  // and either the downstream is not ready, or it is ready and draining
  load := io.enq.valid && ready_r && (!io.deq.ready || drain)

  // Drain condition: Module is occupied with data, and downstream is ready
  drain := occupied && io.deq.ready

  // Data forwarding logic
  io.deq.bits := Mux(occupied, hold, io.enq.bits)
  io.deq.valid := io.enq.valid || occupied

  // Control logic to handle the flow of data
  when(load) {
    hold := io.enq.bits
    occupied := true.B
  } .elsewhen(drain) {
    occupied := false.B
  }

  // Determine if the module is ready to accept new data
  ready_r := (!occupied && !load) || (drain && !load)
  io.enq.ready := ready_r
}

