import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val dataIn = Input(UInt(4.W))  // 4-bit input data
    val RW = Input(Bool())         // Read/Write control signal (1 for read, 0 for write)
    val EN = Input(Bool())         // Enable signal
    val EMPTY = Output(Bool())     // Empty flag
    val FULL = Output(Bool())      // Full flag
    val dataOut = Output(UInt(4.W)) // 4-bit output data
  })

  // Task 2: Stack Memory and Stack Pointer Initialization
  val stack_mem = RegInit(VecInit(Seq.fill(4)(0.U(4.W)))) // 4-entry stack memory, initialized to 0s
  val SP = RegInit(4.U(3.W))                             // Stack Pointer (3 bits to address 0 to 4), initialized to 4 (empty state)

  // Task 3: Reset Logic
  when(reset.asBool()) {
    SP := 4.U  // Reset Stack Pointer to 4 (indicating empty stack)
    for (i <- 0 until 4) {
      stack_mem(i) := 0.U // Clear stack memory
    }
  }

  // Task 6: Flag Updates (EMPTY/FULL)
  io.EMPTY := (SP === 4.U) // Empty when SP is at its initial value
  io.FULL := (SP === 0.U) // Full when SP reaches 0

  // Task 7: Output Data Assignment
  val dataOutReg = RegInit(0.U(4.W)) // Register to hold output data (default to 0)
  io.dataOut := dataOutReg          // Connect registered output

  // Task 4 & 5: Stack Operations (Push and Pop)
  when(io.EN) {
    when(io.RW === false.B) { // Write (Push)
      when(!io.FULL) { // Proceed if not full
        SP := SP - 1.U                    // Decrement Stack Pointer
        stack_mem(SP - 1.U) := io.dataIn  // Write data into stack
      }
    } .elsewhen(io.RW === true.B) { // Read (Pop)
      when(!io.EMPTY) { // Proceed if not empty
        dataOutReg := stack_mem(SP)  // Read data from stack
        stack_mem(SP) := 0.U         // Clear the stack entry
        SP := SP + 1.U               // Increment Stack Pointer
      }
    }
  }
}
    
/*
object dut extends App {
  println("Generating the dut hardware")
  emitVerilog(new dut(), Array("--target-dir", "generated"))
}
*/
