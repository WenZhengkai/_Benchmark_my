// package lifo

import chisel3._
import chisel3.util._

class LIFO extends Module {
  val io = IO(new Bundle {
    val dataIn = Input(UInt(4.W))
    val RW = Input(Bool())  // 1 for read, 0 for write
    val EN = Input(Bool())  // Enable signal
    
    val EMPTY = Output(Bool())
    val FULL = Output(Bool())
    val dataOut = Output(UInt(4.W))
  })

  // Stack memory with 4 entries, each 4-bit wide
  val stack_mem = RegInit(VecInit(Seq.fill(4)(0.U(4.W))))
  
  // Stack pointer: points to the next free position
  // When SP = 4, the stack is empty
  // When SP = 0, the stack is full
  val SP = RegInit(4.U(3.W))
  
  // Default outputs
  io.EMPTY := SP === 4.U
  io.FULL := SP === 0.U
  io.dataOut := 0.U
  
  // LIFO operations based on enable signal
  when(io.EN) {
    when(reset.asBool) {
      // Reset operation: clear stack and set SP to empty state
      SP := 4.U
      for(i <- 0 until 4) {
        stack_mem(i) := 0.U
      }
    }.elsewhen(!io.RW && !io.FULL) {
      // Write operation (push): store data and decrement SP
      stack_mem(SP - 1.U) := io.dataIn
      SP := SP - 1.U
    }.elsewhen(io.RW && !io.EMPTY) {
      // Read operation (pop): read data, clear memory location, and increment SP
      io.dataOut := stack_mem(SP)
      stack_mem(SP) := 0.U
      SP := SP + 1.U
    }
  }
}

// Top-level module named "dut" as specified
class dut extends Module {
  val io = IO(new Bundle {
    val dataIn = Input(UInt(4.W))
    val RW = Input(Bool())
    val EN = Input(Bool())
    
    val EMPTY = Output(Bool())
    val FULL = Output(Bool())
    val dataOut = Output(UInt(4.W))
  })
  
  val lifo = Module(new LIFO())
  
  // Connect inputs
  lifo.io.dataIn := io.dataIn
  lifo.io.RW := io.RW
  lifo.io.EN := io.EN
  
  // Connect outputs
  io.EMPTY := lifo.io.EMPTY
  io.FULL := lifo.io.FULL
  io.dataOut := lifo.io.dataOut
}
