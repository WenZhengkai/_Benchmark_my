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
  *   fr1, fr2, fr3 = nominal flow valve controls
  *   dfr           = supplemental flow valve (opened when level is rising since last sensor change)
  *
  * Reset (sync, active-high):
  *   Equivalent to "low for a long time": no sensors asserted; all outputs asserted.
  */
class dut extends Module {
  val io = IO(new Bundle {
    val s     = Input(UInt(3.W))   // s[3:1] packed as {s3,s2,s1} => io.s(2)=s3, io.s(1)=s2, io.s(0)=s1
    val reset = Input(Bool())      // active-high synchronous reset
    val fr3   = Output(Bool())
    val fr2   = Output(Bool())
    val fr1   = Output(Bool())
    val dfr   = Output(Bool())
  })

  // Encode current water-level region from sensors (assumes physically consistent combinations):
  // 111: above s3
  // 011: between s3 and s2
  // 001: between s2 and s1
  // 000: below s1
  object Level {
    val aboveS3    = 0.U(2.W)
    val between32  = 1.U(2.W)
    val between21  = 2.U(2.W)
    val belowS1    = 3.U(2.W)
  }

  val levelNow = Wire(UInt(2.W))
  levelNow := MuxLookup(io.s, Level.belowS1, Seq(
    "b111".U -> Level.aboveS3,
    "b011".U -> Level.between32,
    "b001".U -> Level.between21,
    "b000".U -> Level.belowS1
  ))

  // Track previous level at last sensor change; used to determine whether level rose or fell.
  val prevLevel = RegInit(Level.belowS1) // "low for a long time" baseline

  val sensorChanged = Wire(Bool())
  sensorChanged := levelNow =/= prevLevel

  // Rising means water level moved upward (numerically smaller in our encoding).
  val rising = sensorChanged && (levelNow < prevLevel)

  // Update previous level on change; on sync reset force to "below s1"
  when (io.reset) {
    prevLevel := Level.belowS1
  } .elsewhen (sensorChanged) {
    prevLevel := levelNow
  }

  // Nominal flow rate based purely on current level
  val n_fr1 = WireDefault(false.B)
  val n_fr2 = WireDefault(false.B)
  val n_fr3 = WireDefault(false.B)

  switch(levelNow) {
    is(Level.aboveS3) {
      n_fr1 := false.B; n_fr2 := false.B; n_fr3 := false.B
    }
    is(Level.between32) {
      n_fr1 := true.B;  n_fr2 := false.B; n_fr3 := false.B
    }
    is(Level.between21) {
      n_fr1 := true.B;  n_fr2 := true.B;  n_fr3 := false.B
    }
    is(Level.belowS1) {
      n_fr1 := true.B;  n_fr2 := true.B;  n_fr3 := true.B
    }
  }

  // Supplemental valve dfr: asserted when the last sensor change indicates level rose.
  // On sync reset, all outputs asserted.
  val dfrReg = RegInit(true.B)
  when (io.reset) {
    dfrReg := true.B
  } .elsewhen (sensorChanged) {
    dfrReg := rising
  }

  // Outputs (sync reset forces all asserted)
  io.fr1 := Mux(io.reset, true.B, n_fr1)
  io.fr2 := Mux(io.reset, true.B, n_fr2)
  io.fr3 := Mux(io.reset, true.B, n_fr3)
  io.dfr := dfrReg
}
