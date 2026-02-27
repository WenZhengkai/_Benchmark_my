import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val s = Input(UInt(3.W))  // 3 sensors, s[3] to s[1]
    val reset = Input(Bool()) // Active-high synchronous reset
    val fr3 = Output(Bool())  // Flow rate control 3
    val fr2 = Output(Bool())  // Flow rate control 2
    val fr1 = Output(Bool())  // Flow rate control 1
    val dfr = Output(Bool())  // Supplemental flow valve
  })

  // Define states for level tracking
  val sAboveS3 :: sBetweenS3S2 :: sBetweenS2S1 :: sBelowS1 :: Nil = Enum(4)
  
  // State register
  val state = RegInit(sBelowS1)
  val prevState = RegNext(state)
  
  // Parse the sensor inputs into a state
  val currentState = Wire(UInt(2.W))
  currentState := MuxCase(sBelowS1, Array(
    (io.s === 7.U) -> sAboveS3,        // All sensors on (s[3:1] = 111)
    (io.s === 6.U) -> sBetweenS3S2,    // s[1] and s[2] on (s[3:1] = 110)
    (io.s === 4.U) -> sBetweenS3S2,    // s[3] and s[1] on - not physically possible but handle it
    (io.s === 2.U) -> sBelweenS3S2,    // Only s[2] on - not physically possible but handle it
    (io.s === 3.U) -> sBetweenS3S2,    // s[1] and s[3] on - not physically possible but handle it
    (io.s === 1.U) -> sBetweenS2S1     // Only s[1] on (s[3:1] = 001)
  ))

  // Update state based on sensor readings or reset
  when (io.reset) {
    state := sBelowS1
  } .otherwise {
    state := currentState
  }

  // Determine if the water level is rising
  val isRising = state > prevState
  
  // Set output flow rates based on current state
  io.fr1 := MuxCase(false.B, Array(
    (state === sBelowS1) -> true.B,
    (state === sBetweenS2S1) -> true.B,
    (state === sBetweenS3S2) -> true.B
  ))
  
  io.fr2 := MuxCase(false.B, Array(
    (state === sBelowS1) -> true.B,
    (state === sBetweenS2S1) -> true.B
  ))
  
  io.fr3 := state === sBelowS1
  
  // Supplemental flow valve should be on when the water level is rising
  io.dfr := MuxCase(false.B, Array(
    (io.reset) -> true.B,              // Active during reset
    (state === sBelowS1) -> true.B,    // Always on when below s[1]
    (isRising) -> true.B               // On when water level is rising
  ))
}

// This allows the module to be run standalone
/*
object dutDriver extends App {
  chisel3.Driver.execute(args, () => new dut)
}
*/
