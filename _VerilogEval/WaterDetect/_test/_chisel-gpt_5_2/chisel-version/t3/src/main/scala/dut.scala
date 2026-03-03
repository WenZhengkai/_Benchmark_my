import chisel3._
import chisel3.util._

/**
  * Water reservoir flow controller
  *
  * Inputs:
  *   s(2) = s[3] (highest sensor)
  *   s(1) = s[2]
  *   s(0) = s[1] (lowest sensor)
  *
  * Outputs:
  *   fr1, fr2, fr3 = nominal flow-rate valve controls
  *   dfr           = supplemental valve control (opened when level is rising since last sensor change)
  *
  * Reset:
  *   Active-high synchronous reset to "low for a long time":
  *     - remembered sensors = none asserted
  *     - outputs fr1,fr2,fr3,dfr all asserted
  */
class dut extends Module {
  val io = IO(new Bundle {
    val s    = Input(UInt(3.W)) // [3:1] packed as [2:0]
    val fr3  = Output(Bool())
    val fr2  = Output(Bool())
    val fr1  = Output(Bool())
    val dfr  = Output(Bool())
    val reset = Input(Bool())   // active-high synchronous reset
  })

  // Decode current water level into an ordered index:
  // 3 = above s3 (111), 2 = between s3 and s2 (011), 1 = between s2 and s1 (001), 0 = below s1 (000)
  def levelOf(s: UInt): UInt = {
    MuxLookup(s, 0.U(2.W), Seq(
      "b111".U -> 3.U(2.W),
      "b011".U -> 2.U(2.W),
      "b001".U -> 1.U(2.W),
      "b000".U -> 0.U(2.W)
    ))
  }

  val currLevel = levelOf(io.s)

  // Remember the sensor pattern at the last sensor change (for "previous level")
  val prevS = RegInit("b000".U(3.W))

  // Update prevS only when sensors change
  when (io.reset) {
    prevS := "b000".U
  } .elsewhen (io.s =/= prevS) {
    prevS := io.s
  }

  val prevLevel = levelOf(prevS)

  // Nominal flow outputs based on current level
  val nom_fr1 = WireDefault(false.B)
  val nom_fr2 = WireDefault(false.B)
  val nom_fr3 = WireDefault(false.B)

  switch(currLevel) {
    is(3.U) { // above s3: none
      nom_fr1 := false.B; nom_fr2 := false.B; nom_fr3 := false.B
    }
    is(2.U) { // between s3 and s2: fr1
      nom_fr1 := true.B;  nom_fr2 := false.B; nom_fr3 := false.B
    }
    is(1.U) { // between s2 and s1: fr1, fr2
      nom_fr1 := true.B;  nom_fr2 := true.B;  nom_fr3 := false.B
    }
    is(0.U) { // below s1: fr1, fr2, fr3
      nom_fr1 := true.B;  nom_fr2 := true.B;  nom_fr3 := true.B
    }
  }

  // Supplemental valve (dfr):
  // Assert when the last sensor change indicates the previous level was lower than the current level.
  // (i.e., level rose since last change)
  val risingSinceLastChange = currLevel > prevLevel
  val dfrComb = risingSinceLastChange

  // Register outputs, with synchronous reset behavior as specified
  val fr1_r = RegInit(true.B)
  val fr2_r = RegInit(true.B)
  val fr3_r = RegInit(true.B)
  val dfr_r = RegInit(true.B)

  when (io.reset) {
    // Equivalent to "water level low for a long time": no sensors asserted and all outputs asserted
    fr1_r := true.B
    fr2_r := true.B
    fr3_r := true.B
    dfr_r := true.B
  } .otherwise {
    fr1_r := nom_fr1
    fr2_r := nom_fr2
    fr3_r := nom_fr3
    dfr_r := dfrComb
  }

  io.fr1 := fr1_r
  io.fr2 := fr2_r
  io.fr3 := fr3_r
  io.dfr := dfr_r
}
