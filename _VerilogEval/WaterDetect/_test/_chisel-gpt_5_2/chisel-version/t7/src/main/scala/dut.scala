import chisel3._
import chisel3.util._

/**
  * dut
  *
  * s(2) = s[3] (highest sensor)
  * s(1) = s[2]
  * s(0) = s[1] (lowest sensor)
  *
  * Outputs fr1/fr2/fr3 form the nominal flow rate.
  * dfr is the supplemental valve that is asserted when the most recent
  * sensor transition indicates the water level rose (previous level lower
  * than current level).
  *
  * Active-high synchronous reset drives the machine to "below s[1] for a long time":
  * no sensors asserted (state = 0), fr1/fr2/fr3/dfr all asserted.
  */
class dut extends Module {
  val io = IO(new Bundle {
    val s   = Input(UInt(3.W))  // [3:1] packed as 3 bits
    val fr3 = Output(Bool())
    val fr2 = Output(Bool())
    val fr1 = Output(Bool())
    val dfr = Output(Bool())
  })

  // Encode water level region from sensors:
  // 3 -> above s3 (111)
  // 2 -> between s3 and s2 (011)
  // 1 -> between s2 and s1 (001)
  // 0 -> below s1 (000)
  def levelFromSensors(s: UInt): UInt = {
    MuxLookup(s, 0.U(2.W), Seq(
      "b111".U -> 3.U(2.W),
      "b011".U -> 2.U(2.W),
      "b001".U -> 1.U(2.W),
      "b000".U -> 0.U(2.W)
    ))
  }

  val currLevel = levelFromSensors(io.s)

  // Track previous *stable* level (last sampled level)
  val prevLevel = RegInit(0.U(2.W)) // reset assumes "below s1 for a long time"

  // Supplemental flow latch: set on rising transition, cleared on falling transition,
  // held if no level change.
  val dfrReg = RegInit(true.B) // reset wants all four outputs asserted

  // Update state and dfr synchronously
  when (reset.asBool) {
    prevLevel := 0.U
    dfrReg    := true.B
  } .otherwise {
    when (currLevel =/= prevLevel) {
      when (currLevel > prevLevel) {
        // Water rose since last sensor change => open supplemental valve
        dfrReg := true.B
      } .otherwise {
        // Water fell since last sensor change => close supplemental valve
        dfrReg := false.B
      }
      prevLevel := currLevel
    }
  }

  // Nominal flow mapping from table
  val fr1Nom = WireDefault(false.B)
  val fr2Nom = WireDefault(false.B)
  val fr3Nom = WireDefault(false.B)

  switch(currLevel) {
    is(3.U) { // above s3: none
      fr1Nom := false.B; fr2Nom := false.B; fr3Nom := false.B
    }
    is(2.U) { // between s3 and s2: fr1
      fr1Nom := true.B;  fr2Nom := false.B; fr3Nom := false.B
    }
    is(1.U) { // between s2 and s1: fr1, fr2
      fr1Nom := true.B;  fr2Nom := true.B;  fr3Nom := false.B
    }
    is(0.U) { // below s1: fr1, fr2, fr3
      fr1Nom := true.B;  fr2Nom := true.B;  fr3Nom := true.B
    }
  }

  io.fr1 := fr1Nom
  io.fr2 := fr2Nom
  io.fr3 := fr3Nom
  io.dfr := dfrReg
}
