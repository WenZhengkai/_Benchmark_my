import chisel3._
import chisel3.util._

// Define the dut module
class dut extends Module {
  val io = IO(new Bundle {
    val s = Input(UInt(3.W))      // Input bit vector [3:1]
    val fr3 = Output(Bool())      // Output single-bit register fr3
    val fr2 = Output(Bool())      // Output single-bit register fr2
    val fr1 = Output(Bool())      // Output single-bit register fr1
    val dfr = Output(Bool())      // Output single-bit register dfr
    val reset = Input(Bool())     // Active-high synchronous reset signal
  })

  // Define registers to store previous state of inputs and outputs
  val prev_s = RegInit(0.U(3.W))  // Register to store previous sensor state
  val fr3_reg = RegInit(true.B)   // Register for fr3, initialize to 1
  val fr2_reg = RegInit(true.B)   // Register for fr2, initialize to 1
  val fr1_reg = RegInit(true.B)   // Register for fr1, initialize to 1
  val dfr_reg = RegInit(true.B)   // Register for dfr, initialize to 1

  // Connect registers to outputs
  io.fr3 := fr3_reg
  io.fr2 := fr2_reg
  io.fr1 := fr1_reg
  io.dfr := dfr_reg

  // Define logic for water level monitoring and flow control
  when(io.reset) {
    // If reset is active, set all outputs to 1 and reset previous state
    fr3_reg := true.B
    fr2_reg := true.B
    fr1_reg := true.B
    dfr_reg := true.B
    prev_s := 0.U(3.W)
  } .otherwise {
    // Monitor current water level and make decisions on flow
    when(io.s(2)) {
      // Water level is above s[3], turn off all flow rates
      fr3_reg := false.B
      fr2_reg := false.B
      fr1_reg := false.B
    } .elsewhen(io.s(1)) {
      // Water level is between s[3] and s[2], set fr1 to 1
      fr3_reg := false.B
      fr2_reg := false.B
      fr1_reg := true.B
    } .elsewhen(io.s(0)) {
      // Water level is between s[2] and s[1], set fr1 and fr2 to 1
      fr3_reg := false.B
      fr2_reg := true.B
      fr1_reg := true.B
    } .otherwise {
      // Water level is below s[1], turn on all flow rates
      fr3_reg := true.B
      fr2_reg := true.B
      fr1_reg := true.B
    }

    // Determine the supplemental flow valve output (dfr)
    when(io.s > prev_s) {
      // Water level increases, set dfr to 1
      dfr_reg := true.B
    } .otherwise {
      // Water level remains same or decreases, set dfr to 0
      dfr_reg := false.B
    }

    // Update previous sensor state
    prev_s := io.s
  }
}

// Generate the Verilog code for the module
/*
object dut extends App {
  emitVerilog(new dut)
}
*/
