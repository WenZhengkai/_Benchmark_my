import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val dataIn = Input(UInt(4.W))   // 4-bit input data to be pushed
    val RW = Input(Bool())         // Read/Write control signal (1 for read, 0 for write)
    val EN = Input(Bool())         // Enable signal for buffer operations
    val EMPTY = Output(Bool())     // Flag indicating whether the buffer is empty
    val FULL = Output(Bool())      // Flag indicating whether the buffer is full
    val dataOut = Output(UInt(4.W))// 4-bit output data retrieved from the stack
  })

  // Task 1: Declare internal memory and stack pointer
  val stack_mem = RegInit(VecInit(Seq.fill(4)(0.U(4.W)))) // Stack memory: 4 entries of 4 bits each
  val SP = RegInit(4.U(3.W))                             // Stack pointer (3 bits): Initial value 4 (empty)

  // Task 5: Set EMPTY and FULL flags based on stack pointer (SP)
  io.EMPTY := (SP === 4.U) // Stack is empty when SP equals 4
  io.FULL := (SP === 0.U)  // Stack is full when SP equals 0

  // Task 2: Handle reset behavior
  when(reset.asBool) {
    // Clear the stack memory and reset stack pointer
    for (i <- 0 until 4) {
      stack_mem(i) := 0.U
    }
    SP := 4.U
  } .elsewhen(io.EN) { // Process only if enable signal is high
    when(io.RW && !io.EMPTY) { // Task 4: Read operation
      io.dataOut := stack_mem(SP)
      stack_mem(SP) := 0.U // Optionally clear the value
      SP := SP + 1.U       // Increment stack pointer
    } .elsewhen(!io.RW && !io.FULL) { // Task 3: Write operation
      SP := SP - 1.U                        // Decrement stack pointer
      stack_mem(SP) := io.dataIn            // Write input data to stack
    } .otherwise {
      io.dataOut := 0.U // No valid output data for invalid operations
    }
  } .otherwise {
    io.dataOut := 0.U // Inactive `EN` defaults `dataOut` to 0
  }
}

// Generate Verilog
/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut())
}
*/
