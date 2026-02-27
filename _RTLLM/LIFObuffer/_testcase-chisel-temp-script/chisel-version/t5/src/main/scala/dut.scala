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

  // Internal registers for the LIFO buffer
  val stack_mem = RegInit(VecInit(Seq.fill(4)(0.U(4.W))))
  val SP = RegInit(4.U(3.W)) // Stack Pointer initialized to 4 (empty)
  val dataOut_reg = RegInit(0.U(4.W))
  
  // Status signals
  val empty = SP === 4.U
  val full = SP === 0.U
  
  io.EMPTY := empty
  io.FULL := full
  io.dataOut := dataOut_reg

  when(reset.asBool) {
    SP := 4.U
    for (i <- 0 until 4) {
      stack_mem(i) := 0.U
    }
    dataOut_reg := 0.U
  }.elsewhen(io.EN) {
    when(!io.RW && !full) {
      // Write operation (push)
      stack_mem(SP - 1.U) := io.dataIn
      SP := SP - 1.U
    }.elsewhen(io.RW && !empty) {
      // Read operation (pop)
      dataOut_reg := stack_mem(SP)
      stack_mem(SP) := 0.U
      SP := SP + 1.U
    }
  }
}

// Object to generate Verilog
/*
object dutGenerator extends App {
  chisel3.emitVerilog(new dut(), args)
}
*/
