import chisel3._
import chisel3.util._

/**
  * dut
  *
  * s(2) = s[3] (top sensor)
  * s(1) = s[2] (middle sensor)
  * s(0) = s[1] (bottom sensor)
  *
  * Outputs:
  *   fr1, fr2, fr3 = nominal flow rate valve controls
  *   dfr           = supplemental flow valve control (opened when rising level)
  *
  * Synchronous active-high reset: forces "low for a long time" condition:
  *   sensors assumed none asserted (state=BelowS1) and fr1/fr2/fr3/dfr all asserted.
  */
class dut extends Module {
  val io = IO(new Bundle {
    val s   = Input(UInt(3.W))  // [3:1] packed as [2:0]
    val fr3 = Output(Bool())
    val fr2 = Output(Bool())
    val fr1 = Output(Bool())
    val dfr = Output(Bool())
  })

  // Decode current water-level region from sensors (thermometer-like)
  object Level {
    val AboveS3 = 0.U(2.W) // s1,s2,s3 asserted (111)
    val BetweenS3S2 = 1.U(2.W) // s1,s2 asserted (011)
    val BetweenS2S1 = 2.U(2.W) // s1 asserted (001)
    val BelowS1 = 3.U(2.W) // none asserted (000)
  }

  // Map sensor pattern to level; treat any illegal pattern conservatively as BelowS1.
  val curLevel = Wire(UInt(2.W))
  curLevel := Level.BelowS1
  switch(io.s) {
    is("b111".U) { curLevel := Level.AboveS3 }
    is("b011".U) { curLevel := Level.BetweenS3S2 }
    is("b001".U) { curLevel := Level.BetweenS2S1 }
    is("b000".U) { curLevel := Level.BelowS1 }
  }

  // Track previous level at the last cycle (effectively "previous to last sensor change")
  val prevLevel = RegInit(Level.BelowS1)

  // Rising indication (level increased => moved upward => numeric code decreased)
  val rising = curLevel < prevLevel

  // Nominal flow-rate outputs based on current level
  val fr1Nom = WireDefault(false.B)
  val fr2Nom = WireDefault(false.B)
  val fr3Nom = WireDefault(false.B)

  switch(curLevel) {
    is(Level.AboveS3) {
      fr1Nom := false.B; fr2Nom := false.B; fr3Nom := false.B
    }
    is(Level.BetweenS3S2) {
      fr1Nom := true.B;  fr2Nom := false.B; fr3Nom := false.B
    }
    is(Level.BetweenS2S1) {
      fr1Nom := true.B;  fr2Nom := true.B;  fr3Nom := false.B
    }
    is(Level.BelowS1) {
      fr1Nom := true.B;  fr2Nom := true.B;  fr3Nom := true.B
    }
  }

  // Supplemental flow valve:
  // "If the sensor change indicates that the previous level was lower than the current level"
  // => rising level => open dfr. Use prevLevel vs curLevel.
  val dfrNext = rising

  // Synchronous reset behavior: "low for a long time" and all four outputs asserted.
  when(reset.asBool) {
    prevLevel := Level.BelowS1
    io.fr1 := true.B
    io.fr2 := true.B
    io.fr3 := true.B
    io.dfr := true.B
  }.otherwise {
    // Update history every cycle (works because sensors only change when crossing thresholds)
    prevLevel := curLevel

    io.fr1 := fr1Nom
    io.fr2 := fr2Nom
    io.fr3 := fr3Nom
    io.dfr := dfrNext
  }
}
