import chisel3._
import chisel3.util._

/**
 * A 4-bit wide, 4-entry deep Last-In-First-Out (LIFO) buffer with push and pop operations.
 */
class dut extends Module {
  val io = IO(new Bundle {
    val dataIn = Input(UInt(4.W))   // 4-bit input data
    val RW = Input(Bool())         // Read/Write (1 = read, 0 = write)
    val EN = Input(Bool())         // Enable signal
    val EMPTY = Output(Bool())     // Empty flag
    val FULL = Output(Bool())      // Full flag
    val dataOut = Output(UInt(4.W)) // 4-bit output data
  })

  // Stack memory: 4 entries, each 4-bit wide
  val stack_mem = RegInit(VecInit(Seq.fill(4)(0.U(4.W))))
  
  // Stack pointer (SP) to navigate the stack: 3 bits (0 to 4)
  val SP = RegInit(4.U(3.W)) // Starts at 4 (empty buffer)

  // Initialize EMPTY and FULL flags
  io.EMPTY := (SP === 4.U)
  io.FULL := (SP === 0.U)
  
  // Default dataOut value is 0 (nothing to output)
  io.dataOut := 0.U

  // Clock-based operation
  when (io.EN) { // Enable signal gates operations
    when (!reset.asBool) { // Ensure reset logic is prioritized
      when (io.RW === false.B && !io.FULL) { // Write (push) operation
        stack_mem(SP - 1.U) := io.dataIn   // Push data to the stack
        SP := SP - 1.U                     // Decrement stack pointer
      } .elsewhen (io.RW === true.B && !io.EMPTY) { // Read (pop) operation
        io.dataOut := stack_mem(SP)       // Read data from the stack
        stack_mem(SP) := 0.U              // Optional: clear popped data
        SP := SP + 1.U                    // Increment stack pointer
      }
    }
  }

  // Reset logic to reinitialize the stack and stack pointer
  when (reset.asBool) { // Active high reset
    stack_mem := VecInit(Seq.fill(4)(0.U(4.W))) // Clear stack entries
    SP := 4.U                                 // Reset stack pointer to empty
  }
}

// Generate the Verilog code
/*
object dutMain extends App {
  println("Generating the dut Verilog code...")
  (new chisel3.stage.ChiselStage).emitVerilog(new dut, Array("--target-dir", "generated"))
}
*/
