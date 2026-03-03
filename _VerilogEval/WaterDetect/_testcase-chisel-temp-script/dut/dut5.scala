import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    // s(2)=s[3] (highest), s(1)=s[2], s(0)=s[1] (lowest)
    val s   = Input(UInt(3.W))
    val fr3 = Output(Bool())
    val fr2 = Output(Bool())
    val fr1 = Output(Bool())
    val dfr = Output(Bool())
  })

  // Water level encoding:
  // 0: below s1, 1: between s2 and s1, 2: between s3 and s2, 3: above s3
  val level = Wire(UInt(2.W))
  when(io.s(2)) {
    level := 3.U
  }.elsewhen(io.s(1)) {
    level := 2.U
  }.elsewhen(io.s(0)) {
    level := 1.U
  }.otherwise {
    level := 0.U
  }

  // Track "current level" and "previous level before last sensor change"
  val lastLevel = Reg(UInt(2.W))
  val prevLevel = Reg(UInt(2.W))

  when(reset.asBool) { // active-high synchronous reset
    lastLevel := 0.U
    prevLevel := 0.U
  }.otherwise {
    when(level =/= lastLevel) {
      prevLevel := lastLevel
      lastLevel := level
    }
  }

  // Use the level history that corresponds to the most recent sensor state
  val effectivePrev = Mux(level =/= lastLevel, lastLevel, prevLevel)

  // Nominal flow outputs
  val fr1Nom = level <= 2.U
  val fr2Nom = level <= 1.U
  val fr3Nom = level === 0.U

  // Supplemental flow output
  // - Always on at lowest level
  // - Always off at highest level
  // - In middle levels, on if previous level was lower than current level
  val dfrMid = effectivePrev < level
  val dfrNom = Mux(level === 0.U, true.B, Mux(level === 3.U, false.B, dfrMid))

  // Reset state equivalent to "low for a long time": all four outputs asserted
  io.fr1 := Mux(reset.asBool, true.B, fr1Nom)
  io.fr2 := Mux(reset.asBool, true.B, fr2Nom)
  io.fr3 := Mux(reset.asBool, true.B, fr3Nom)
  io.dfr := Mux(reset.asBool, true.B, dfrNom)
}
