import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val s = Input(UInt(3.W))  // 3 sensors, s[3], s[2], s[1]
    val reset = Input(Bool()) // Active-high synchronous reset
    val fr3 = Output(Bool())  // Flow rate control output
    val fr2 = Output(Bool())  // Flow rate control output
    val fr1 = Output(Bool())  // Flow rate control output
    val dfr = Output(Bool())  // Supplemental flow valve control output
  })

  // Define states for water level
  val sAboveS3 :: sBetweenS3S2 :: sBetweenS2S1 :: sBelowS1 :: Nil = Enum(4)
  
  // State register for current water level
  val currentState = RegInit(sBelowS1)
  
  // Register to track the previous state for trend detection
  val previousState = RegInit(sBelowS1)
  
  // Update previous state on every state change
  when(currentState =/= RegNext(currentState)) {
    previousState := RegNext(currentState)
  }

  // Determine current water level based on sensors
  val newState = Wire(UInt(2.W))
  when(io.s(2) && io.s(1) && io.s(0)) {
    newState := sAboveS3
  }.elsewhen(io.s(1) && io.s(0) && !io.s(2)) {
    newState := sBetweenS3S2
  }.elsewhen(io.s(0) && !io.s(1) && !io.s(2)) {
    newState := sBetweenS2S1
  }.otherwise {
    newState := sBelowS1
  }
  
  // Update current state
  when(io.reset) {
    currentState := sBelowS1
    previousState := sBelowS1
  }.otherwise {
    currentState := newState
  }
  
  // Determine if the water level was rising (for supplemental flow control)
  val wasRising = Wire(Bool())
  wasRising := (previousState < currentState)
  
  // Set output flow rates based on current water level and trend
  // Initialize all outputs to false
  io.fr1 := false.B
  io.fr2 := false.B
  io.fr3 := false.B
  io.dfr := false.B
  
  when(io.reset) {
    // Reset condition: equivalent to low water level for long time
    io.fr1 := true.B
    io.fr2 := true.B
    io.fr3 := true.B
    io.dfr := true.B
  }.otherwise {
    switch(currentState) {
      is(sAboveS3) {
        // No flow rate needed when water level is above s[3]
      }
      is(sBetweenS3S2) {
        io.fr1 := true.B
        io.dfr := wasRising
      }
      is(sBetweenS2S1) {
        io.fr1 := true.B
        io.fr2 := true.B
        io.dfr := wasRising
      }
      is(sBelowS1) {
        io.fr1 := true.B
        io.fr2 := true.B
        io.fr3 := true.B
        io.dfr := wasRising
      }
    }
  }
}
