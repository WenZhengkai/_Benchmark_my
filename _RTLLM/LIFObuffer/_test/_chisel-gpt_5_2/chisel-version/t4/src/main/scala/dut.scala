import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val dataIn  = Input(UInt(4.W))
    val RW      = Input(Bool()) // 1 = read (pop), 0 = write (push)
    val EN      = Input(Bool())

    val EMPTY   = Output(Bool())
    val FULL    = Output(Bool())
    val dataOut = Output(UInt(4.W))
  })

  // 4 entries of 4-bit stack memory
  val stack_mem = RegInit(VecInit(Seq.fill(4)(0.U(4.W))))

  // Stack pointer: 0..4, where 4 means empty, 0 means full
  val SP = RegInit(4.U(3.W))

  // Output register
  val dataOutReg = RegInit(0.U(4.W))
  io.dataOut := dataOutReg

  // Combinational flags derived from SP
  io.EMPTY := (SP === 4.U)
  io.FULL  := (SP === 0.U)

  when (reset.asBool) {
    SP := 4.U
    dataOutReg := 0.U
    for (i <- 0 until 4) { stack_mem(i) := 0.U }
  } .elsewhen (io.EN) {
    when (!io.RW) { // write (push)
      when (SP =/= 0.U) {
        val nextSp = SP - 1.U
        stack_mem(nextSp) := io.dataIn
        SP := nextSp
      }
    } .otherwise { // read (pop)
      when (SP =/= 4.U) {
        dataOutReg := stack_mem(SP)
        stack_mem(SP) := 0.U
        SP := SP + 1.U
      }
    }
  }
}

/*
object dutVerilog extends App {
  emitVerilog(new dut, Array("--target-dir", "generated"))
}
*/
