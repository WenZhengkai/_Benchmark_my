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
  
  // Stack memory to store data (4 entries, each 4 bits wide)
  val stack_mem = RegInit(VecInit(Seq.fill(4)(0.U(4.W))))
  
  // Stack pointer (pointing to the next available position)
  val SP = RegInit(4.U(3.W))  // Using 3 bits to represent 0-4
  
  // Define EMPTY and FULL conditions
  io.EMPTY := SP === 4.U
  io.FULL := SP === 0.U
  
  // Default output
  io.dataOut := 0.U
  
  when(io.EN) {
    when(reset.asBool) {
      // Reset condition
      SP := 4.U
      for(i <- 0 until 4) {
        stack_mem(i) := 0.U
      }
    }.otherwise {
      when(!io.RW && !io.FULL) {
        // Write operation (push)
        stack_mem(SP - 1.U) := io.dataIn
        SP := SP - 1.U
      }.elsewhen(io.RW && !io.EMPTY) {
        // Read operation (pop)
        io.dataOut := stack_mem(SP)
        stack_mem(SP) := 0.U
        SP := SP + 1.U
      }
    }
  }
}

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
  
  // Connect input ports
  lifo.io.dataIn := io.dataIn
  lifo.io.RW := io.RW
  lifo.io.EN := io.EN
  
  // Connect output ports
  io.EMPTY := lifo.io.EMPTY
  io.FULL := lifo.io.FULL
  io.dataOut := lifo.io.dataOut
}
