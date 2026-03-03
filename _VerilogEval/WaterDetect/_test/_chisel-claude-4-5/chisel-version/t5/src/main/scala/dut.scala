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

  // Extract individual sensor signals
  val s1 = io.s(1)
  val s2 = io.s(2)
  val s3 = io.s(3)

  // Current water level encoding
  val currentLevel = Wire(UInt(2.W))
  currentLevel := MuxCase(0.U, Seq(
    (!s1 && !s2 && !s3) -> 0.U,  // Below s[1]
    (s1 && !s2 && !s3)  -> 1.U,  // Between s[2] and s[1]
    (s1 && s2 && !s3)   -> 2.U,  // Between s[3] and s[2]
    (s1 && s2 && s3)    -> 3.U   // Above s[3]
  ))

  // Register to store previous water level
  val prevLevel = RegInit(0.U(2.W))
  
  // Update previous level when current level changes
  when(currentLevel =/= prevLevel) {
    prevLevel := currentLevel
  }

  // Determine if level is rising (previous level was lower than current)
  val levelRising = Wire(Bool())
  levelRising := currentLevel > prevLevel

  // Nominal flow rate outputs based on current level
  val nominalFr1 = Wire(Bool())
  val nominalFr2 = Wire(Bool())
  val nominalFr3 = Wire(Bool())

  switch(currentLevel) {
    is(0.U) {  // Below s[1]
      nominalFr1 := true.B
      nominalFr2 := true.B
      nominalFr3 := true.B
    }
    is(1.U) {  // Between s[2] and s[1]
      nominalFr1 := true.B
      nominalFr2 := true.B
      nominalFr3 := false.B
    }
    is(2.U) {  // Between s[3] and s[2]
      nominalFr1 := true.B
      nominalFr2 := false.B
      nominalFr3 := false.B
    }
    is(3.U) {  // Above s[3]
      nominalFr1 := false.B
      nominalFr2 := false.B
      nominalFr3 := false.B
    }
  }

  // Supplemental flow valve (dfr) is opened when level is rising
  // and we're not at the highest level
  val supplementalFlow = Wire(Bool())
  supplementalFlow := levelRising && (currentLevel =/= 3.U)

  // Assign outputs
  io.fr1 := nominalFr1
  io.fr2 := nominalFr2
  io.fr3 := nominalFr3
  io.dfr := supplementalFlow

  // Handle reset: equivalent to water level being low for a long time
  // (no sensors asserted, all outputs asserted, previous level also low)
  when(reset.asBool) {
    prevLevel := 0.U
  }
}

/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(), Array("--target-dir", "generated"))
}
*/
