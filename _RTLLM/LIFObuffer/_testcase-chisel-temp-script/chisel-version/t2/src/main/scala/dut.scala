import chisel3._

class dut extends Module {
  val io = IO(new Bundle {
    val dataIn  = Input(UInt(4.W))
    val RW      = Input(Bool())   // 1: read(pop), 0: write(push)
    val EN      = Input(Bool())
    val EMPTY   = Output(Bool())
    val FULL    = Output(Bool())
    val dataOut = Output(UInt(4.W))
  })

  // 4-entry stack memory, each entry 4 bits
  val stack_mem = RegInit(VecInit(Seq.fill(4)(0.U(4.W))))
  // Stack pointer: 0..4 (4 means empty, 0 means full)
  val SP = RegInit(4.U(3.W))
  val dataOutReg = RegInit(0.U(4.W))

  when(io.EN) {
    when(reset.asBool) {
      SP := 4.U
      dataOutReg := 0.U
      for (i <- 0 until 4) {
        stack_mem(i) := 0.U
      }
    }.otherwise {
      // Write (push) when not full
      when(!io.RW && (SP =/= 0.U)) {
        val nextSP = SP - 1.U
        stack_mem(nextSP) := io.dataIn
        SP := nextSP
      }
      // Read (pop) when not empty
      .elsewhen(io.RW && (SP =/= 4.U)) {
        dataOutReg := stack_mem(SP)
        stack_mem(SP) := 0.U
        SP := SP + 1.U
      }
    }
  }

  io.EMPTY := (SP === 4.U)
  io.FULL  := (SP === 0.U)
  io.dataOut := dataOutReg
}

/*
object dutGen extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut)
}
*/
