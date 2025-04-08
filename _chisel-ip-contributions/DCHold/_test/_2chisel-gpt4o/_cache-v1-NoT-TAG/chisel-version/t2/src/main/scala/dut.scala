import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data)) // Input interface (producer)
    val deq = Decoupled(data)          // Output interface (consumer)
  })

  // Task 1: Define and Initialize Registers
  val pValid = RegInit(false.B)
  val pData = Reg(data)

  // Task 2: Implement Data Storage Logic
  // Capture and store incoming data when valid and not already holding data
  when(io.enq.valid && !pValid) {
    pData := io.enq.bits
    pValid := true.B
  }

  // Task 3: Implement Data Release Logic
  // Release and clear stored data when consumer is ready and data is valid
  when(io.deq.ready && pValid) {
    pValid := false.B
  }

  // Task 4: Output Assignments
  io.deq.valid := pValid
  io.deq.bits  := pData
  io.enq.ready := !pValid
}


