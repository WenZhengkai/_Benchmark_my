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

  // Create a 3-bit sensor vector for easier comparison
  val sensors = Cat(s3, s2, s1)

  // Register to store previous sensor state
  val prevSensors = RegInit(0.U(3.W))

  // Determine current water level
  val currentLevel = WireDefault(0.U(3.W))
  when(sensors === "b111".U) {
    currentLevel := 3.U  // Above s[3]
  }.elsewhen(sensors === "b011".U) {
    currentLevel := 2.U  // Between s[3] and s[2]
  }.elsewhen(sensors === "b001".U) {
    currentLevel := 1.U  // Between s[2] and s[1]
  }.otherwise {
    currentLevel := 0.U  // Below s[1]
  }

  // Determine previous water level
  val prevLevel = WireDefault(0.U(3.W))
  when(prevSensors === "b111".U) {
    prevLevel := 3.U
  }.elsewhen(prevSensors === "b011".U) {
    prevLevel := 2.U
  }.elsewhen(prevSensors === "b001".U) {
    prevLevel := 1.U
  }.otherwise {
    prevLevel := 0.U
  }

  // Determine if water level is rising (previous level was lower)
  val levelRising = prevLevel < currentLevel

  // Determine nominal flow rates based on current level
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

  // Determine if supplemental flow (dfr) should be activated
  val supplementalFlow = levelRising && (sensors =/= prevSensors)

  // Assign outputs
  io.fr1 := nominalFr1
  io.fr2 := nominalFr2
  io.fr3 := nominalFr3
  io.dfr := supplementalFlow

  // Update previous sensor state
  when(reset.asBool) {
    prevSensors := 0.U  // Reset to no sensors asserted (water level was low)
  }.otherwise {
    prevSensors := sensors
  }

  // Handle reset condition - all outputs asserted
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
