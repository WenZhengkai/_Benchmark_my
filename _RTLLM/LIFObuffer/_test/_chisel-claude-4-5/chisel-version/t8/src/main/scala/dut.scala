import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val dataIn  = Input(UInt(4.W))
    val RW      = Input(Bool())
    val EN      = Input(Bool())
    val EMPTY   = Output(Bool())
    val FULL    = Output(Bool())
    val dataOut = Output(UInt(4.W))
  })

  // Stack memory array - 4 entries of 4-bit wide data
  val stack_mem = RegInit(VecInit(Seq.fill(4)(0.U(4.W))))
  
  // Stack pointer - initialized to 4 (empty stack)
  val SP = RegInit(4.U(3.W))
  
  // Output data register
  val dataOutReg = RegInit(0.U(4.W))
  
  // Default values
  io.dataOut := dataOutReg
  io.EMPTY := (SP === 4.U)
  io.FULL := (SP === 0.U)
  
  when(io.EN) {
    when(reset.asBool) {
      // Reset condition: clear stack, set SP to 4, initialize memory
      SP := 4.U
      dataOutReg := 0.U
      for (i <- 0 until 4) {
        stack_mem(i) := 0.U
      }
    }.otherwise {
      // Write operation (Push)
      when(!io.RW && SP =/= 0.U) {
        SP := SP - 1.U
        stack_mem(SP - 1.U) := io.dataIn
      }
      // Read operation (Pop)
      .elsewhen(io.RW && SP =/= 4.U) {
        dataOutReg := stack_mem(SP)
        stack_mem(SP) := 0.U
        SP := SP + 1.U
      }
    }
  }
}

/*
object dutDriver extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(), Array("--target-dir", "generated"))
}
*/
