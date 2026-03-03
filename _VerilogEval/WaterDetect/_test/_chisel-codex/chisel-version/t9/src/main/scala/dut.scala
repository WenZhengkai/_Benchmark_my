import chisel3._

class dut extends Module {
  val io = IO(new Bundle {
    // s(2)=s[3] (highest), s(1)=s[2], s(0)=s[1] (lowest)
    val s   = Input(UInt(3.W))
    val rst = Input(Bool()) // active-high synchronous reset

    val fr3 = Output(Bool())
    val fr2 = Output(Bool())
    val fr1 = Output(Bool())
    val dfr = Output(Bool())
  })

  // Internal state:
  // prevLevel tracks level at last observed sensor state.
  // trendUp remembers whether last sensor change was upward (prev < current).
  val prevLevel = RegInit(0.U(2.W)) // reset-equivalent: below s1
  val trendUp   = RegInit(true.B)   // reset-equivalent: supplemental asserted

  // Registered outputs (matches "output reg" style behavior)
  val fr1Reg = RegInit(true.B)
  val fr2Reg = RegInit(true.B)
  val fr3Reg = RegInit(true.B)
  val dfrReg = RegInit(true.B)

  // Decode current water level from sensors:
  // 3: above s3, 2: between s3/s2, 1: between s2/s1, 0: below s1
  val level = Wire(UInt(2.W))
  level := Mux(io.s(2), 3.U,
           Mux(io.s(1), 2.U,
           Mux(io.s(0), 1.U, 0.U)))

  val levelChanged = level =/= prevLevel
  val trendNow     = Mux(levelChanged, level > prevLevel, trendUp)

  // Nominal valve outputs by level
  val fr1Next = level =/= 3.U
  val fr2Next = (level === 1.U) || (level === 0.U)
  val fr3Next = level === 0.U

  // Supplemental valve:
  // - always on below s1
  // - always off above s3
  // - in middle levels, on iff last sensor change was upward
  val dfrNext = Mux(level === 0.U, true.B,
                Mux(level === 3.U, false.B, trendNow))

  when(io.rst) {
    // Synchronous reset to "low for a long time" equivalent state
    prevLevel := 0.U
    trendUp   := true.B
    fr1Reg    := true.B
    fr2Reg    := true.B
    fr3Reg    := true.B
    dfrReg    := true.B
  }.otherwise {
    when(levelChanged) {
      trendUp   := level > prevLevel
      prevLevel := level
    }

    fr1Reg := fr1Next
    fr2Reg := fr2Next
    fr3Reg := fr3Next
    dfrReg := dfrNext
  }

  io.fr1 := fr1Reg
  io.fr2 := fr2Reg
  io.fr3 := fr3Reg
  io.dfr := dfrReg
}

/*
object dut extends App {
  emitVerilog(new dut(), Array("--target-dir", "generated"))
}
*/
