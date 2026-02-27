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
        // Get the current cell's index
        val idx = i * 16 + j

        // Get the 8 neighbors with toroidal wrapping
        val neighbors = Seq(
          ((i - 1 + 16) % 16, (j - 1 + 16) % 16), // top-left
          ((i - 1 + 16) % 16, j),                // top
          ((i - 1 + 16) % 16, (j + 1) % 16),     // top-right
          (i, (j - 1 + 16) % 16),                // left
          (i, (j + 1) % 16),                     // right
          ((i + 1) % 16, (j - 1 + 16) % 16),     // bottom-left
          ((i + 1) % 16, j),                     // bottom
          ((i + 1) % 16, (j + 1) % 16)           // bottom-right
        )

        // Count the number of alive neighbors
        val neighborCount = neighbors.map { case (ni, nj) =>
          grid(ni * 16 + nj)
        }.reduce(_ +& _)

        // Determine the next state of the cell based on the rules
        nextGrid(idx) := MuxCase(
          false.B, // Default case (should not happen)
          Seq(
            (neighborCount === 0.U || neighborCount === 1.U) -> false.B,
            (neighborCount === 2.U) -> grid(idx),
            (neighborCount === 3.U) -> true.B,
            (neighborCount >= 4.U) -> false.B
          )
        )
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
  (new chisel3.stage.ChiselStage).emitVerilog(new dut, Array("--target-dir", "generated"))
}
*/
