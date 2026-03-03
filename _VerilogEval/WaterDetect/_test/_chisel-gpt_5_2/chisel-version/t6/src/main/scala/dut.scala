// Chisel 3 / Chisel 6 compatible
import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val s   = Input(UInt(3.W))  // use bits [2:0] as s[3:1] respectively
    val fr3 = Output(Bool())
    val fr2 = Output(Bool())
    val fr1 = Output(Bool())
    val dfr = Output(Bool())
    val rst = Input(Bool())     // active-high synchronous reset
  })

  // Map s[3:1] from io.s[2:0]
  val s1 = io.s(0)
  val s2 = io.s(1)
  val s3 = io.s(2)

  // Encode current water-level region based on asserted sensors.
  // Expected sensor patterns:
  //  Above s3:            111
  //  Between s3 and s2:   011
  //  Between s2 and s1:   001
  //  Below s1:            000
  val LV_ABOVE_S3 :: LV_BET_S3_S2 :: LV_BET_S2_S1 :: LV_BELOW_S1 :: Nil = Enum(4)

  val curLevel = WireDefault(LV_BELOW_S1)
  when (s1 && s2 && s3) {
    curLevel := LV_ABOVE_S3
  } .elsewhen (s1 && s2 && !s3) {
    curLevel := LV_BET_S3_S2
  } .elsewhen (s1 && !s2 && !s3) {
    curLevel := LV_BET_S2_S1
  } .otherwise {
    curLevel := LV_BELOW_S1
  }

  // Track the previous "level" at the last sensor change.
  // This is used to determine whether the last change indicates rising vs falling.
  val prevLevelAtChange = RegInit(LV_BELOW_S1)

  // Remember last sampled level to detect any change
  val lastLevel = RegInit(LV_BELOW_S1)

  val levelChanged = curLevel =/= lastLevel

  // Synchronous reset behavior:
  // "equivalent to if the water level had been low for a long time
  //  (no sensors asserted, and all four outputs asserted)"
  when (io.rst) {
    lastLevel         := LV_BELOW_S1
    prevLevelAtChange := LV_BELOW_S1
  } .otherwise {
    when (levelChanged) {
      prevLevelAtChange := lastLevel
      lastLevel         := curLevel
    }
  }

  // Nominal flow rate by current level (table)
  val nom_fr1 = WireDefault(false.B)
  val nom_fr2 = WireDefault(false.B)
  val nom_fr3 = WireDefault(false.B)

  switch(curLevel) {
    is(LV_ABOVE_S3) { // 111
      nom_fr1 := false.B; nom_fr2 := false.B; nom_fr3 := false.B
    }
    is(LV_BET_S3_S2) { // 011
      nom_fr1 := true.B;  nom_fr2 := false.B; nom_fr3 := false.B
    }
    is(LV_BET_S2_S1) { // 001
      nom_fr1 := true.B;  nom_fr2 := true.B;  nom_fr3 := false.B
    }
    is(LV_BELOW_S1) { // 000
      nom_fr1 := true.B;  nom_fr2 := true.B;  nom_fr3 := true.B
    }
  }

  // Supplemental flow valve rule:
  // "If the sensor change indicates that the previous level was lower than the current level,
  //  the flow rate should be increased by opening the Supplemental flow valve (dfr)."
  //
  // Interpret "previous level was lower than current level" as: water is rising.
  // With our encoding, higher enum value == lower water (LV_BELOW_S1 is "lowest water").
  // So rising means: curLevel is "higher water" than previous (numerically smaller).
  val rising = curLevel.asUInt < prevLevelAtChange.asUInt

  // dfr asserted when rising AND in middle regions (not at extremes),
  // because extremes already define full-off or full-on behavior.
  val dfrNom = rising && (curLevel =/= LV_ABOVE_S3) && (curLevel =/= LV_BELOW_S1)

  // Outputs: on sync reset force "all four outputs asserted"
  when (io.rst) {
    io.fr1 := true.B
    io.fr2 := true.B
    io.fr3 := true.B
    io.dfr := true.B
  } .otherwise {
    io.fr1 := nom_fr1
    io.fr2 := nom_fr2
    io.fr3 := nom_fr3
    io.dfr := dfrNom
  }
}
