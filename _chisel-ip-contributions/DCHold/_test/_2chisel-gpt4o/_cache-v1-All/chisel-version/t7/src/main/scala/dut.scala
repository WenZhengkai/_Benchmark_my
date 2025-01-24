import chisel3._
import chisel3.util._

class dut[D <: Data](dataType: D) extends Module {
  // Input and Output Interfaces
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(dataType))
    val deq = Decoupled(dataType)
  })

  // Task 1: Define and Initialize Registers
  val pValid = RegInit(false.B) // Initialize pValid to false
  val pData = Reg(dataType) // Define pData register, uninitialized

  // Task 2: Implement Data Storage Logic
  when(io.enq.valid && !pValid) {
    pData := io.enq.bits // Latch incoming data
    pValid := true.B // Set pValid to true
  }

  // Task 3: Implement Data Release Logic
  when(io.deq.ready && pValid) {
    pValid := false.B // Clear pValid to false
  }

  // Task 4: Output Assignments
  io.deq.valid := pValid // Set deq.valid to pValid
  io.deq.bits := pData // Assign deq.bits to pData
  io.enq.ready := !pValid // Set enq.ready to the negation of pValid
}

// Generate Verilog code and test

