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

  // Load new data into the state register when load is high
  when(io.load) {
    stateReg := io.data
  }.otherwise {
    // Compute the next state of the grid
    val nextState = Wire(Vec(256, Bool()))

    for (i <- 0 until 256) {
      // Get the row and column indices of the current cell
      val row = i / 16
      val col = i % 16

      // Calculate the indices of the 8 neighbors (with toroidal wrapping)
      val neighbors = Seq(
        ((row - 1 + 16) % 16, (col - 1 + 16) % 16), // top-left
        ((row - 1 + 16) % 16, col),                // top
        ((row - 1 + 16) % 16, (col + 1) % 16),     // top-right
        (row, (col - 1 + 16) % 16),                // left
        (row, (col + 1) % 16),                     // right
        ((row + 1) % 16, (col - 1 + 16) % 16),     // bottom-left
        ((row + 1) % 16, col),                     // bottom
        ((row + 1) % 16, (col + 1) % 16)           // bottom-right
      )

      // Count the number of alive neighbors
      val neighborCount = neighbors.map { case (r, c) =>
        stateReg((r * 16 + c).U)
      }.reduce(_ +& _)

      // Apply the rules of the Game of Life
      nextState(i) := MuxCase(stateReg(i.U), Seq(
        (neighborCount === 0.U || neighborCount === 1.U) -> false.B,
        (neighborCount === 3.U) -> true.B,
        (neighborCount >= 4.U) -> false.B
      ))
    }

    // Update the state register with the next state
    stateReg := nextState.asUInt
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
