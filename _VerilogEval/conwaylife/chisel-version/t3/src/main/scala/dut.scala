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
    // Update the grid based on the rules of the Game of Life
    val nextGrid = Wire(Vec(256, Bool()))

    for (i <- 0 until 16) {
      for (j <- 0 until 16) {
        // Calculate the number of alive neighbors
        val neighbors = countNeighbors(i, j)

        // Get the current state of the cell
        val currentState = grid(i * 16 + j)

        // Apply the rules of the Game of Life
        nextGrid(i * 16 + j) := MuxCase(currentState, Seq(
          (neighbors < 2.U) -> false.B,
          (neighbors === 2.U) -> currentState,
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

  // Helper function to count the number of alive neighbors for a given cell
  def countNeighbors(row: Int, col: Int): UInt = {
    val neighborIndices = Seq(
      ((row - 1 + 16) % 16, (col - 1 + 16) % 16),
      ((row - 1 + 16) % 16, col),
      ((row - 1 + 16) % 16, (col + 1) % 16),
      (row, (col - 1 + 16) % 16),
      (row, (col + 1) % 16),
      ((row + 1) % 16, (col - 1 + 16) % 16),
      ((row + 1) % 16, col),
      ((row + 1) % 16, (col + 1) % 16)
    )

    neighborIndices.map { case (r, c) =>
      grid(r * 16 + c)
    }.reduce(_ +& _)
  }
}

// Generate Verilog code
/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut())
}
*/
