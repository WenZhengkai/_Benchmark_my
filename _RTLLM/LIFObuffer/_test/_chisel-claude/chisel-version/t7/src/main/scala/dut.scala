import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val dataIn = Input(UInt(4.W))
    val RW = Input(Bool())
    val EN = Input(Bool())
    
    val EMPTY = Output(Bool())
    val FULL = Output(Bool())
    val dataOut = Output(UInt(4.W))
  })

  // Define stack memory as a vector of registers
  val stackDepth = 4
  val stackMem = RegInit(VecInit(Seq.fill(stackDepth)(0.U(4.W))))
  
  // Stack pointer - initialized to stackDepth (empty stack)
  val sp = RegInit(stackDepth.U(3.W))  // 3 bits to hold values 0-4
  
  // Default outputs
  io.EMPTY := (sp === stackDepth.U)
  io.FULL := (sp === 0.U)
  io.dataOut := 0.U
  
  // Buffer logic
  when(io.EN) {
    when(reset.asBool) {
      // Reset condition
      sp := stackDepth.U
      for (i <- 0 until stackDepth) {
        stackMem(i) := 0.U
      }
    }.elsewhen(!io.RW && !io.FULL) {
      // Write operation (push)
      stackMem(sp - 1.U) := io.dataIn
      sp := sp - 1.U
    }.elsewhen(io.RW && !io.EMPTY) {
      // Read operation (pop)
      io.dataOut := stackMem(sp)
      stackMem(sp) := 0.U  // Clear the read location
      sp := sp + 1.U
    }
  }
  
  // For read operation, we need to output the data regardless of whether we're
  // incrementing the pointer (which only happens when EN is high)
  when(io.RW && !io.EMPTY) {
    io.dataOut := stackMem(sp)
  }
}
