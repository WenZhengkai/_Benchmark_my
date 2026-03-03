import chisel3._
import chisel3.util._

/**
  * dut
  *
  * Inputs:
  *   s(2) = s[3] (highest sensor)
  *   s(1) = s[2]
  *   s(0) = s[1] (lowest sensor)
  *
  * Outputs:
  *   fr3, fr2, fr1 = nominal flow-rate valves
  *   dfr           = supplemental valve (asserted when level is rising since last sensor change)
  *
  * Reset (synchronous, active-high):
  *   State equivalent to "below s[1] for a long time":
  *     no sensors asserted (state = BELOW_S1)
  *     fr1, fr2, fr3, dfr all asserted
  */
class dut extends Module {
  val io = IO(new Bundle {
    val s   = Input(UInt(3.W))
    val fr3 = Output(Bool())
    val fr2 = Output(Bool())
    val fr1 = Output(Bool())
    val dfr = Output(Bool())
    val rst = Input(Bool()) // active-high synchronous reset
  })

  // Decode the physically-valid sensor patterns into a level code
  // Level meanings:
  //   0: BELOW_S1         (s = 000)
  //   1: BETWEEN_S2_S1    (s = 001)
  //   2: BETWEEN_S3_S2    (s = 011)
  //   3: ABOVE_S3         (s = 111)
  //
  // Any invalid pattern is treated conservatively as the lowest level (max fill).
  val levelNow = Wire(UInt(2.W))
  levelNow := MuxLookup(io.s, 0.U, Seq(
    "b000".U -> 0.U,
    "b001".U -> 1.U,
    "b011".U -> 2.U,
    "b111".U -> 3.U
  ))

  // Track the last level observed at the previous sensor-change boundary
  val levelPrev = RegInit(0.U(2.W))

  // Update previous level only when the decoded level changes
  when (io.rst) {
    levelPrev := 0.U
  } .elsewhen (levelNow =/= levelPrev) {
    levelPrev := levelNow
  }

  // Rising indication: current level is higher than the prior level at last change
  // (per spec: "previous level was lower than the current level")
  val rising = levelNow > levelPrev

  // Nominal flow mapping based on current level (table)
  val fr1Nom = WireDefault(false.B)
  val fr2Nom = WireDefault(false.B)
  val fr3Nom = WireDefault(false.B)

  switch(levelNow) {
    is(0.U) { // Below s[1]
      fr1Nom := true.B; fr2Nom := true.B; fr3Nom := true.B
    }
    is(1.U) { // Between s[2] and s[1]
      fr1Nom := true.B; fr2Nom := true.B; fr3Nom := false.B
    }
    is(2.U) { // Between s[3] and s[2]
      fr1Nom := true.B; fr2Nom := false.B; fr3Nom := false.B
    }
    is(3.U) { // Above s[3]
      fr1Nom := false.B; fr2Nom := false.B; fr3Nom := false.B
    }
  }

  // dfr asserted when rising, except that when above s[3] the flow should be zero
  val dfrNom = rising && (levelNow =/= 3.U)

  // Synchronous reset drives "below s1 for a long time": all outputs asserted
  val fr1Out = Wire(Bool())
  val fr2Out = Wire(Bool())
  val fr3Out = Wire(Bool())
  val dfrOut = Wire(Bool())

  when (io.rst) {
    fr1Out := true.B
    fr2Out := true.B
    fr3Out := true.B
    dfrOut := true.B
  } .otherwise {
    fr1Out := fr1Nom
    fr2Out := fr2Nom
    fr3Out := fr3Nom
    dfrOut := dfrNom
  }

  io.fr1 := fr1Out
  io.fr2 := fr2Out
  io.fr3 := fr3Out
  io.dfr := dfrOut
}
