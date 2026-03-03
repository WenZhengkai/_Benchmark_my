import chisel3._
import chisel3.experimental.ChiselEnum
import chisel3.util._

class dut extends Module with RequireSyncReset {
  val io = IO(new Bundle {
    // s(0)=s1 (lowest), s(1)=s2, s(2)=s3 (highest)
    val s   = Input(UInt(3.W))
    val fr3 = Output(Bool())
    val fr2 = Output(Bool())
    val fr1 = Output(Bool())
    val dfr = Output(Bool())
  })

  object WaterLevel extends ChiselEnum {
    val belowS1, betweenS2S1, betweenS3S2, aboveS3 = Value
  }

  def decodeSensors(s: UInt): WaterLevel.Type = {
    val level = Wire(WaterLevel())
    switch(s) {
      is("b000".U) { level := WaterLevel.belowS1 }      // below s1
      is("b001".U) { level := WaterLevel.betweenS2S1 }  // between s2 and s1
      is("b011".U) { level := WaterLevel.betweenS3S2 }  // between s3 and s2
      is("b111".U) { level := WaterLevel.aboveS3 }      // above s3
      default      { level := WaterLevel.belowS1 }      // fail-safe for illegal patterns
    }
    level
  }

  // State: current level and last movement direction.
  // Reset state = "low for a long time": belowS1 + rising=true, so all outputs asserted.
  val levelReg  = RegInit(WaterLevel.belowS1)
  val risingReg = RegInit(true.B)

  val sensedLevel = decodeSensors(io.s)

  when(sensedLevel =/= levelReg) {
    val rising = sensedLevel.asUInt > levelReg.asUInt
    levelReg  := sensedLevel
    risingReg := rising
  }

  // Default outputs
  io.fr1 := false.B
  io.fr2 := false.B
  io.fr3 := false.B
  io.dfr := false.B

  // Output logic from current FSM state
  switch(levelReg) {
    is(WaterLevel.aboveS3) {
      // no flow
    }
    is(WaterLevel.betweenS3S2) {
      io.fr1 := true.B
      io.dfr := risingReg
    }
    is(WaterLevel.betweenS2S1) {
      io.fr1 := true.B
      io.fr2 := true.B
      io.dfr := risingReg
    }
    is(WaterLevel.belowS1) {
      io.fr1 := true.B
      io.fr2 := true.B
      io.fr3 := true.B
      io.dfr := true.B
    }
  }
}
