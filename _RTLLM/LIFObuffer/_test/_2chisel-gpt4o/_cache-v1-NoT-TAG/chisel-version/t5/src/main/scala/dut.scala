import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val dataIn = Input(UInt(4.W))  // 4-bit input for data
    val RW = Input(Bool())         // Read/Write control: 1 for Read, 0 for Write
    val EN = Input(Bool())         // Enable signal
    val EMPTY = Output(Bool())     // Empty flag
    val FULL = Output(Bool())      // Full flag
    val dataOut = Output(UInt(4.W)) // 4-bit output for data
  })

  // Task 2: Declare stack memory and stack pointer
  val stack_mem = RegInit(VecInit(Seq.fill(4)(0.U(4.W)))) // 4-entry stack memory, each entry is 4 bits wide
  val SP = RegInit(4.U(3.W)) // Stack Pointer, initialized to 4 (empty)

  // Task 3: Reset logic
  // Reset logic is automatically handled with RegInit by initializing stack_mem and SP

  // Registers
  val dataOutReg = RegInit(0.U(4.W)) // Register to hold the popped data for output

  // Task 4: Push Operation (Write)
  when(io.EN && !io.RW) { // Enable and Write mode (RW = 0)
    when(SP =/= 0.U) { // Check if stack is not full
      SP := SP - 1.U // Decrement Stack Pointer
      stack_mem(SP - 1.U) := io.dataIn // Write data to stack
    }
  }

  // Task 5: Pop Operation (Read)
  when(io.EN && io.RW) { // Enable and Read mode (RW = 1)
    when(SP =/= 4.U) { // Check if stack is not empty
      dataOutReg := stack_mem(SP) // Store top of stack (to be output)
      stack_mem(SP) := 0.U // Clear the top of stack
      SP := SP + 1.U // Increment Stack Pointer
    }
  }

  // Task 6: Flag Updates
  io.EMPTY := (SP === 4.U) // Stack is empty if SP = 4
  io.FULL := (SP === 0.U) // Stack is full if SP = 0

  // Task 7: Output Data Assignment
  io.dataOut := dataOutReg // Connect dataOut to dataOutReg
}

// Test the module
/*
object dut extends App {
  chisel3.Driver.execute(args, () => new dut)
}
*/
