import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data))
    val deq = Decoupled(data)
  })

  // Registers to hold valid data and indicate the presence of valid data
  val pValid = RegInit(false.B)
  val pData = Reg(data)

  // Output assignment
  io.deq.valid := pValid
  io.deq.bits := pData
  io.enq.ready := !pValid

  // State transition logic
  when(io.enq.valid && io.enq.ready) {
    // Capture data when there is valid input and we're ready to accept it
    pData := io.enq.bits
    pValid := true.B
  }

  when(io.deq.valid && io.deq.ready) {
    // Clear valid flag when data has been successfully dequeued
    pValid := false.B
  }
}

