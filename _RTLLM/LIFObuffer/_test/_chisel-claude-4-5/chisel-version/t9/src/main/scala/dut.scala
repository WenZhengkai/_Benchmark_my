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

  // Stack memory array - 4 entries of 4 bits each
  val stack_mem = RegInit(VecInit(Seq.fill(4)(0.U(4.W))))
  
  // Stack pointer - starts at 4 (empty state)
  val SP = RegInit(4.U(3.W))
  
  // Output data register
  val dataOut_reg = RegInit(0.U(4.W))
  
  // Default assignments
  io.dataOut := dataOut_reg
  
  // EMPTY and FULL flags
  io.EMPTY := (SP === 4.U)
  io.FULL  := (SP === 0.U)
  
  // Main logic
  when(io.EN) {
    when(reset.asBool) {
      // Reset: clear stack, set SP to 4, initialize memory to 0
      SP := 4.U
      dataOut_reg := 0.U
      for (i <- 0 until 4) {
        stack_mem(i) := 0.U
      }
    }.otherwise {
      when(!io.RW) {
        // Write operation (push)
        when(!io.FULL) {
          val new_SP = SP - 1.U
          stack_mem(new_SP) := io.dataIn
          SP := new_SP
        }
      }.otherwise {
        // Read operation (pop)
        when(!io.EMPTY) {
          dataOut_reg := stack_mem(SP - 1.U)
          stack_mem(SP - 1.U) := 0.U
          SP := SP + 1.U
        }
      }
    }
  }
}

/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut, Array("--target-dir", "generated"))
}
*/
