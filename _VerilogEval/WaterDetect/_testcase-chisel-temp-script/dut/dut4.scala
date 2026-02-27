import chisel3._
import chisel3.util._

class WaterReservoirController extends Module {
  val io = IO(new Bundle {
    val s = Input(UInt(3.W))  // 3 sensors, s[3] (MSB) to s[1] (LSB)
    val fr3 = Output(Bool())  // Flow rate control signals
    val fr2 = Output(Bool())
    val fr1 = Output(Bool())
    val dfr = Output(Bool())  // Supplemental flow valve
    val reset = Input(Bool()) // Active-high synchronous reset
  })

  // Define states for the state machine
  val sAboveS3 :: sBetweenS3S2 :: sBetweenS2S1 :: sBelowS1 :: Nil = Enum(4)
  
  // State register
  val state = RegInit(sBelowS1)
  val prevState = RegInit(sBelowS1)
  
  // Determine current water level based on sensors
  val currentState = Wire(UInt(2.W))
  currentState := MuxLookup(io.s, sBelowS1, Seq(
    "b111".U -> sAboveS3,       // s[3], s[2], s[1] are all on
    "b011".U -> sBetweenS3S2,   // s[2], s[1] are on, s[3] is off
    "b001".U -> sBetweenS2S1,   // s[1] is on, s[3], s[2] are off
    "b000".U -> sBelowS1        // All sensors are off
  ))
  
  // State transition logic
  when (io.reset) {
    state := sBelowS1
    prevState := sBelowS1
  } .otherwise {
    when (state =/= currentState) {
      prevState := state
      state := currentState
    }
  }
  
  // Output logic for flow rate control
  val fr1Out = Wire(Bool())
  val fr2Out = Wire(Bool())
  val fr3Out = Wire(Bool())
  val dfrOut = Wire(Bool())
  
  // Default values
  fr1Out := false.B
  fr2Out := false.B
  fr3Out := false.B
  dfrOut := false.B
  
  // Nominal flow rate based on current water level
  switch (state) {
    is (sAboveS3) {
      // No flow needed
      fr1Out := false.B
      fr2Out := false.B
      fr3Out := false.B
    }
    is (sBetweenS3S2) {
      fr1Out := true.B
      fr2Out := false.B
      fr3Out := false.B
    }
    is (sBetweenS2S1) {
      fr1Out := true.B
      fr2Out := true.B
      fr3Out := false.B
    }
    is (sBelowS1) {
      fr1Out := true.B
      fr2Out := true.B
      fr3Out := true.B
    }
  }
  
  // Supplemental flow control (dfr)
  // Activate when the level is rising (previous level was lower than current)
  dfrOut := prevState > state
  
  // Register outputs to avoid combinational loops
  io.fr1 := fr1Out
  io.fr2 := fr2Out
  io.fr3 := fr3Out
  io.dfr := dfrOut
}

// This is the top-level module matching the specified name
class dut extends Module {
  val io = IO(new Bundle {
    val s = Input(UInt(3.W))
    val fr3 = Output(Bool())
    val fr2 = Output(Bool())
    val fr1 = Output(Bool())
    val dfr = Output(Bool())
  })
  
  val controller = Module(new WaterReservoirController())
  
  controller.io.s := io.s
  controller.io.reset := reset.asBool
  
  io.fr1 := controller.io.fr1
  io.fr2 := controller.io.fr2
  io.fr3 := controller.io.fr3
  io.dfr := controller.io.dfr
}
