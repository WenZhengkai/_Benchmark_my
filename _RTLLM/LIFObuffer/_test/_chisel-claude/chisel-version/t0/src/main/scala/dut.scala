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
  
  // Stack memory: 4 entries, each 4 bits wide
  val stack_mem = RegInit(VecInit(Seq.fill(4)(0.U(4.W))))
  // Stack pointer: points to next available position, 4 means empty
  val SP = RegInit(4.U(3.W))  // Using 3 bits to represent values 0-4
  
  // Default values
  io.dataOut := 0.U
  io.EMPTY := (SP === 4.U)
  io.FULL := (SP === 0.U)
  
  when(io.EN) {
    when(reset.asBool) {
      // Reset condition
      SP := 4.U
      for(i <- 0 until 4) {
        stack_mem(i) := 0.U
      }
    }.otherwise {
      when(!io.RW && !io.FULL) {
        // Write operation (push) when not full
        stack_mem(SP - 1.U) := io.dataIn
        SP := SP - 1.U
      }.elsewhen(io.RW && !io.EMPTY) {
        // Read operation (pop) when not empty
        io.dataOut := stack_mem(SP)
        stack_mem(SP) := 0.U  // Clear the memory location
        SP := SP + 1.U
      }
    }
  }
}
