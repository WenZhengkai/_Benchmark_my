import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val s = Input(UInt(4.W))  // s[3:1], s[0] unused
    val fr3 = Output(Bool())
    val fr2 = Output(Bool())
    val fr1 = Output(Bool())
    val dfr = Output(Bool())
  })

  // Extract sensor bits
  val s1 = io.s(1)
  val s2 = io.s(2)
  val s3 = io.s(3)

  // Define water level states based on sensor readings
  val levelAboveS3 = s1 && s2 && s3        // All sensors asserted
  val levelBetweenS3S2 = s1 && s2 && !s3   // s[1], s[2] asserted
  val levelBetweenS2S1 = s1 && !s2 && !s3  // Only s[1] asserted
  val levelBelowS1 = !s1 && !s2 && !s3     // No sensors asserted

  // Register to store previous water level for trend detection
  val prevLevel = RegInit(0.U(2.W))  // 0=below s1, 1=between s2-s1, 2=between s3-s2, 3=above s3
  
  // Determine current level
  val currLevel = Wire(UInt(2.W))
  currLevel := MuxCase(0.U, Seq(
    levelAboveS3 -> 3.U,
    levelBetweenS3S2 -> 2.U,
    levelBetweenS2S1 -> 1.U,
    levelBelowS1 -> 0.U
  ))

  // Detect if water level is rising (previous level was lower)
  val waterRising = currLevel > prevLevel

  // Update previous level
  prevLevel := currLevel

  // Nominal flow rate outputs based on current water level
  val nominalFr1 = Wire(Bool())
  val nominalFr2 = Wire(Bool())
  val nominalFr3 = Wire(Bool())

  nominalFr1 := levelBetweenS3S2 || levelBetweenS2S1 || levelBelowS1
  nominalFr2 := levelBetweenS2S1 || levelBelowS1
  nominalFr3 := levelBelowS1

  // Supplemental flow valve (dfr) - opened when water is rising and not above s[3]
  val supplementalFlow = waterRising && !levelAboveS3

  // Assign outputs
  io.fr1 := nominalFr1
  io.fr2 := nominalFr2
  io.fr3 := nominalFr3
  io.dfr := supplementalFlow

  // Handle reset: equivalent to water level low for long time
  // (no sensors asserted, all outputs asserted)
  when(reset.asBool) {
    prevLevel := 0.U
    // Note: Outputs will be set correctly by combinational logic
    // when levelBelowS1 is true (all sensors false)
  }
}

/*
object dutDriver extends App {
  emitVerilog(new dut(), Array("--target-dir", "generated"))
}
*/
