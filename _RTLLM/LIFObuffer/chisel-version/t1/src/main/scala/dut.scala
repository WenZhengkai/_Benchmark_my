// package lifobuffer

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

  // Stack memory and stack pointer
  val stack_mem = RegInit(VecInit(Seq.fill(4)(0.U(4.W))))
  val SP = RegInit(4.U(3.W))  // Stack pointer initialized to 4 (empty stack)
  
  // Output registers
  val emptyReg = RegInit(true.B)
  val fullReg = RegInit(false.B)
  val dataOutReg = RegInit(0.U(4.W))

  // EMPTY and FULL flags logic
  emptyReg := (SP === 4.U)
  fullReg := (SP === 0.U)
  
  // Connect flag outputs
  io.EMPTY := emptyReg
  io.FULL := fullReg
  io.dataOut := dataOutReg

  // Buffer operations
  when(io.EN) {
    when(reset.asBool) {
      // Reset operation
      SP := 4.U
      stack_mem.foreach(_ := 0.U)
      dataOutReg := 0.U
    }.elsewhen(!io.RW && !fullReg) {
      // Push operation (write)
      stack_mem(SP - 1.U) := io.dataIn
      SP := SP - 1.U
    }.elsewhen(io.RW && !emptyReg) {
      // Pop operation (read)
      dataOutReg := stack_mem(SP)
      stack_mem(SP) := 0.U
      SP := SP + 1.U
    }
  }
}
