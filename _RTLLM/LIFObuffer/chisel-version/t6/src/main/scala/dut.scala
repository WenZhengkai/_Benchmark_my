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

  // 4-entry stack, each entry is 4 bits
  val stackMem = RegInit(VecInit(Seq.fill(4)(0.U(4.W))))
  // SP range: 0..4 (4 means empty, 0 means full)
  val sp       = RegInit(4.U(3.W))
  val dataOutR = RegInit(0.U(4.W))

  val empty = (sp === 4.U)
  val full  = (sp === 0.U)

  when(io.EN) {
    when(reset.asBool) {
      sp := 4.U
      dataOutR := 0.U
      for (i <- 0 until 4) {
        stackMem(i) := 0.U
      }
    }.otherwise {
      // Push
      when(!io.RW && !full) {
        val nextSp = sp - 1.U
        stackMem(nextSp) := io.dataIn
        sp := nextSp
      }
      // Pop
      .elsewhen(io.RW && !empty) {
        dataOutR := stackMem(sp)
        stackMem(sp) := 0.U
        sp := sp + 1.U
      }
    }
  }

  io.EMPTY := empty
  io.FULL  := full
  io.dataOut := dataOutR
}
