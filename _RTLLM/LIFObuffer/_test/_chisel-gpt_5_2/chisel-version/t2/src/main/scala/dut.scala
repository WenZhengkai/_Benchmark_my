import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val dataIn  = Input(UInt(4.W))
    val RW      = Input(Bool())   // 1 = read(pop), 0 = write(push)
    val EN      = Input(Bool())

    val EMPTY   = Output(Bool())
    val FULL    = Output(Bool())
    val dataOut = Output(UInt(4.W))
  })

  // Stack memory: 4 entries of 4-bit
  val stack_mem = RegInit(VecInit(Seq.fill(4)(0.U(4.W))))

  // Stack Pointer (SP): 4 means empty, 0 means full (next push would go out)
  // Valid range: 0..4
  val SP = RegInit(4.U(3.W))

  val dataOutReg = RegInit(0.U(4.W))
  io.dataOut := dataOutReg

  // Flags derived from SP
  io.EMPTY := (SP === 4.U)
  io.FULL  := (SP === 0.U)

  when (io.EN) {
    when (reset.asBool) {
      SP := 4.U
      dataOutReg := 0.U
      for (i <- 0 until 4) {
        stack_mem(i) := 0.U
      }
    } .otherwise {
      // Push (write) when RW=0 and not full
      when (!io.RW && !io.FULL) {
        // Write at SP-1 then decrement SP
        val nextSp = SP - 1.U
        stack_mem(nextSp) := io.dataIn
        SP := nextSp
      }
      // Pop (read) when RW=1 and not empty
      .elsewhen (io.RW && !io.EMPTY) {
        // Read at SP then increment SP
        dataOutReg := stack_mem(SP)
        stack_mem(SP) := 0.U
        SP := SP + 1.U
      }
    }
  }
}

// Optional object to emit Verilog
/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut, Array("--target-dir", "generated"))
}
*/
