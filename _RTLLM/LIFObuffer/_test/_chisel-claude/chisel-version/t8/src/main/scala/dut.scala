// package lifo

import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val dataIn = Input(UInt(4.W))
    val RW = Input(Bool())     // 1 for read, 0 for write
    val EN = Input(Bool())     // Enable signal
    
    val EMPTY = Output(Bool()) // Empty flag
    val FULL = Output(Bool())  // Full flag
    val dataOut = Output(UInt(4.W))
  })
  
  // Define stack memory - 4 entries, each 4 bits wide
  val stack_mem = RegInit(VecInit(Seq.fill(4)(0.U(4.W))))
  
  // Stack pointer (SP) - points to the next available position
  // SP = 4 means empty stack, SP = 0 means full stack
  val SP = RegInit(4.U(3.W))
  
  // Initialize output signals
  io.EMPTY := (SP === 4.U)
  io.FULL := (SP === 0.U)
  io.dataOut := 0.U
  
  when(io.EN) {
    when(reset.asBool) {
      // Reset condition
      SP := 4.U
      for (i <- 0 until 4) {
        stack_mem(i) := 0.U
      }
    }.elsewhen(!io.RW && !io.FULL) {
      // Write operation (push) when not full
      stack_mem(SP - 1.U) := io.dataIn
      SP := SP - 1.U
    }.elsewhen(io.RW && !io.EMPTY) {
      // Read operation (pop) when not empty
      io.dataOut := stack_mem(SP)
      stack_mem(SP) := 0.U
      SP := SP + 1.U
    }
  }
  
  // For debug purposes - connect dataOut to the top of stack even if not reading
  when(!io.EMPTY) {
    io.dataOut := stack_mem(SP)
  }
}
