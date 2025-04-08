import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val s = Input(UInt(3.W))     // 3-bit input vector for sensors
    val fr3 = Output(Bool())     // Output for flow rate 3
    val fr2 = Output(Bool())     // Output for flow rate 2
    val fr1 = Output(Bool())     // Output for flow rate 1
    val dfr = Output(Bool())     // Output for supplemental flow valve
  })

  // State registers
  val prevS = RegInit(0.U(3.W))    // Register to hold the previous sensor values
  val fr3_reg = RegInit(true.B)    // Register for fr3
  val fr2_reg = RegInit(true.B)    // Register for fr2
  val fr1_reg = RegInit(true.B)    // Register for fr1
  val dfr_reg = RegInit(true.B)    // Register for dfr

  // Assign output registers to output ports
  io.fr3 := fr3_reg
  io.fr2 := fr2_reg
  io.fr1 := fr1_reg
  io.dfr := dfr_reg

  // Flow rate logic based on sensor states
  when (reset.asBool()) {
    // Reset all outputs and state registers
    fr3_reg := true.B
    fr2_reg := true.B
    fr1_reg := true.B
    dfr_reg := true.B
    prevS := 0.U
  } .otherwise {
    // Update state based on sensor readings (io.s)
    when (io.s(2)) { // Above sensor 3
      fr3_reg := false.B
      fr2_reg := false.B
      fr1_reg := false.B
    } .elsewhen (io.s(1)) { // Between sensor 3 and sensor 2
      fr3_reg := false.B
      fr2_reg := false.B
      fr1_reg := true.B
    } .elsewhen (io.s(0)) { // Between sensor 2 and sensor 1
      fr3_reg := false.B
      fr2_reg := true.B
      fr1_reg := true.B
    } .otherwise { // Below sensor 1
      fr3_reg := true.B
      fr2_reg := true.B
      fr1_reg := true.B
    }

    // Supplemental flow valve logic (dfr)
    when (io.s > prevS) {
      dfr_reg := true.B // Water level is rising
    } .otherwise {
      dfr_reg := false.B // Water level is not rising
    }

    // Update previous sensor values
    prevS := io.s
  }
}

/*
object dut extends App {
  println(getVerilog(new dut))
}
*/
