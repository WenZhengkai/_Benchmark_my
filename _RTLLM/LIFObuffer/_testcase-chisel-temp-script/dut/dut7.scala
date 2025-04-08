import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val dataIn = Input(UInt(4.W))  // 4-bit input data
    val RW = Input(Bool())         // Read/Write control signal (1 for read, 0 for write)
    val EN = Input(Bool())         // Enable signal
    val EMPTY = Output(Bool())     // Flag: Buffer is empty
    val FULL = Output(Bool())      // Flag: Buffer is full
    val dataOut = Output(UInt(4.W))// 4-bit output data
  })

  // Internal components
  val stack_mem = RegInit(VecInit(Seq.fill(4)(0.U(4.W)))) // 4x4 memory array initialized to 0
  val SP = RegInit(4.U(3.W))                             // Stack pointer initialized to 4

  // Default outputs
  io.dataOut := 0.U  // Default output value
  io.EMPTY := (SP === 4.U) // Buffer is empty if SP points to the top (4)
  io.FULL := (SP === 0.U)  // Buffer is full if SP is 0

  // Write operation (Push onto the stack)
  when(io.EN && !io.RW && !io.FULL) {
    stack_mem(SP - 1.U) := io.dataIn // Write data to stack at SP-1
    SP := SP - 1.U                   // Decrement stack pointer
  }

  // Read operation (Pop from the stack)
  when(io.EN && io.RW && !io.EMPTY) {
    io.dataOut := stack_mem(SP)      // Output data from stack at SP
    stack_mem(SP) := 0.U             // Optionally clear the read position
    SP := SP + 1.U                   // Increment stack pointer
  }
}
