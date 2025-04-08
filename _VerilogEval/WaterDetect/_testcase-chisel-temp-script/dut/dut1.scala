import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val s = Input(UInt(3.W)) // 3 sensor inputs represented as a 3-bit vector
    val fr3 = Output(Bool()) // Flow Rate 3 output
    val fr2 = Output(Bool()) // Flow Rate 2 output
    val fr1 = Output(Bool()) // Flow Rate 1 output
    val dfr = Output(Bool()) // Supplemental flow valve
    val reset_sync = Input(Bool()) // Synchronous reset signal
  })

  // Initialize outputs
  io.fr3 := false.B
  io.fr2 := false.B
  io.fr1 := false.B
  io.dfr := false.B

  // State register to track the previous water level
  val prevSensors = RegInit(0.U(3.W))

  // Control logic
  when(io.reset_sync) {
    // Active-high synchronous reset
    // Assuming low water level state (all fr3, fr2, fr1, and dfr asserted)
    io.fr3 := true.B
    io.fr2 := true.B
    io.fr1 := true.B
    io.dfr := false.B
    prevSensors := 0.U // Reset the previous sensor state
  }.otherwise {
    // Normal operation
    when(io.s === "b111".U) { // Above s[3]
      io.fr3 := false.B
      io.fr2 := false.B
      io.fr1 := false.B
      io.dfr := false.B
    }.elsewhen(io.s === "b011".U) { // Between s[3] and s[2]
      io.fr3 := false.B
      io.fr2 := false.B
      io.fr1 := true.B
      io.dfr := false.B
    }.elsewhen(io.s === "b001".U) { // Between s[2] and s[1]
      io.fr3 := false.B
      io.fr2 := true.B
      io.fr1 := true.B
      io.dfr := prevSensors < io.s // Open supplemental flow if previous was lower
    }.elsewhen(io.s === "b000".U) { // Below s[1]
      io.fr3 := true.B
      io.fr2 := true.B
      io.fr1 := true.B
      io.dfr := false.B
    }

    // Update the previous sensor state
    prevSensors := io.s
  }
}

/*
object dut extends App {
  chisel3.Driver.execute(args, () => new dut)
}
*/
