import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val s = Input(UInt(3.W))  // 3 sensors, s[3] (MSB) to s[1] (LSB)
    val reset = Input(Bool()) // Active-high synchronous reset
    val fr3 = Output(Bool())  // Flow rate control 3
    val fr2 = Output(Bool())  // Flow rate control 2
    val fr1 = Output(Bool())  // Flow rate control 1
    val dfr = Output(Bool())  // Supplemental flow valve
  })

  // State definition
  val sRising :: sFalling :: Nil = Enum(2)
  val state = RegInit(sFalling)
  
  // Previous sensor reading to detect changes
  val prevSensor = RegInit(0.U(3.W))
  
  // Flow rate outputs
  val fr1Reg = RegInit(true.B)
  val fr2Reg = RegInit(true.B)
  val fr3Reg = RegInit(true.B)
  val dfrReg = RegInit(true.B)
  
  // Check if water level is rising or falling
  val isRising = io.s > prevSensor
  val isFalling = io.s < prevSensor
  
  // Main state machine logic
  when(io.reset) {
    // Reset to state equivalent to water level being low for a long time
    state := sFalling
    fr1Reg := true.B
    fr2Reg := true.B
    fr3Reg := true.B
    dfrReg := true.B
    prevSensor := 0.U
  }.elsewhen(isRising || isFalling) {
    // Update state when sensors change
    state := Mux(isRising, sRising, sFalling)
    prevSensor := io.s
    
    // Set nominal flow rates based on water level
    when(io.s === 7.U) {        // All sensors active (s[3], s[2], s[1])
      fr1Reg := false.B
      fr2Reg := false.B
      fr3Reg := false.B
    }.elsewhen(io.s === 6.U || io.s === 3.U) {  // s[3], s[2] or s[2], s[1]
      fr1Reg := true.B
      fr2Reg := false.B
      fr3Reg := false.B
    }.elsewhen(io.s === 2.U || io.s === 1.U) {  // Just s[2] or just s[1]
      fr1Reg := true.B
      fr2Reg := true.B
      fr3Reg := false.B
    }.otherwise {               // No sensors active
      fr1Reg := true.B
      fr2Reg := true.B
      fr3Reg := true.B
    }
    
    // Set supplemental flow based on level trend
    dfrReg := isRising
  }
  
  // Connect registers to outputs
  io.fr1 := fr1Reg
  io.fr2 := fr2Reg
  io.fr3 := fr3Reg
  io.dfr := dfrReg
}

// Object to make the module instantiable from REPL
/*
object dut extends App {
  chisel3.Driver.execute(args, () => new dut)
}
*/
