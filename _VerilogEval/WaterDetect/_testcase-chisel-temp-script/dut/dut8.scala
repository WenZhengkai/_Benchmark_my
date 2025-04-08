import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val s = Input(UInt(3.W))         // Input sensors [3:1]
    val fr3 = Output(Bool())         // Output Nominal flow control
    val fr2 = Output(Bool())
    val fr1 = Output(Bool())
    val dfr = Output(Bool())         // Output Supplemental flow valve
    val reset = Input(Bool())        // Synchronous reset (active-high)
  })

  // State register to hold the previous sensor state
  val prevSensorState = RegInit(0.U(3.W))

  // Default output values
  io.fr3 := false.B
  io.fr2 := false.B
  io.fr1 := false.B
  io.dfr := false.B

  // Active-high synchronous reset logic
  when(io.reset) {
    io.fr3 := true.B
    io.fr2 := true.B
    io.fr1 := true.B
    io.dfr := true.B
    prevSensorState := 0.U
  }.otherwise {
    // Update state based on water level
    val s1 = io.s(0) // Sensor 1 state
    val s2 = io.s(1) // Sensor 2 state
    val s3 = io.s(2) // Sensor 3 state

    switch(io.s) {
      is("b111".U) { // Above s[3]: All sensors asserted
        // All outputs remain off
      }
      is("b011".U) { // Between s[3] and s[2]: s[1] and s[2] asserted
        io.fr1 := true.B
      }
      is("b001".U) { // Between s[2] and s[1]: Only s[1] asserted
        io.fr1 := true.B
        io.fr2 := true.B
      }
      is("b000".U) { // Below s[1]: No sensors asserted
        io.fr1 := true.B
        io.fr2 := true.B
        io.fr3 := true.B
      }
    }

    // Determine supplemental flow valve (dfr) logic
    io.dfr := prevSensorState < io.s
    prevSensorState := io.s
  }
}

/*
object dut extends App {
  chisel3.Driver.execute(args, () => new dut)
}
*/
