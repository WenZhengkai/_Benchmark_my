import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val dataIn = Input(UInt(4.W))  // 4-bit input data
    val RW = Input(Bool())         // Read/Write control signal
    val EN = Input(Bool())         // Enable signal
    val EMPTY = Output(Bool())     // Flag indicating buffer empty
    val FULL = Output(Bool())      // Flag indicating buffer full
    val dataOut = Output(UInt(4.W)) // 4-bit output data
  })

  // Task 2: Stack Memory and Stack Pointer Initialization
  val stack_mem = RegInit(VecInit(Seq.fill(4)(0.U(4.W)))) // 4 entries, 4 bits each
  val SP = RegInit(4.U(3.W)) // Stack pointer (3 bits for values 0 to 4)

  // Task 3: Reset Logic
  // Reset is implicit in Chisel. Reset values for SP and stack memory are already defined using `RegInit`.

  // Task 4 & 5: Push and Pop Operations
  // Register to hold the read value
  val dataOutReg = RegInit(0.U(4.W))

  when(io.EN) {
    when(io.RW === false.B) { // Write operation
      when(SP =/= 0.U) { // Non-Full condition
        SP := SP - 1.U
        stack_mem(SP - 1.U) := io.dataIn
      }
    }.elsewhen(io.RW === true.B) { // Read operation
      when(SP =/= 4.U) { // Non-Empty condition
        dataOutReg := stack_mem(SP)
        stack_mem(SP) := 0.U     // Clear the current memory location
        SP := SP + 1.U          // Increment the stack pointer
      }
    }
  }

  // Task 6: Flag Updates
  io.EMPTY := (SP === 4.U) // Buffer is empty when SP points to the top
  io.FULL := (SP === 0.U)  // Buffer is full when SP points to the bottom

  // Task 7: Output Data Assignment
  io.dataOut := dataOutReg
}

// Generate Verilog code
/*
object dutVerilog extends App {
  println("Generating Verilog for dut...")
  (new chisel3.stage.ChiselStage).emitVerilog(new dut)
}
*/
