import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val dataIn = Input(UInt(4.W))    // 4-bit input data
    val RW = Input(Bool())          // Read/Write control signal (1 for read, 0 for write)
    val EN = Input(Bool())          // Enable signal
    val EMPTY = Output(Bool())      // Buffer EMPTY flag
    val FULL = Output(Bool())       // Buffer FULL flag
    val dataOut = Output(UInt(4.W)) // 4-bit output data
  })

  // Stack memory (4 entries, each 4-bit wide)
  val stack_mem = RegInit(VecInit(Seq.fill(4)(0.U(4.W))))
  
  // Stack Pointer (SP) - 3-bit register, initialized to 4 (indicating an empty buffer)
  val SP = RegInit(4.U(3.W))

  // FULL flag is asserted when SP is 0
  io.FULL := SP === 0.U

  // EMPTY flag is asserted when SP is 4
  io.EMPTY := SP === 4.U

  // Default output value for dataOut - ensure it holds a stable value
  io.dataOut := 0.U

  // Define the clocked logic
  when(io.EN) { // Enable signal must be high for any operation
    when(reset.asBool) { // Handle reset signal
      // On reset, clear the stack memory and set SP to 4
      SP := 4.U
      for (i <- 0 until 4) {
        stack_mem(i) := 0.U
      }
    }.elsewhen(io.RW) { // Read operation (RW = 1)
      when(!io.EMPTY) { // Only read if the buffer is not empty
        io.dataOut := stack_mem(SP) // Read the value at the current SP
        stack_mem(SP) := 0.U        // Optionally clear the value after reading
        SP := SP + 1.U              // Increment the Stack Pointer
      }
    }.otherwise { // Write operation (RW = 0)
      when(!io.FULL) { // Only write if the buffer is not full
        SP := SP - 1.U              // Decrement the Stack Pointer
        stack_mem(SP) := io.dataIn  // Write dataIn to the current SP position
      }
    }
  }
}

// Generate the Verilog code for the dut module
/*
object dutDriver extends App {
  chisel3.Driver.execute(args, () => new dut)
}
*/
