import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val dataIn = Input(UInt(4.W))  // 4-bit input data
    val RW = Input(Bool())        // Read/Write control: 1 for read, 0 for write
    val EN = Input(Bool())        // Enable signal (activates buffer operations)

    val EMPTY = Output(Bool())    // Flag: true if the buffer is empty
    val FULL = Output(Bool())     // Flag: true if the buffer is full
    val dataOut = Output(UInt(4.W)) // 4-bit output data
  })

  // Task 2: Stack Memory and Stack Pointer Initialization
  val stack_mem = RegInit(VecInit(Seq.fill(4)(0.U(4.W)))) // Stack memory (4 entries, 4 bits each)
  val SP = RegInit(4.U(3.W))                             // Stack pointer, initialized to 4 (empty)

  // Task 3: Reset Logic
  when(reset.asBool) {
    SP := 4.U
    stack_mem := VecInit(Seq.fill(4)(0.U))
  }

  // Register to store the output of Pop operation
  val dataOutReg = Reg(UInt(4.W))

  // Task 4: Push Operation (Write)
  when(io.EN && !io.RW) { // EN = 1, RW = 0 (write)
    when(SP =/= 0.U) {    // Ensure the buffer is not full
      SP := SP - 1.U      // Decrement the stack pointer
      stack_mem(SP - 1.U) := io.dataIn // Write data into the buffer
    }
  }

  // Task 5: Pop Operation (Read)
  when(io.EN && io.RW) { // EN = 1, RW = 1 (read)
    when(SP =/= 4.U) {    // Ensure the buffer is not empty
      dataOutReg := stack_mem(SP) // Capture the value at the current SP
      stack_mem(SP) := 0.U        // Clear the stack memory at SP
      SP := SP + 1.U              // Increment the stack pointer
    }
  }

  // Task 6: Flag Updates (EMPTY/FULL)
  io.EMPTY := (SP === 4.U) // Buffer is empty if stack pointer is 4
  io.FULL := (SP === 0.U)  // Buffer is full if stack pointer is 0

  // Task 7: Output Data Assignment
  io.dataOut := dataOutReg // Connect the registered popped value to the output
}

// Generate the Verilog code for the dut module
/*
object dutMain extends App {
  chisel3.Driver.execute(args, () => new dut)
}
*/
