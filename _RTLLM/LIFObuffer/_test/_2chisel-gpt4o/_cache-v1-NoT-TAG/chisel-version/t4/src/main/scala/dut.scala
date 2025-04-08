import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val dataIn  = Input(UInt(4.W))  // 4-bit input data
    val RW      = Input(Bool())    // Read/Write control signal
    val EN      = Input(Bool())    // Enable signal
    val EMPTY   = Output(Bool())   // Empty flag
    val FULL    = Output(Bool())   // Full flag
    val dataOut = Output(UInt(4.W)) // 4-bit output data
  })

  // Task 2: Stack memory and stack pointer initialization
  val stack_mem = RegInit(VecInit(Seq.fill(4)(0.U(4.W)))) // 4 words, each 4 bits wide, initialized to 0
  val SP = RegInit(4.U(3.W)) // Stack pointer initialized to 4 (empty stack)

  // Task 3: Reset logic (handled by `RegInit` for SP and stack_mem)

  // Task 6: Flag updates (EMPTY/FULL)
  io.EMPTY := (SP === 4.U) // The stack is empty when SP == 4
  io.FULL  := (SP === 0.U) // The stack is full when SP == 0

  // Register to hold popped data for output
  val dataOutReg = RegInit(0.U(4.W))
  io.dataOut := dataOutReg

  // Task 4 & 5: Push and Pop Operations
  when(io.EN) { // Enable signal must be active
    when(io.RW === false.B) { // Push operation (write)
      when(!io.FULL) { // Only push if the stack is not full
        SP := SP - 1.U // Decrement SP
        stack_mem(SP - 1.U) := io.dataIn // Write data into stack at the new SP
      }
    } .elsewhen(io.RW === true.B) { // Pop operation (read)
      when(!io.EMPTY) { // Only pop if the stack is not empty
        dataOutReg := stack_mem(SP) // Read data from stack at SP
        stack_mem(SP) := 0.U // Clear the popped data (optional)
        SP := SP + 1.U // Increment SP
      }
    }
  }
}
