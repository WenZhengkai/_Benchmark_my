import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    // s[3:1] in the spec maps to UInt(3.W): s(2)=s3, s(1)=s2, s(0)=s1
    val s   = Input(UInt(3.W))
    val fr3 = Output(Bool())
    val fr2 = Output(Bool())
    val fr1 = Output(Bool())
    val dfr = Output(Bool())
  })

  // 0: below s1     (000)
  // 1: between s2,s1 (001)
  // 2: between s3,s2 (011)
  // 3: above s3      (111)
  private val curLevel = Wire(UInt(2.W))
  curLevel := 0.U
  switch(io.s) {
    is("b000".U) { curLevel := 0.U }
    is("b001".U) { curLevel := 1.U }
    is("b011".U) { curLevel := 2.U }
    is("b111".U) { curLevel := 3.U }
  }

  // Track last level and whether the last sensor change was upward.
  val lastLevel     = RegInit(0.U(2.W))
  val lastChangeUp  = RegInit(true.B)

  // Registered outputs (matches "output reg" style behavior).
  val fr1Reg = RegInit(true.B)
  val fr2Reg = RegInit(true.B)
  val fr3Reg = RegInit(true.B)
  val dfrReg = RegInit(true.B)

  io.fr1 := fr1Reg
  io.fr2 := fr2Reg
  io.fr3 := fr3Reg
  io.dfr := dfrReg

  val levelChanged = curLevel =/= lastLevel
  val changeIsUp   = curLevel > lastLevel
  val midDfr       = Mux(levelChanged, changeIsUp, lastChangeUp)

  when(reset.asBool) {
    // Active-high synchronous reset:
    // equivalent to "low for a long time" => no sensors asserted + all outputs asserted.
    lastLevel    := 0.U
    lastChangeUp := true.B

    fr1Reg := true.B
    fr2Reg := true.B
    fr3Reg := true.B
    dfrReg := true.B
  }.otherwise {
    when(levelChanged) {
      lastLevel    := curLevel
      lastChangeUp := changeIsUp
    }

    switch(curLevel) {
      is(3.U) { // Above s3: no flow
        fr1Reg := false.B
        fr2Reg := false.B
        fr3Reg := false.B
        dfrReg := false.B
      }
      is(2.U) { // Between s3 and s2: nominal fr1
        fr1Reg := true.B
        fr2Reg := false.B
        fr3Reg := false.B
        dfrReg := midDfr
      }
      is(1.U) { // Between s2 and s1: nominal fr1, fr2
        fr1Reg := true.B
        fr2Reg := true.B
        fr3Reg := false.B
        dfrReg := midDfr
      }
      is(0.U) { // Below s1: maximum flow (fr1,fr2,fr3 + dfr)
        fr1Reg := true.B
        fr2Reg := true.B
        fr3Reg := true.B
        dfrReg := true.B
      }
    }
  }
}

/*
object dutVerilog extends App {
  emitVerilog(new dut, Array("--target-dir", "generated"))
}
*/
