import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val s = Input(UInt(3.W))   // input bit vector of size 3
    val fr3 = Output(Bool())   // flow rate output for sensor 3
    val fr2 = Output(Bool())   // flow rate output for sensor 2
    val fr1 = Output(Bool())   // flow rate output for sensor 1
    val dfr = Output(Bool())   // supplemental flow valve output
  })

  // Registers to hold the state of outputs and previous input
  val prevS = RegInit(0.U(3.W))    // Register to store the previous state of `s`
  val fr3Reg = RegInit(true.B)    // Register for fr3, initialized to 1 on reset
  val fr2Reg = RegInit(true.B)    // Register for fr2, initialized to 1 on reset
  val fr1Reg = RegInit(true.B)    // Register for fr1, initialized to 1 on reset
  val dfrReg = RegInit(true.B)    // Register for dfr, initialized to 1 on reset

  // Assign registers to I/O ports
  io.fr3 := fr3Reg
  io.fr2 := fr2Reg
  io.fr1 := fr1Reg
  io.dfr := dfrReg

  // Flow control logic
  when(reset.asBool()) {
    // On reset, set all outputs to 1
    fr3Reg := true.B
    fr2Reg := true.B
    fr1Reg := true.B
    dfrReg := true.B
    prevS := 0.U
  } .otherwise {
    // Update flow rate logic based on the current state of sensors (io.s)
    switch(io.s) {
      is("b111".U) { // Water level above s[3]
        fr3Reg := false.B
        fr2Reg := false.B
        fr1Reg := false.B
      }
      is("b110".U) { // Water level between s[3] and s[2]
        fr3Reg := false.B
        fr2Reg := false.B
        fr1Reg := true.B
      }
      is("b100".U) { // Water level between s[2] and s[1]
        fr3Reg := false.B
        fr2Reg := true.B
        fr1Reg := true.B
      }
      is("b000".U) { // Water level below s[1]
        fr3Reg := true.B
        fr2Reg := true.B
        fr1Reg := true.B
      }
    }

    // Detect change in water level for `dfr` logic
    when(io.s > prevS) {          // Current water level is higher than the previous level
      dfrReg := true.B
    } .otherwise {                // Water level is the same or lower
      dfrReg := false.B
    }

    // Update previous state of sensors
    prevS := io.s
  }
}

// Generate Verilog for the design
/*
object dutMain extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut())
}
*/
