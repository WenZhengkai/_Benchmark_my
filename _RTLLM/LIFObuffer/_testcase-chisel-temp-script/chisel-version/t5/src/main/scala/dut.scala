import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val dataIn = Input(UInt(4.W))  // 4-bit input data
    val RW = Input(Bool())        // Read/Write control: 1 for read, 0 for write
    val EN = Input(Bool())        // Enable signal
    val EMPTY = Output(Bool())    // Flag indicating buffer is empty
    val FULL = Output(Bool())     // Flag indicating buffer is full
    val dataOut = Output(UInt(4.W)) // 4-bit output data
  })

  // 2D memory array of 4 elements, each 4 bits wide
  val stack_mem = Mem(4, UInt(4.W))

  // Stack pointer (SP), initialized to 4 (empty buffer)
  val SP = RegInit(4.U(3.W)) // 3 bits are enough to store 0-4

  // Default output for dataOut
  io.dataOut := 0.U

  // EMPTY and FULL flag logic
  io.EMPTY := (SP === 4.U)  // Stack pointer at 4 indicates empty
  io.FULL := (SP === 0.U)   // Stack pointer at 0 indicates full

  // Register reset behavior
  when(reset.asBool) {
    // On reset, clear all memory and reset SP
    for (i <- 0 until 4) {
      stack_mem.write(i.U, 0.U)
    }
    SP := 4.U
  } .elsewhen(io.EN) {    // Enable signal must be high
    when(!io.RW && !io.FULL) {   // Write operation
      // Push data onto the stack at SP - 1 and decrement SP
      stack_mem.write(SP - 1.U, io.dataIn)
      SP := SP - 1.U
    } .elsewhen(io.RW && !io.EMPTY) {  // Read operation
      // Pop data from the stack at SP and increment SP
      io.dataOut := stack_mem.read(SP)
      stack_mem.write(SP, 0.U)  // Optional: clear memory after reading
      SP := SP + 1.U
    }
  }
}

// Generate the Verilog code of the dut module
/*
object dutMain extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut)
}
*/
