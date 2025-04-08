import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val dataIn = Input(UInt(4.W))    // 4-bit input data
    val RW = Input(Bool())          // Read/Write signal (1 = read, 0 = write)
    val EN = Input(Bool())          // Enable signal

    val EMPTY = Output(Bool())      // Buffer empty flag
    val FULL = Output(Bool())       // Buffer full flag
    val dataOut = Output(UInt(4.W)) // 4-bit output data
  })

  // Parameters
  val DEPTH = 4  // Number of stack entries (buffer depth)
  val SP_INIT = DEPTH.U // Initial stack pointer (fully empty)

  // Stack memory and stack pointer
  val stack_mem = RegInit(VecInit(Seq.fill(DEPTH)(0.U(4.W)))) // Initialize memory to 4 x 4-bit entries set to 0
  val SP = RegInit(SP_INIT) // Stack pointer with initial value indicating empty stack

  // Flags for EMPTY and FULL
  io.EMPTY := (SP === DEPTH.U) // Stack pointer at "4" indicates empty state
  io.FULL := (SP === 0.U)      // Stack pointer at "0" indicates full state

  // Default output value
  io.dataOut := 0.U

  // Logic for write (push) and read (pop) operations
  when(reset.asBool) {
    // On reset, clear stack memory and set SP to empty
    for (i <- 0 until DEPTH) {
      stack_mem(i) := 0.U
    }
    SP := SP_INIT
  }.elsewhen(io.EN) { // Enable signal must be high for operations
    when(!io.RW && !io.FULL) { // Write operation (RW = 0, buffer not full)
      stack_mem(SP - 1.U) := io.dataIn // Write data to the current position (SP - 1)
      SP := SP - 1.U                   // Decrement stack pointer after write
    }.elsewhen(io.RW && !io.EMPTY) { // Read operation (RW = 1, buffer not empty)
      io.dataOut := stack_mem(SP)     // Output the value at the current SP
      stack_mem(SP) := 0.U            // Optionally clear the read value
      SP := SP + 1.U                  // Increment stack pointer after read
    }
  }
}

// Generate the Verilog (can be used for testing/verifications)
/*
object dutDriver extends App {
  chisel3.Driver.execute(args, () => new dut)
}
*/
