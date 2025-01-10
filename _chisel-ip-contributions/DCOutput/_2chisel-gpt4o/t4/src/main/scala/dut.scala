import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(DecoupledIO(data))
    val deq = DecoupledIO(data)
  })

  // Register to hold valid state of output
  val rValid = RegInit(false.B)

  // Combinatorial logic for ready signal
  io.enq.ready := io.deq.ready || !rValid

  // Update logic for valid register (rValid)
  when(io.enq.fire) {
    rValid := true.B
  } .elsewhen(io.deq.ready) {
    rValid := false.B
  }

  // Data transfer logic with registred enable transfer
  // Transfers data from enq.bits to deq.bits
  io.deq.bits := RegEnable(next = io.enq.bits, enable = io.enq.fire)
  
  // Setting the valid signal for the output interface
  io.deq.valid := rValid
}


