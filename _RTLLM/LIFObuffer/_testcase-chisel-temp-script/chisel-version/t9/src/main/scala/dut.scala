import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val dataIn = Input(UInt(4.W))  // 4-bit input data
    val RW = Input(Bool())        // Read/Write control signal (1 for read, 0 for write)
    val EN = Input(Bool())        // Enable signal

    val dataOut = Output(UInt(4.W)) // 4-bit output data
    val EMPTY = Output(Bool())      // Empty flag
    val FULL = Output(Bool())       // Full flag
  })

  // Stack memory - 4 entries, each 4-bit wide
  val stack_mem = RegInit(VecInit(Seq.fill(4)(0.U(4.W))))

  // Stack pointer (SP) - index for current stack position
  val SP = RegInit(4.U(3.W)) // 3-bit register, 4 means empty

  // Default values for the output ports
  io.dataOut := 0.U
  io.EMPTY := false.B
  io.FULL := false.B

  // Reset logic
  when(reset.asBool()) {
    stack_mem := VecInit(Seq.fill(4)(0.U(4.W)))
    SP := 4.U
  }.otherwise {
    when(io.EN) { // Only perform operations if EN is high
      when(io.RW) { // Read operation
        when(SP =/= 4.U) { // Check if the buffer is not empty
          io.dataOut := stack_mem(SP)      // Read the value at the current stack pointer
          stack_mem(SP) := 0.U             // Optional: clear the read value (not required in LIFO)
          SP := SP + 1.U                   // Increment the stack pointer
        }
      }.otherwise { // Write operation
        when(SP =/= 0.U) { // Check if the buffer is not full
          SP := SP - 1.U                      // Decrement the stack pointer
          stack_mem(SP - 1.U) := io.dataIn    // Write value to the calculated position
        }
      }
    }
  }

  // Update FULL and EMPTY flags
  io.EMPTY := (SP === 4.U) // Stack is empty when SP is 4
  io.FULL := (SP === 0.U)  // Stack is full when SP is 0
}

/*
object dut extends App {
  println("Generating dut Verilog...")
  (new chisel3.stage.ChiselStage).emitVerilog(new dut())
}
*/
