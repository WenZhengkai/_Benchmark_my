import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val dataIn  = Input(UInt(4.W))     // 4-bit input data to push onto the buffer
    val RW      = Input(Bool())       // Read/Write control signal (1 for read, 0 for write)
    val EN      = Input(Bool())       // Enable signal for operations
    val EMPTY   = Output(Bool())      // EMPTY flag
    val FULL    = Output(Bool())      // FULL flag
    val dataOut = Output(UInt(4.W))   // 4-bit output data popped from the buffer
  })

  // Internal stack memory (4 x 4-bit)
  val stack_mem = RegInit(VecInit(Seq.fill(4)(0.U(4.W))))
  // Stack pointer: Indicates top of stack (0-4 range, 3 bits required)
  val SP = RegInit(4.U(3.W))

  // Flags for EMPTY and FULL status
  io.EMPTY := (SP === 4.U) // EMPTY flag: SP points to top of the stack
  io.FULL  := (SP === 0.U) // FULL flag: SP points to the bottom of the stack

  // Default output data
  io.dataOut := 0.U

  // With clock and reset logic
  when(reset.asBool) {
    // When reset is high:
    // Clear stack memory and set SP to top (4)
    stack_mem.foreach { entry => entry := 0.U }
    SP := 4.U
  } .elsewhen(io.EN) {
    when(io.RW) {
      // Read operation (pop from the stack)
      when(!io.EMPTY) { // Only if stack is not empty
        io.dataOut := stack_mem(SP)  // Output the data at SP
        stack_mem(SP) := 0.U         // Optionally clear the current SP value
        SP := SP + 1.U               // Increment SP (move up in stack)
      }
    } .otherwise {
      // Write operation (push onto the stack)
      when(!io.FULL) { // Only if stack is not full
        SP := SP - 1.U               // Decrement SP (move down in stack)
        stack_mem(SP - 1.U) := io.dataIn // Write input data to stack
      }
    }
  }
}

// Testbench to help validate the dut
/*
object dutMain extends App {
  println("Generating the dut hardware")
  (new chisel3.stage.ChiselStage).emitVerilog(new dut())
}
*/
