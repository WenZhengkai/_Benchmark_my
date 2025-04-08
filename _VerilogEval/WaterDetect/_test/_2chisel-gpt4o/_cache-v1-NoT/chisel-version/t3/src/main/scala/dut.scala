import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val s = Input(UInt(3.W))    // 3-bit input vector
    val fr3 = Output(Bool())    // Single-bit output
    val fr2 = Output(Bool())    // Single-bit output
    val fr1 = Output(Bool())    // Single-bit output
    val dfr = Output(Bool())    // Single-bit output
  })

  // Synchronous Reset (Active High)
  val resetReg = WireDefault(reset.asBool())

  // Registers to store outputs
  val fr3Reg = RegInit(true.B)  // fr3 output register (default 1)
  val fr2Reg = RegInit(true.B)  // fr2 output register (default 1)
  val fr1Reg = RegInit(true.B)  // fr1 output register (default 1)
  val dfrReg = RegInit(true.B)  // dfr output register (default 1)

  // Previous sensor state register
  val prevState = RegInit(0.U(3.W)) // Initial state for previous sensors is "0"

  // Logic for water level and flow rate control
  when(resetReg) {
    // On reset, all flow rates and dfr are set to high (default condition)
    fr3Reg := true.B
    fr2Reg := true.B
    fr1Reg := true.B
    dfrReg := true.B
    prevState := 0.U
  }.otherwise {
    // Logic based on the current sensor state `s`
    when(io.s === "b111".U) {
      fr3Reg := false.B
      fr2Reg := false.B
      fr1Reg := false.B
    }.elsewhen(io.s === "b011".U) {
      fr3Reg := false.B
      fr2Reg := false.B
      fr1Reg := true.B
    }.elsewhen(io.s === "b001".U) {
      fr3Reg := false.B
      fr2Reg := true.B
      fr1Reg := true.B
    }.otherwise { // io.s === "b000".U
      fr3Reg := true.B
      fr2Reg := true.B
      fr1Reg := true.B
    }

    // Logic for supplemental flow valve (dfr)
    when(io.s > prevState) {
      // If water level has increased compared to previous state
      dfrReg := true.B
    }.otherwise {
      // Otherwise, keep dfr low
      dfrReg := false.B
    }

    // Update the previous state to the current state
    prevState := io.s
  }

  // Connect the registers to the output ports
  io.fr3 := fr3Reg
  io.fr2 := fr2Reg
  io.fr1 := fr1Reg
  io.dfr := dfrReg
}

// Generate Verilog
/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut())
}
*/
