import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val dataIn = Input(UInt(4.W)) // 4-bit input data
    val RW = Input(Bool())        // Read/Write control signal
    val EN = Input(Bool())        // Enable signal
    val EMPTY = Output(Bool())    // Empty flag
    val FULL = Output(Bool())     // Full flag
    val dataOut = Output(UInt(4.W)) // 4-bit output data
  })

  // Internal stack memory (4 entries, each 4 bits wide)
  val stackMem = RegInit(VecInit(Seq.fill(4)(0.U(4.W))))
  val stackPtr = RegInit(4.U(3.W)) // Stack pointer (0-4, 4 indicates empty)
  val empty = stackPtr === 4.U    // Empty flag
  val full = stackPtr === 0.U      // Full flag

  // Update EMPTY and FULL flags
  io.EMPTY := empty
  io.FULL := full

  // Reset logic
  when(reset.asBool) {
    stackMem.foreach(_ := 0.U) // Clear stack memory
    stackPtr := 4.U            // Reset stack pointer to indicate empty
  }.otherwise {
    when(io.EN) {
      when(!io.RW && !full) { // Write operation (push)
        stackMem(stackPtr - 1.U) := io.dataIn // Push data onto the stack
        stackPtr := stackPtr - 1.U            // Decrement stack pointer
      }.elsewhen(io.RW && !empty) { // Read operation (pop)
        io.dataOut := stackMem(stackPtr) // Pop data from the stack
        stackMem(stackPtr) := 0.U       // Clear the popped memory location
        stackPtr := stackPtr + 1.U      // Increment stack pointer
      }
    }
  }
}

// Generate Verilog
/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(), args)
}
*/
