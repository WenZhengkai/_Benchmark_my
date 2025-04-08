import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val s     = Input(UInt(3.W))  // Sensor input vector
    val fr3   = Output(Bool())   // Flow rate control outputs
    val fr2   = Output(Bool())
    val fr1   = Output(Bool())
    val dfr   = Output(Bool())   // Supplemental flow valve output
  })

  // State registers
  val prevS = RegInit(0.U(3.W)) // Register to store the previous sensor readings

  // Output registers with default initial values upon reset
  val fr3Reg = RegInit(true.B)
  val fr2Reg = RegInit(true.B)
  val fr1Reg = RegInit(true.B)
  val dfrReg = RegInit(true.B)

  // Connect the registers to the outputs
  io.fr3 := fr3Reg
  io.fr2 := fr2Reg
  io.fr1 := fr1Reg
  io.dfr := dfrReg

  // Flow control logic based on sensor readings
  when(reset.asBool()) {
    // Synchronous reset: All outputs set to 1
    fr3Reg := true.B
    fr2Reg := true.B
    fr1Reg := true.B
    dfrReg := true.B
    prevS := 0.U
  }.otherwise {
    // Water level to flow rate mapping
    when(io.s(2)) { // Highest water level (above s[3])
      fr3Reg := false.B
      fr2Reg := false.B
      fr1Reg := false.B
    }.elsewhen(io.s(1)) { // Between s[3] and s[2]
      fr3Reg := false.B
      fr2Reg := false.B
      fr1Reg := true.B
    }.elsewhen(io.s(0)) { // Between s[2] and s[1]
      fr3Reg := false.B
      fr2Reg := true.B
      fr1Reg := true.B
    }.otherwise { // Below s[1]
      fr3Reg := true.B
      fr2Reg := true.B
      fr1Reg := true.B
    }

    // Supplemental flow control based on current and previous water level
    when(io.s > prevS) { // Water level increased
      dfrReg := true.B
    }.otherwise { // Water level stayed the same or decreased
      dfrReg := false.B
    }

    // Update the previous state
    prevS := io.s
  }
}

// Generate Verilog for the module
/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut())
}
*/
