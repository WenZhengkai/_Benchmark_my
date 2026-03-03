import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val dataIn  = Input(UInt(4.W))
    val RW      = Input(Bool()) // 1: read(pop), 0: write(push)
    val EN      = Input(Bool())

    val EMPTY   = Output(Bool())
    val FULL    = Output(Bool())
    val dataOut = Output(UInt(4.W))
  })

  // 4-entry stack memory, 4-bit each
  val stack_mem = RegInit(VecInit(Seq.fill(4)(0.U(4.W))))

  // SP ranges 0..4:
  //   4 => empty, 0 => full
  val SP = RegInit(4.U(3.W))

  val dataOutReg = RegInit(0.U(4.W))
  io.dataOut := dataOutReg

  // Status flags
  io.EMPTY := (SP === 4.U)
  io.FULL  := (SP === 0.U)

  // Sequential behavior
  when(io.EN) {
    when(reset.asBool) {
      SP := 4.U
      dataOutReg := 0.U
      for (i <- 0 until 4) {
        stack_mem(i) := 0.U
      }
    }.otherwise {
      when(!io.RW) {
        // Write (push) if not full
        when(SP =/= 0.U) {
          stack_mem(SP - 1.U) := io.dataIn
          SP := SP - 1.U
        }
      }.otherwise {
        // Read (pop) if not empty
        when(SP =/= 4.U) {
          dataOutReg := stack_mem(SP)
          stack_mem(SP) := 0.U
          SP := SP + 1.U
        }
      }
    }
  }
}
