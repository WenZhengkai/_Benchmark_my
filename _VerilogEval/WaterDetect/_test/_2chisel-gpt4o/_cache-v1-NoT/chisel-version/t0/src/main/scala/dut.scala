import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val s = Input(UInt(3.W))  // Sensor inputs as a 3-bit vector
    val fr3 = Output(Bool())  // Output flow rate control 3
    val fr2 = Output(Bool())  // Output flow rate control 2
    val fr1 = Output(Bool())  // Output flow rate control 1
    val dfr = Output(Bool())  // Output supplemental flow valve 
  })

  // Synchronous reset signal
  val resetSync = WireDefault(reset.asBool)

  // Registers to maintain state
  val prevState = RegInit(0.U(3.W))  // Holds previous state of sensor inputs
  val fr3Reg = RegInit(true.B)       // Registers for outputs, default to 1 on reset
  val fr2Reg = RegInit(true.B)
  val fr1Reg = RegInit(true.B)
  val dfrReg = RegInit(true.B)

  // Assign outputs to their respective registers
  io.fr3 := fr3Reg
  io.fr2 := fr2Reg
  io.fr1 := fr1Reg
  io.dfr := dfrReg

  // Main logic
  when(resetSync) {
    // On reset, set all registers to default values
    prevState := 0.U(3.W)
    fr3Reg := true.B
    fr2Reg := true.B
    fr1Reg := true.B
    dfrReg := true.B
  }.otherwise {
    // Update the state machine logic based on sensor inputs
    when(io.s === "b111".U) { // Above s[3]
      fr3Reg := false.B
      fr2Reg := false.B
      fr1Reg := false.B
    }.elsewhen(io.s === "b011".U) { // Between s[3] and s[2]
      fr3Reg := false.B
      fr2Reg := false.B
      fr1Reg := true.B
    }.elsewhen(io.s === "b001".U) { // Between s[2] and s[1]
      fr3Reg := false.B
      fr2Reg := true.B
      fr1Reg := true.B
    }.otherwise { // Below s[1]
      fr3Reg := true.B
      fr2Reg := true.B
      fr1Reg := true.B
    }

    // Implement dfr logic based on change in state
    // dfr is 1 if the water level increases compared to previous state
    dfrReg := io.s > prevState

    // Update the previous state with the current sensor input
    prevState := io.s
  }
}

/*
object dutDriver extends App {
  // Generates the Verilog code for the dut module
  chisel3.Driver.execute(args, () => new dut)
}
*/
