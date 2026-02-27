import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val load = Input(Bool())
    val data = Input(UInt(256.W))
    val q = Output(UInt(256.W))
  })

  // Current state of the grid
  val grid = RegInit(0.U(256.W))

  // Load new data into the grid when load is high
  when(io.load) {
    grid := io.data
  }.otherwise {
    // Compute the next state of the grid
    val nextGrid = Wire(Vec(256, Bool()))

    for (i <- 0 until 16) {
      for (j <- 0 until 16) {
        // Calculate the index in the 1D vector
        val idx = i * 16 + j

        // Get the current cell state
        val cell = grid(idx)

        // Calculate the number of live neighbors
        val neighbors = (for {
          di <- -1 to 1
          dj <- -1 to 1
          if di != 0 || dj != 0
        } yield {
          // Wrap around using modulo 16 for toroidal grid
          val ni = (i + di + 16) % 16
          val nj = (j + dj + 16) % 16
          val neighborIdx = ni * 16 + nj
          grid(neighborIdx)
        }).reduce(_ + _)

        // Apply the rules of the game
        nextGrid(idx) := MuxCase(cell, Seq(
          (neighbors < 2.U) -> false.B,
          (neighbors === 2.U) -> cell,
          (neighbors === 3.U) -> true.B,
          (neighbors > 3.U) -> false.B
        ))
      }
    }

    // Update the grid with the next state
    grid := nextGrid.asUInt
  }

  // Output the current state of the grid
  io.q := grid
}

/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(), Array("--target-dir", "generated"))
}
*/
