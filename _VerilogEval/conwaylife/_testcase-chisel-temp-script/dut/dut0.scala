import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val load = Input(Bool())
    val data = Input(UInt(256.W))
    val q = Output(UInt(256.W))
  })

  // Register to hold the current state of the 16x16 grid
  val stateReg = RegInit(0.U(256.W))

  // When load is high, load the data into the state register
  when(io.load) {
    stateReg := io.data
  }.otherwise {
    // Compute the next state of the grid
    val nextState = Wire(Vec(256, Bool()))

    for (i <- 0 until 256) {
      // Calculate the row and column of the current cell
      val row = i / 16
      val col = i % 16

      // Count the number of alive neighbors (8 neighbors in a toroidal grid)
      var neighborCount = 0

      // Iterate over the 8 neighbors
      for (dx <- -1 to 1) {
        for (dy <- -1 to 1) {
          if (dx != 0 || dy != 0) {
            // Calculate the neighbor's row and column with wrap-around
            val neighborRow = (row + dy + 16) % 16
            val neighborCol = (col + dx + 16) % 16

            // Calculate the neighbor's index in the state vector
            val neighborIdx = neighborRow * 16 + neighborCol

            // Add to the neighbor count if the neighbor is alive
            neighborCount += stateReg(neighborIdx).asBool().asUInt()
          }
        }
      }

      // Apply the rules of the game of life
      nextState(i) := MuxCase(stateReg(i).asBool(), Seq(
        (neighborCount <= 1.U) -> false.B,
        (neighborCount === 2.U) -> stateReg(i).asBool(),
        (neighborCount === 3.U) -> true.B,
        (neighborCount >= 4.U) -> false.B
      ))
    }

    // Update the state register with the next state
    stateReg := nextState.asUInt()
  }

  // Output the current state
  io.q := stateReg
}

// Generate Verilog code
/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(), args)
}
*/
