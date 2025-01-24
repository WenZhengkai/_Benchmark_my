import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data)) // Input interface
    val deq = Decoupled(data) // Output interface
  })

  // Task 1: Define and Initialize Registers
  val pValid = RegInit(false.B) // Initially, no valid data is held
  val pData = Reg(data) // Holds the data of generic type D

  // Task 2: Implement Data Storage Logic
  when(io.enq.valid && !pValid) {
    pData := io.enq.bits
    pValid := true.B
  }

  // Task 3: Implement Data Release Logic
  when(io.deq.ready && pValid) {
    pValid := false.B
  }

  // Task 4: Output Assignments
  io.deq.valid := pValid
  io.deq.bits := pData
  io.enq.ready := !pValid
}


