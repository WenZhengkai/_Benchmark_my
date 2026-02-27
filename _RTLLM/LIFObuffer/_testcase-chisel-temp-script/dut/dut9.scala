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

  // Stack memory and pointer
  val stack_mem = RegInit(VecInit(Seq.fill(4)(0.U(4.W))))
  val SP = RegInit(4.U(3.W))  // Stack pointer (3 bits to hold values 0-4)
  
  // Output registers
  val emptyReg = RegInit(true.B)
  val fullReg = RegInit(false.B)
  val dataOutReg = RegInit(0.U(4.W))

  // Default values
  io.EMPTY := emptyReg
  io.FULL := fullReg
  io.dataOut := dataOutReg

  when(io.EN) {
    when(reset.asBool) {
      // Reset operation
      SP := 4.U
      for (i <- 0 until 4) {
        stack_mem(i) := 0.U
      }
      emptyReg := true.B
      fullReg := false.B
      dataOutReg := 0.U
    }.otherwise {
      // Write operation (push)
      when(!io.RW && !fullReg) {
        stack_mem(SP - 1.U) := io.dataIn
        SP := SP - 1.U
        emptyReg := false.B
        fullReg := (SP - 1.U) === 0.U
      }
      
      // Read operation (pop)
      when(io.RW && !emptyReg) {
        dataOutReg := stack_mem(SP)
        stack_mem(SP) := 0.U  // Clear the memory location
        SP := SP + 1.U
        fullReg := false.B
        emptyReg := (SP + 1.U) === 4.U
      }
    }
  }
}

// Top-level module with the requested name
class dut extends Module {
  val io = IO(new Bundle {
    val dataIn = Input(UInt(4.W))
    val RW = Input(Bool())
    val EN = Input(Bool())
    
    val EMPTY = Output(Bool())
    val FULL = Output(Bool())
    val dataOut = Output(UInt(4.W))
  })
  
  val lifo = Module(new LIFO)
  
  // Connect the IO
  lifo.io.dataIn := io.dataIn
  lifo.io.RW := io.RW
  lifo.io.EN := io.EN
  
  io.EMPTY := lifo.io.EMPTY
  io.FULL := lifo.io.FULL
  io.dataOut := lifo.io.dataOut
}
