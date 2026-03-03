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

  // Current water level encoding
  val currentLevel = WireDefault(0.U(3.W))
  when(s3 && s2 && s1) {
    currentLevel := 3.U  // Above s[3]
  }.elsewhen(s2 && s1 && !s3) {
    currentLevel := 2.U  // Between s[3] and s[2]
  }.elsewhen(s1 && !s2 && !s3) {
    currentLevel := 1.U  // Between s[2] and s[1]
  }.otherwise {
    currentLevel := 0.U  // Below s[1]
  }

  // Register to store previous water level
  val prevLevel = RegInit(0.U(3.W))
  
  // Synchronous reset handled by RegInit above
  // Update previous level on every clock cycle
  prevLevel := currentLevel

  // Determine if water level is rising (previous level was lower)
  val isRising = prevLevel < currentLevel

  // Nominal flow rates based on current level
  val nominalFr1 = WireDefault(false.B)
  val nominalFr2 = WireDefault(false.B)
  val nominalFr3 = WireDefault(false.B)

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
  val supplementalFlow = isRising && (currentLevel =/= 3.U)

  // Assign outputs
  io.fr1 := nominalFr1
  io.fr2 := nominalFr2
  io.fr3 := nominalFr3
  io.dfr := supplementalFlow

  // Handle reset case: reset implies water has been low for long time
  // RegInit(0.U) handles the prevLevel = 0 (below s[1])
  // The outputs will naturally be fr1=1, fr2=1, fr3=1, dfr=1 on first cycle
  // because currentLevel=0 (no sensors) and prevLevel=0 means not rising initially
  // We need to force dfr=1 on reset
  when(reset.asBool) {
    io.fr1 := true.B
    io.fr2 := true.B
    io.fr3 := true.B
    io.dfr := true.B
  }
}

/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(), Array("--target-dir", "generated"))
}
*/
