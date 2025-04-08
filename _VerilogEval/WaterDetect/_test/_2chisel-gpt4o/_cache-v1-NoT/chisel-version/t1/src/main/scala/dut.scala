import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val s = Input(UInt(3.W)) // Input 3-bit vector representing the sensor states
    val fr3 = Output(Bool()) // Flow rate control register 3
    val fr2 = Output(Bool()) // Flow rate control register 2
    val fr1 = Output(Bool()) // Flow rate control register 1
    val dfr = Output(Bool()) // Supplemental flow valve output
  })

  // Internal registers
  val prevS = RegInit(0.U(3.W)) // Register to store the previous state of input sensors
  
  // Output registers with synchronous reset; when reset is true, set all to 1
  val fr3Reg = RegInit(true.B)
  val fr2Reg = RegInit(true.B)
  val fr1Reg = RegInit(true.B)
  val dfrReg = RegInit(true.B)

  // Connect output IOs to the registers
  io.fr3 := fr3Reg
  io.fr2 := fr2Reg
  io.fr1 := fr1Reg
  io.dfr := dfrReg

  // Logic for state machine, flow rates (`fr`) and supplemental flow valve (`dfr`)
  when (reset.asBool()) {
    // Synchronous reset
    fr3Reg := true.B
    fr2Reg := true.B
    fr1Reg := true.B
    dfrReg := true.B
    prevS := 0.U // Reset previous sensor state to indicate no water detected
  } .otherwise {
    // Logic to detect the water level and control flow rates
    switch(io.s) {
      is("b111".U) { // All sensors active (highest water level)
        fr1Reg := false.B
        fr2Reg := false.B
        fr3Reg := false.B
      }
      is("b110".U) { // Water between s[3] and s[2]
        fr1Reg := true.B
        fr2Reg := false.B
        fr3Reg := false.B
      }
      is("b100".U) { // Water between s[2] and s[1]
        fr1Reg := true.B
        fr2Reg := true.B
        fr3Reg := false.B
      }
      is("b000".U) { // Below s[1] (lowest water level)
        fr1Reg := true.B
        fr2Reg := true.B
        fr3Reg := true.B
      }
    }

    // Logic to calculate `dfr`
    // If current water level (io.s) is higher than the previous level (prevS), set `dfrReg` to 1
    when(io.s > prevS) {
      dfrReg := true.B
    } .otherwise {
      dfrReg := false.B
    }

    // Update the previous state
    prevS := io.s
  }
}

// Generate the Verilog code for the dut module
/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut())
}
*/
