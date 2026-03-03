import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val s = Input(UInt(4.W))  // s[3:1], s[0] is unused
    val fr3 = Output(Bool())
    val fr2 = Output(Bool())
    val fr1 = Output(Bool())
    val dfr = Output(Bool())
  })

  // Extract individual sensor bits
  val s1 = io.s(1)
  val s2 = io.s(2)
  val s3 = io.s(3)

  // Define water level states based on sensor readings
  val levelAboveS3 = s1 && s2 && s3        // All sensors asserted
  val levelBetweenS3S2 = s1 && s2 && !s3   // s[1], s[2] asserted
  val levelBetweenS2S1 = s1 && !s2 && !s3  // Only s[1] asserted
  val levelBelowS1 = !s1 && !s2 && !s3     // No sensors asserted

  // State register to track previous water level
  // 0: Below s[1], 1: Between s[2] and s[1], 2: Between s[3] and s[2], 3: Above s[3]
  val prevLevel = RegInit(0.U(2.W))
  val currLevel = Wire(UInt(2.W))

  // Determine current level
  currLevel := MuxCase(0.U, Seq(
    levelAboveS3 -> 3.U,
    levelBetweenS3S2 -> 2.U,
    levelBetweenS2S1 -> 1.U,
    levelBelowS1 -> 0.U
  ))

  // Update previous level on any sensor change
  when(currLevel =/= prevLevel) {
    prevLevel := currLevel
  }

  // Determine if water level is rising (previous level was lower)
  val waterRising = prevLevel < currLevel

  // Default nominal flow rates based on current water level
  val nominalFr1 = Wire(Bool())
  val nominalFr2 = Wire(Bool())
  val nominalFr3 = Wire(Bool())

  nominalFr1 := MuxCase(false.B, Seq(
    levelAboveS3 -> false.B,
    levelBetweenS3S2 -> true.B,
    levelBetweenS2S1 -> true.B,
    levelBelowS1 -> true.B
  ))

  nominalFr2 := MuxCase(false.B, Seq(
    levelAboveS3 -> false.B,
    levelBetweenS3S2 -> false.B,
    levelBetweenS2S1 -> true.B,
    levelBelowS1 -> true.B
  ))

  nominalFr3 := MuxCase(false.B, Seq(
    levelAboveS3 -> false.B,
    levelBetweenS3S2 -> false.B,
    levelBetweenS2S1 -> false.B,
    levelBelowS1 -> true.B
  ))

  // Supplemental flow valve (dfr) is opened when water is rising
  // and we're not above s[3]
  val supplementalFlow = waterRising && !levelAboveS3

  // Assign outputs
  io.fr1 := nominalFr1
  io.fr2 := nominalFr2
  io.fr3 := nominalFr3
  io.dfr := supplementalFlow

  // Handle reset: equivalent to water level being low for a long time
  // No sensors asserted, all outputs asserted
  when(reset.asBool) {
    prevLevel := 0.U  // Below s[1] state
    io.fr1 := true.B
    io.fr2 := true.B
    io.fr3 := true.B
    io.dfr := true.B
  }
}

/*
object dut extends App {
  println("Generating the dut hardware")
  emitVerilog(new dut(), Array("--target-dir", "generated"))
}
*/
