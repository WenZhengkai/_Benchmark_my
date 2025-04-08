import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val dataIn  = Input(UInt(4.W))       // 4-bit input data
    val RW      = Input(Bool())         // Read/Write control signal (1 = Read, 0 = Write)
    val EN      = Input(Bool())         // Enable signal
    val EMPTY   = Output(Bool())        // Empty flag
    val FULL    = Output(Bool())        // Full flag
    val dataOut = Output(UInt(4.W))     // 4-bit output data
  })

  // Stack memory with 4 entries and 4-bit width, initialized to 0
  val stack_mem = RegInit(VecInit(Seq.fill(4)(0.U(4.W))))

  // Stack pointer (SP) initialized to 4 (empty stack)
  val SP = RegInit(4.U(3.W))

  // Register for holding the data to output
  val dataOutReg = RegInit(0.U(4.W))

  // FULL flag: Stack is full when SP == 0
  io.FULL := (SP === 0.U)

  // EMPTY flag: Stack is empty when SP == 4
  io.EMPTY := (SP === 4.U)

  // Default behavior: dataOut returns the registered value
  io.dataOut := dataOutReg

  // Synchronous operation for stack behavior
  when(io.EN) {
    when(io.RW) { // Read operation (Pop)
      when(!io.EMPTY) { // Only pop if not empty
        dataOutReg := stack_mem(SP) // Read the top of the stack
        stack_mem(SP) := 0.U // Clear the current entry
        SP := SP + 1.U       // Increment stack pointer
      }
    } .otherwise { // Write operation (Push)
      when(!io.FULL) { // Only push if not full
        SP := SP - 1.U       // Decrement stack pointer
        stack_mem(SP - 1.U) := io.dataIn // Write data to the stack
      }
    }
  }
}

/*
object dut extends App {
  chisel3.Driver.execute(args, () => new dut)
}
*/
