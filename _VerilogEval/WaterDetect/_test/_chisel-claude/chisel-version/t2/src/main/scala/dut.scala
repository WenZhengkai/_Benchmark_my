// package watercontroller

import chisel3._
import chisel3.util._

class WaterReservoirController extends Module {
  val io = IO(new Bundle {
    val s = Input(UInt(3.W))  // 3 sensors, s[3] to s[1]
    val fr3 = Output(Bool())  // Flow rate control signals
    val fr2 = Output(Bool())
    val fr1 = Output(Bool())
    val dfr = Output(Bool())  // Supplemental flow valve
    val reset = Input(Bool()) // Active-high synchronous reset
  })

  // Define states for the water level
  val LEVEL_BELOW_S1 = 0.U
  val LEVEL_BETWEEN_S1_S2 = 1.U
  val LEVEL_BETWEEN_S2_S3 = 2.U
  val LEVEL_ABOVE_S3 = 3.U

  // Register to store the current water level state
  val currentLevel = RegInit(LEVEL_BELOW_S1)
  
  // Register to store the previous level before the last sensor change
  val previousLevel = RegInit(LEVEL_BELOW_S1)
  
  // Determine the current level based on sensors
  val newLevel = Wire(UInt(2.W))
  
  when(io.s(2) && io.s(1) && io.s(0)) {
    newLevel := LEVEL_ABOVE_S3           // All sensors asserted (s[3], s[2], s[1])
  }.elsewhen(io.s(1) && io.s(0) && !io.s(2)) {
    newLevel := LEVEL_BETWEEN_S2_S3      // s[2] and s[1] asserted, s[3] not asserted
  }.elsewhen(io.s(0) && !io.s(1) && !io.s(2)) {
    newLevel := LEVEL_BETWEEN_S1_S2      // Only s[1] asserted
  }.otherwise {
    newLevel := LEVEL_BELOW_S1           // No sensors asserted
  }

  // Update state registers
  when(io.reset) {
    // Reset to state equivalent to water level being low for a long time
    currentLevel := LEVEL_BELOW_S1
    previousLevel := LEVEL_BELOW_S1
  }.elsewhen(newLevel =/= currentLevel) {
    // If level changed, update previous and current
    previousLevel := currentLevel
    currentLevel := newLevel
  }

  // Set the flow rate outputs based on current water level
  when(io.reset || currentLevel === LEVEL_BELOW_S1) {
    // Below s[1] or reset: maximum flow rate
    io.fr1 := true.B
    io.fr2 := true.B
    io.fr3 := true.B
  }.elsewhen(currentLevel === LEVEL_BETWEEN_S1_S2) {
    // Between s[2] and s[1]
    io.fr1 := true.B
    io.fr2 := true.B
    io.fr3 := false.B
  }.elsewhen(currentLevel === LEVEL_BETWEEN_S2_S3) {
    // Between s[3] and s[2]
    io.fr1 := true.B
    io.fr2 := false.B
    io.fr3 := false.B
  }.otherwise {
    // Above s[3]
    io.fr1 := false.B
    io.fr2 := false.B
    io.fr3 := false.B
  }

  // Set supplemental flow valve (dfr) based on level change direction
  when(io.reset) {
    // During reset, set dfr to active (as if level was low for a long time)
    io.dfr := true.B
  }.elsewhen(newLevel =/= currentLevel && previousLevel < currentLevel) {
    // If water level was previously lower (water is rising), increase flow rate
    io.dfr := true.B
  }.otherwise {
    io.dfr := false.B
  }
}

// Generate Verilog for the module
/*
object WaterReservoirControllerDriver extends App {
  chisel3.emitVerilog(new WaterReservoirController(), Array("--target-dir", "generated"))
}
*/
