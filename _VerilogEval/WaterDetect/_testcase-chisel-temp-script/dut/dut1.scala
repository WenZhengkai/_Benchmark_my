import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val s = Input(UInt(3.W))
    val reset = Input(Bool())
    val fr3 = Output(Bool())
    val fr2 = Output(Bool())
    val fr1 = Output(Bool())
    val dfr = Output(Bool())
  })

  // Define the water level states
  val ABOVE_S3 = 3.U
  val BETWEEN_S3_S2 = 2.U
  val BETWEEN_S2_S1 = 1.U
  val BELOW_S1 = 0.U

  // Register to store the current water level state
  val currentState = RegInit(BELOW_S1)
  
  // Register to store the previous state (used to determine direction of level change)
  val previousState = RegInit(BELOW_S1)
  
  // Determine the current water level based on sensor inputs
  val waterLevel = Wire(UInt(2.W))
  when(io.s(3-1) && io.s(2-1) && io.s(1-1)) {
    waterLevel := ABOVE_S3
  }.elsewhen(io.s(2-1) && io.s(1-1)) {
    waterLevel := BETWEEN_S3_S2
  }.elsewhen(io.s(1-1)) {
    waterLevel := BETWEEN_S2_S1
  }.otherwise {
    waterLevel := BELOW_S1
  }

  // Update state registers
  when(io.reset) {
    currentState := BELOW_S1
    previousState := BELOW_S1
  }.elsewhen(waterLevel =/= currentState) {
    previousState := currentState
    currentState := waterLevel
  }

  // Determine if the water level is rising
  val isRising = currentState > previousState

  // Set the output flow rates based on the current state and direction
  when(io.reset) {
    // Reset state: equivalent to water level being low for a long time
    io.fr3 := true.B
    io.fr2 := true.B
    io.fr1 := true.B
    io.dfr := true.B
  }.otherwise {
    // Set nominal flow rate based on water level
    io.fr3 := currentState === BELOW_S1
    io.fr2 := currentState === BELOW_S1 || currentState === BETWEEN_S2_S1
    io.fr1 := currentState === BELOW_S1 || currentState === BETWEEN_S2_S1 || currentState === BETWEEN_S3_S2
    
    // Set supplemental flow rate if water level is rising
    io.dfr := isRising
  }
}
