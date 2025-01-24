import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(DecoupledIO(data))
    val deq = DecoupledIO(data)
  })

  // Task 1: Define and Initialize Registers
  val pValid = RegInit(false.B)     // Holds the validation state of the data.
  val pData = Reg(data)             // Holds the data; uninitialized initially.

  // Task 2: Implement Data Storage Logic
  when(io.enq.valid && !pValid) {
    pData := io.enq.bits          // Capturing incoming data.
    pValid := true.B              // Mark the data as valid.
  }

  // Task 3: Implement Data Release Logic
  when(io.deq.ready && pValid) {
    pValid := false.B             // Clear the valid flag when data is dequeued.
  }

  // Task 4: Output Assignments
  io.deq.valid := pValid          // Data is valid if pValid is true.
  io.deq.bits := pData            // Output the stored data.
  io.enq.ready := !pValid         // Ready to accept new data if no data is currently held.
}
