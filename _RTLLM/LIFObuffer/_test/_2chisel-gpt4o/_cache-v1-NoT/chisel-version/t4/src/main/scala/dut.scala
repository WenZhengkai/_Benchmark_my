import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val dataIn  = Input(UInt(4.W))   // 4-bit data input
    val RW      = Input(Bool())     // Read/Write control signal (1 for read, 0 for write)
    val EN      = Input(Bool())     // Enable signal to activate buffer operations
    val EMPTY   = Output(Bool())    // Flag indicating whether the buffer is empty
    val FULL    = Output(Bool())    // Flag indicating whether the buffer is full
    val dataOut = Output(UInt(4.W)) // 4-bit data output
  })

  // Internal stack memory (4 entries, 4 bits wide)
  val stack_mem = RegInit(VecInit(Seq.fill(4)(0.U(4.W))))

  // Stack pointer (register to track the position in the stack)
  val SP = RegInit(4.U(3.W)) // 3-bit wide to index 0 to 4, reset to 4 (empty state)

  // EMPTY and FULL flags
  io.EMPTY := (SP === 4.U) // EMPTY when stack pointer is 4
  io.FULL  := (SP === 0.U) // FULL when stack pointer is 0

  // Default output
  io.dataOut := 0.U

  when(reset.asBool) { // Reset logic triggered by reset signal
    // Clear the stack memory
    for (i <- 0 until 4) {
      stack_mem(i) := 0.U
    }
    SP := 4.U // Reset stack pointer to 4 (empty state)
  } .elsewhen(io.EN) { // Enable signal is high
    when(io.RW) { // Read operation when RW = 1
      when(!io.EMPTY) { // Ensure the buffer is not empty
        io.dataOut := stack_mem(SP)  // Read data from the stack (current SP position)
        stack_mem(SP) := 0.U         // Optional: Clear the data at SP
        SP := SP + 1.U               // Increment stack pointer (pop operation)
      }
    } .otherwise { // Write operation when RW = 0
      when(!io.FULL) { // Ensure the buffer is not full
        SP := SP - 1.U               // Decrement stack pointer (push operation)
        stack_mem(SP) := io.dataIn   // Write data into the stack (at SP - 1 position)
      }
    }
  }
}

/*
object dut extends App {
  // Generate Verilog for the dut module
  (new chisel3.stage.ChiselStage).emitVerilog(new dut)
}
*/
