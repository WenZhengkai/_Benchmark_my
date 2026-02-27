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

  // Define states for the FSM
  object State extends ChiselEnum {
    val Level0, Level1, Level2, Level3 = Value
  }
  
  // State register
  val state = RegInit(State.Level0)
  val prevState = RegInit(State.Level0)
  
  // Determine current water level based on sensors
  val currentLevel = Wire(State())
  
  // Extract individual sensor values for clarity
  val s1 = io.s(0)  // lowest sensor
  val s2 = io.s(1)  // middle sensor
  val s3 = io.s(2)  // highest sensor
  
  // Determine water level based on sensor readings
  when(s3 === 1.U) {
    currentLevel := State.Level3       // Above s[3]
  }.elsewhen(s2 === 1.U) {
    currentLevel := State.Level2       // Between s[3] and s[2]
  }.elsewhen(s1 === 1.U) {
    currentLevel := State.Level1       // Between s[2] and s[1]
  }.otherwise {
    currentLevel := State.Level0       // Below s[1]
  }
  
  // State transition logic
  when(io.reset) {
    state := State.Level0
    prevState := State.Level0
  }.otherwise {
    when(state =/= currentLevel) {
      prevState := state
      state := currentLevel
    }
  }
  
  // Output logic
  // Default values
  io.fr1 := false.B
  io.fr2 := false.B
  io.fr3 := false.B
  io.dfr := false.B
  
  // Set nominal flow rate based on water level
  switch(state) {
    is(State.Level0) {  // Below s[1]
      io.fr1 := true.B
      io.fr2 := true.B
      io.fr3 := true.B
    }
    is(State.Level1) {  // Between s[2] and s[1]
      io.fr1 := true.B
      io.fr2 := true.B
    }
    is(State.Level2) {  // Between s[3] and s[2]
      io.fr1 := true.B
    }
    is(State.Level3) {  // Above s[3]
      // All flow rates are off (default values)
    }
  }
  
  // Set supplemental flow valve (dfr) when water level is rising
  when(prevState < state) {
    io.dfr := true.B
  }
  
  // Handle reset case explicitly
  when(io.reset) {
    io.fr1 := true.B
    io.fr2 := true.B
    io.fr3 := true.B
    io.dfr := true.B
  }
}

// Generate the Verilog
/*
object dutDriver extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut())
}
*/
