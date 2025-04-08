import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val dataIn = Input(UInt(4.W))  // 4-bit input data
    val RW = Input(Bool())         // Read/Write control (1 for read, 0 for write)
    val EN = Input(Bool())         // Enable signal

    val EMPTY = Output(Bool())     // Indicates if the buffer is empty
    val FULL = Output(Bool())      // Indicates if the buffer is full
    val dataOut = Output(UInt(4.W))// 4-bit output data
  })

  // Task 2: Stack Memory and Stack Pointer Initialization
  val stack_mem = RegInit(VecInit(Seq.fill(4)(0.U(4.W))))  // 4-stack entries, each 4-bits wide
  val SP = RegInit(4.U(3.W))                               // Stack pointer, initialized to 4

  // Task 6: Flag Updates (EMPTY/FULL)
  io.EMPTY := (SP === 4.U)   // Buffer is empty when SP points to 4 (no data)
  io.FULL := (SP === 0.U)    // Buffer is full when SP points to 0 (max capacity)

  // Task 7: Output Data Assignment
  val dataOutReg = RegInit(0.U(4.W))  // Register to store popped data
  io.dataOut := dataOutReg            // Connect popped data to output

  // Task 3: Reset Logic (Handled by RegInit above)

  // Default values for SP and dataOutReg
  when(reset.asBool()) {
    SP := 4.U
    dataOutReg := 0.U
  }

  // Task 4: Push Operation (Write)
  when(io.EN && !io.RW) { // Enable signal active and RW (write mode)
    when(!io.FULL) {      // Check if the buffer is not full
      SP := SP - 1.U                           // Decrement stack pointer
      stack_mem(SP - 1.U) := io.dataIn          // Store input data at new SP location
    }
  }

  // Task 5: Pop Operation (Read)
  when(io.EN && io.RW) { // Enable signal active and RW (read mode)
    when(!io.EMPTY) {    // Check if the buffer is not empty
      dataOutReg := stack_mem(SP)             // Capture data from top of the stack
      stack_mem(SP) := 0.U                    // Clear the data at current SP location
      SP := SP + 1.U                          // Increment stack pointer
    }
  }
}

// Generate Verilog for the dut module for testing
/*
object dutDriver extends App {
  chisel3.Driver.execute(args, () => new dut())
}
*/
