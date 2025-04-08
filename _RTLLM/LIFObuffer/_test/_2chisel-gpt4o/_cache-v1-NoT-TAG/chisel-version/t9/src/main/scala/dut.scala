import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val dataIn  = Input(UInt(4.W)) // 4-bit input data
    val RW      = Input(Bool())    // Read/Write control: 1 -> Read, 0 -> Write
    val EN      = Input(Bool())    // Enable signal
    val EMPTY   = Output(Bool())   // Buffer empty flag
    val FULL    = Output(Bool())   // Buffer full flag
    val dataOut = Output(UInt(4.W)) // 4-bit output data
  })

  // Task 2: Stack memory and stack pointer initialization
  val stackMem = RegInit(VecInit(Seq.fill(4)(0.U(4.W)))) // 4-entry stack memory, each 4 bits
  val sp = RegInit(4.U(3.W)) // Stack pointer initialized to 4 (empty)

  // Task 3: Reset Logic
  when(reset.asBool) {
    sp := 4.U
    stackMem := VecInit(Seq.fill(4)(0.U(4.W)))
  }

  // Task 6: Flag Updates
  io.EMPTY := (sp === 4.U) // Buffer is empty when stack pointer is at 4
  io.FULL := (sp === 0.U)  // Buffer is full when stack pointer is at 0

  // Task 7: Output Data Assignment
  val dataOutReg = RegInit(0.U(4.W)) // Register for holding the read data
  io.dataOut := dataOutReg

  // Task 4 & 5: Push and Pop Operations
  when(io.EN) {
    when(io.RW) { // Read operation (Pop)
      when(!io.EMPTY) { // Only read if buffer is not empty
        dataOutReg := stackMem(sp) // Read from the stack memory
        stackMem(sp) := 0.U        // Optionally clear the memory (can be removed for efficiency)
        sp := sp + 1.U             // Increment the stack pointer
      }
    } .otherwise { // Write operation (Push)
      when(!io.FULL) { // Only write if buffer is not full
        sp := sp - 1.U             // Decrement the stack pointer
        stackMem(sp - 1.U) := io.dataIn // Write data into memory
      }
    }
  }
}

/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut)
}
*/
