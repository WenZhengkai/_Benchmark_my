import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(DecoupledIO(data))
    val deq = DecoupledIO(data)
  })

  // Registers
  val ready_r = RegInit(true.B)
  val occupied = RegInit(false.B)
  val hold = Reg(data.cloneType)

  // Wires for control logic
  val load = Wire(Bool())
  val drain = Wire(Bool())

  // Drain: Produce output if the buffer is filled and output is ready
  drain := occupied && io.deq.ready
  
  // Load: Accept input if the input is valid and the module is ready
  load := io.enq.valid && ready_r && (!io.deq.ready || drain)

  // Handling Data
  when (occupied) {
    io.deq.bits := hold
  } .otherwise {
    io.deq.bits := io.enq.bits
  }

  io.deq.valid := io.enq.valid || occupied

  // Update Registers
  when (load) {  // Load new data
    hold := io.enq.bits
    occupied := true.B
  } .elsewhen (drain) {  // Drain data
    occupied := false.B
  }

  ready_r := !occupied || drain || load

  io.enq.ready := ready_r
}

