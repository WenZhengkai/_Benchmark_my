import chisel3._
import chisel3.util._

class dut[D <: Data](dataType: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(DecoupledIO(dataType)) // Input interface: enq
    val deq = DecoupledIO(dataType)          // Output interface: deq
  })

  // Task 1: Define and Initialize Registers
  val pValid = RegInit(false.B)       // Register to indicate if data is valid
  val pData = Reg(dataType)           // Register to hold data

  // Task 2: Implement Data Storage Logic
  when(io.enq.valid && !pValid) {
    pData := io.enq.bits   // Capture incoming data
    pValid := true.B       // Set pValid to indicate data is held
  }

  // Task 3: Implement Data Release Logic
  when(io.deq.ready && pValid) {
    pValid := false.B      // Clear valid flag when data is forwarded
    // Optionally reset pData if needed here, but not mandatory
  }

  // Task 4: Output Assignments
  io.deq.valid := pValid          // Output valid mirrors pValid
  io.deq.bits := pData            // Output bits drive from pData
  io.enq.ready := !pValid         // Input ready is high when no data is held
}
