// SPDX-License-Identifier: Unlicense
import chisel3._
import chisel3.util._

/**
  * dut
  *
  * Inputs:
  *   s(2:0) corresponds to sensors s[3:1] in the spec:
  *     s(2) = s[3] (highest sensor)
  *     s(1) = s[2]
  *     s(0) = s[1] (lowest sensor)
  *
  * Outputs:
  *   fr1, fr2, fr3 = nominal flow valves
  *   dfr           = supplemental flow valve (opened when level is rising vs last sensor change)
  *
  * Reset behavior (active-high synchronous):
  *   Equivalent to "low for a long time": no sensors asserted => nominal max flow and dfr asserted.
  */
class dut extends Module {
  val io = IO(new Bundle {
    val s   = Input(UInt(3.W)) // s[3:1] packed into [2:0]
    val fr3 = Output(Bool())
    val fr2 = Output(Bool())
    val fr1 = Output(Bool())
    val dfr = Output(Bool())
    val reset_sync = Input(Bool()) // active-high synchronous reset
  })

  // Sensor patterns (valid levels)
  // Above s3:            111
  // Between s3 and s2:   011
  // Between s2 and s1:   001
  // Below s1:            000
  val LEVEL_ABOVE_S3  = "b111".U(3.W)
  val LEVEL_BETW_32   = "b011".U(3.W)
  val LEVEL_BETW_21   = "b001".U(3.W)
  val LEVEL_BELOW_S1  = "b000".U(3.W)

  // Provide a simple "height rank" for the four valid levels.
  // Higher rank => higher water level.
  def levelRank(s: UInt): UInt = {
    MuxLookup(
      s,
      0.U(2.W), // treat invalid as lowest
      Seq(
        LEVEL_BELOW_S1 -> 0.U(2.W),
        LEVEL_BETW_21  -> 1.U(2.W),
        LEVEL_BETW_32  -> 2.U(2.W),
        LEVEL_ABOVE_S3 -> 3.U(2.W)
      )
    )
  }

  // Register previous sensor vector; updated only when sensors change.
  val prevS = RegInit(LEVEL_BELOW_S1)

  // Nominal flow outputs from current water level (table in spec)
  val nominal_fr1 = WireDefault(false.B)
  val nominal_fr2 = WireDefault(false.B)
  val nominal_fr3 = WireDefault(false.B)

  switch(io.s) {
    is(LEVEL_ABOVE_S3) {
      nominal_fr1 := false.B
      nominal_fr2 := false.B
      nominal_fr3 := false.B
    }
    is(LEVEL_BETW_32) {
      nominal_fr1 := true.B
      nominal_fr2 := false.B
      nominal_fr3 := false.B
    }
    is(LEVEL_BETW_21) {
      nominal_fr1 := true.B
      nominal_fr2 := true.B
      nominal_fr3 := false.B
    }
    is(LEVEL_BELOW_S1) {
      nominal_fr1 := true.B
      nominal_fr2 := true.B
      nominal_fr3 := true.B
    }
  }

  // Determine rising/falling only on a sensor change.
  val sensorsChanged = io.s =/= prevS
  val prevRank = levelRank(prevS)
  val currRank = levelRank(io.s)

  // Supplemental valve rule:
  // If the sensor change indicates previous level was lower than current => open dfr.
  // Otherwise dfr is closed. (Held based on last change.)
  val dfrReg = RegInit(true.B) // "low for a long time" requires dfr asserted
  when(io.reset_sync) {
    prevS  := LEVEL_BELOW_S1
    dfrReg := true.B
  }.otherwise {
    when(sensorsChanged) {
      dfrReg := prevRank < currRank
      prevS  := io.s
    }
  }

  // Drive outputs
  io.fr1 := nominal_fr1
  io.fr2 := nominal_fr2
  io.fr3 := nominal_fr3
  io.dfr := dfrReg
}
