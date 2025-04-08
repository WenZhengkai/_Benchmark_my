import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val dataIn = Input(UInt(4.W))  // 4-bit input data
    val RW = Input(Bool())         // Read/Write control: 1 for read, 0 for write
    val EN = Input(Bool())         // Enable signal
    val EMPTY = Output(Bool())     // Empty flag
    val FULL = Output(Bool())      // Full flag
    val dataOut = Output(UInt(4.W)) // 4-bit output data
  })

  // Task 2: Stack memory and stack pointer initialization
  val stack_mem = RegInit(VecInit(Seq.fill(4)(0.U(4.W)))) // Stack memory with 4 entries, each 4 bits wide
  val SP = RegInit(4.U(3.W))                             // Stack pointer initialized to (pointing to empty position)

  // Synchronous reset logic (Chisel's reset is implicit and initialization handles this)
  when(reset.asBool()) {
    SP := 4.U
    stack_mem := VecInit(Seq.fill(4)(0.U(4.W)))
  }

  // Task 6: Flag updates (EMPTY/FULL)
  val isEmpty = (SP === 4.U)  // EMPTY when stack pointer is at initial position
  val isFull = (SP === 0.U)   // FULL when stack pointer reaches 0

  io.EMPTY := isEmpty
  io.FULL := isFull

  // Task 7: Output data assignment
  val dataOutReg = RegInit(0.U(4.W)) // Register to hold the data being popped
  io.dataOut := dataOutReg

  // Task 4 and Task 5: Push (write) and Pop (read) operations
  when(io.EN) {
    when(io.RW === 0.U && !isFull) { // Write (Push) operation
      // Decrement stack pointer and store data in the stack
      SP := SP - 1.U
      stack_mem(SP - 1.U) := io.dataIn
    }.elsewhen(io.RW === 1.U && !isEmpty) { // Read (Pop) operation
      // Output data from stack, increment stack pointer, and clear the popped stack memory
      dataOutReg := stack_mem(SP)
      stack_mem(SP) := 0.U
      SP := SP + 1.U
    }
  }
}

// Generate the Verilog code for testing
/*
object dutDriver extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut())
}
*/
