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

  // Extract individual sensor signals
  val s1 = io.s(1)
  val s2 = io.s(2)
  val s3 = io.s(3)

  // Define states representing previous water levels
  val sIdle :: sAboveS3 :: sBetweenS3S2 :: sBetweenS2S1 :: sBelowS1 :: Nil = Enum(5)
  
  // State register - initialized to sBelowS1 (reset state)
  val state = RegInit(sBelowS1)

  // Determine current water level based on sensors
  val currentLevel = WireDefault(sBelowS1)
  when(s1 && s2 && s3) {
    currentLevel := sAboveS3
  }.elsewhen(s1 && s2 && !s3) {
    currentLevel := sBetweenS3S2
  }.elsewhen(s1 && !s2 && !s3) {
    currentLevel := sBetweenS2S1
  }.otherwise {
    currentLevel := sBelowS1
  }

  // Update state to current level
  state := currentLevel

  // Determine if water level is rising (previous level was lower than current)
  val isRising = WireDefault(false.B)
  
  when(currentLevel === sAboveS3) {
    isRising := (state === sBetweenS3S2) || (state === sBetweenS2S1) || (state === sBelowS1)
  }.elsewhen(currentLevel === sBetweenS3S2) {
    isRising := (state === sBetweenS2S1) || (state === sBelowS1)
  }.elsewhen(currentLevel === sBetweenS2S1) {
    isRising := (state === sBelowS1)
  }.otherwise {
    isRising := false.B
  }

  // Default outputs
  io.fr3 := false.B
  io.fr2 := false.B
  io.fr1 := false.B
  io.dfr := false.B

  // Set nominal flow rates based on current water level
  when(currentLevel === sAboveS3) {
    // No flow needed
    io.fr3 := false.B
    io.fr2 := false.B
    io.fr1 := false.B
  }.elsewhen(currentLevel === sBetweenS3S2) {
    // Nominal: fr1
    io.fr1 := true.B
  }.elsewhen(currentLevel === sBetweenS2S1) {
    // Nominal: fr1, fr2
    io.fr1 := true.B
    io.fr2 := true.B
  }.otherwise { // Below s1
    // Nominal: fr1, fr2, fr3
    io.fr1 := true.B
    io.fr2 := true.B
    io.fr3 := true.B
  }

  // Add supplemental flow if water level is rising
  when(isRising) {
    io.dfr := true.B
  }
}

/*
object dut extends App {
  println("Generating the dut hardware")
  emitVerilog(new dut(), Array("--target-dir", "generated"))
}
*/
