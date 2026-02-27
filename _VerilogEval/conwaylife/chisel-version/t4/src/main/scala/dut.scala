import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val load = Input(Bool())
    val data = Input(UInt(256.W))
    val q = Output(UInt(256.W))
  })

  // Current state of the 16x16 grid
  val grid = RegInit(0.U(256.W))

  // Update grid when load is high
  when(io.load) {
    grid := io.data
  }.otherwise {
    // Compute next state of the grid
    val nextGrid = Wire(Vec(256, Bool()))

    for (i <- 0 until 16) {
      for (j <- 0 until 16) {
        // Calculate the index of the current cell
        val idx = i * 16 + j

        // Get the 8 neighbors with toroidal wrapping
        val neighbors = VecInit(Seq(
          grid((((i - 1 + 16) % 16) * 16 + ((j - 1 + 16) % 16)).U), // Top-left
          grid((((i - 1 + 16) % 16) * 16 + j.U),                   // Top
          grid((((i - 1 + 16) % 16) * 16 + ((j + 1) % 16)).U),     // Top-right
          grid((i * 16 + ((j - 1 + 16) % 16)).U),                 // Left
          grid((i * 16 + ((j + 1) % 16)).U),                      // Right
          grid((((i + 1) % 16) * 16 + ((j - 1 + 16) % 16)).U),    // Bottom-left
          grid((((i + 1) % 16) * 16 + j.U),                       // Bottom
          grid((((i + 1) % 16) * 16 + ((j + 1) % 16)).U)          // Bottom-right
        ))

        // Count the number of alive neighbors
        val aliveNeighbors = neighbors.map(_.asBool).reduce(_ + _)

        // Apply the rules of the game
        nextGrid(idx) := MuxCase(
          false.B, // Default case (dead)
          Seq(
            (aliveNeighbors === 2.U) -> grid(idx), // Rule 2: No change
            (aliveNeighbors === 3.U) -> true.B,    // Rule 3: Alive
            (aliveNeighbors < 2.U || aliveNeighbors > 3.U) -> false.B // Rules 1 & 4: Dead
          )
        )
      }
    }

    // Update the grid to the next state
    grid := nextGrid.asUInt
  }

  // Output the current state of the grid
  io.q := grid
}

// Generate Verilog
/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(), args)
}
*/
