import chisel3._
import chisel3.util._

class dut[D <: Data](gen: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(gen))  // Input enqueue interface
    val deq = Decoupled(gen)           // Output dequeue interface
  })

  // Task 1: Define and Initialize Registers
  val pValid = RegInit(false.B)      // Register to hold the validity of pData
  val pData = Reg(gen)               // Register to hold the data payload

  // Task 2: Implement Data Storage Logic
  when(io.enq.valid && !pValid) {
    // Latch incoming data into pData and set pValid to true when enq.valid is asserted
    pData := io.enq.bits
    pValid := true.B
  }

  // Task 3: Implement Data Release Logic
  when(io.deq.ready && pValid) {
    // Clear pValid to false when data is released
    pValid := false.B
  }

  // Task 4: Output Assignments
  io.deq.valid := pValid              // Drive io.deq.valid from pValid
  io.deq.bits := pData                // Drive io.deq.bits from pData
  io.enq.ready := !pValid             // Drive io.enq.ready with negation of pValid
}

