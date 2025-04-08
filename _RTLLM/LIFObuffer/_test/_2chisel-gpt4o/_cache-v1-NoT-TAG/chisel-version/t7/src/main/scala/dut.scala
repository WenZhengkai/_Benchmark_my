import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    // Input ports
    val dataIn = Input(UInt(4.W))      // 4-bit input data
    val RW = Input(Bool())            // Read/Write control signal: 1 for read, 0 for write
    val EN = Input(Bool())            // Enable signal to activate buffer operations

    // Output ports
    val EMPTY = Output(Bool())        // Flag indicating buffer is empty
    val FULL = Output(Bool())         // Flag indicating buffer is full
    val dataOut = Output(UInt(4.W))   // 4-bit output data retrieved from buffer
  })

  // Stack memory (4 entries of 4-bit wide)
  val stack_mem = RegInit(VecInit(Seq.fill(4)(0.U(4.W))))
  
  // Stack Pointer (SP) with 3 bits to represent values from 0 to 4 (inclusive)
  val SP = RegInit(4.U(3.W))

  // Output register for holding the popped data
  val dataOutReg = RegInit(0.U(4.W))

  // Flags for empty and full conditions (combinational logic)
  io.EMPTY := (SP === 4.U)
  io.FULL := (SP === 0.U)

  // Default output value
  io.dataOut := dataOutReg

  // Push Operation (Write)
  when(io.EN && !io.RW && !io.FULL) { // Check: Enable is on, RW = 0 (write), and buffer is not full
    SP := SP - 1.U                   // Decrement Stack Pointer
    stack_mem(SP - 1.U) := io.dataIn // Write data into the top position
  }

  // Pop Operation (Read)
  when(io.EN && io.RW && !io.EMPTY) { // Check: Enable is on, RW = 1 (read), and buffer is not empty
    dataOutReg := stack_mem(SP)      // Read data from the top position
    stack_mem(SP) := 0.U             // Clear the read position (optional)
    SP := SP + 1.U                   // Increment Stack Pointer
  }
}

/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut())
}
*/
