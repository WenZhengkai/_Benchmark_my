import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(DecoupledIO(data))
    val deq = DecoupledIO(data)
  })

  // Register to hold valid status of the data
  val rValid = RegInit(false.B)

  // Ready logic for the enqueue interface
  io.enq.ready := io.deq.ready || !rValid

  // Valid register logic
  when(io.enq.fire) {
    rValid := true.B
  } .elsewhen(io.deq.ready) {
    rValid := false.B
  }

  // Data transfer from enqueue to output bits using register enable
  val rBits = RegEnable(io.enq.bits, io.enq.fire)

  // Output valid signal
  io.deq.valid := rValid

  // Assign registered bits to the dequeue interface
  io.deq.bits := rBits
}

