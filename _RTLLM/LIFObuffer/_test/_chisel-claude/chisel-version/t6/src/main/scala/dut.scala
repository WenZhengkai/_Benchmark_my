// package buffer

import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    // Input ports
    val dataIn = Input(UInt(4.W))
    val RW = Input(Bool())  // 1 for read, 0 for write
    val EN = Input(Bool())  // Enable signal
    
    // Output ports
    val EMPTY = Output(Bool())
    val FULL = Output(Bool())
    val dataOut = Output(UInt(4.W))
  })
  
  // Define stack memory and pointer
  val stack_mem = RegInit(VecInit(Seq.fill(4)(0.U(4.W))))
  val sp = RegInit(4.U(3.W))  // Stack pointer (3 bits to represent 0-4)
  
  // Default output values
  io.dataOut := 0.U
  io.EMPTY := (sp === 4.U)
  io.FULL := (sp === 0.U)
  
  when (io.EN) {
    when (reset.asBool) {
      // Reset logic
      sp := 4.U
      for (i <- 0 until 4) {
        stack_mem(i) := 0.U
      }
    } .otherwise {
      when (!io.RW && !io.FULL) {
        // Write operation (push)
        stack_mem(sp - 1.U) := io.dataIn
        sp := sp - 1.U
      } .elsewhen (io.RW && !io.EMPTY) {
        // Read operation (pop)
        io.dataOut := stack_mem(sp)
        stack_mem(sp) := 0.U
        sp := sp + 1.U
      }
    }
  }
}

// Optional: Object for generating Verilog
/*
object dutGenerator extends App {
  chisel3.Driver.execute(args, () => new dut)
}
*/
