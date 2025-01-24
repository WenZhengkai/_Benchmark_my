import chisel3._
import chisel3.util._

class dut[D <: Data](dataType: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(DecoupledIO(dataType))
    val deq = DecoupledIO(dataType)
  })

  // Task 1: Define and Initialize Registers
  val pValid = RegInit(false.B) // Holding register valid flag
  val pData = Reg(dataType)     // Register to store data

  // Task 2: Implement Data Storage Logic
  when(io.enq.valid && !pValid) {
    pData := io.enq.bits // Capture data if enq is valid and not holding any data
    pValid := true.B     // Set valid flag
  }

  // Task 3: Implement Data Release Logic
  when(io.deq.ready && pValid) {
    pValid := false.B    // Clear valid flag when output interface is ready to accept data
  }

  // Task 4: Output Assignments
  io.deq.valid := pValid      // Reflect holding status on deq.valid
  io.deq.bits := pData        // Drive deq.bits from stored data
  io.enq.ready := !pValid     // Set enq.ready based on whether we're currently holding data
}



