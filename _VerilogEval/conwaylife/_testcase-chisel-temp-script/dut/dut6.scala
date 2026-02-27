import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val load = Input(Bool())
    val data = Input(UInt(256.W))
    val q = Output(UInt(256.W))
  })

  // Internal register to hold the current state of the game
  val stateReg = RegInit(0.U(256.W))

  // Load new data into the state register when load is high
  when(io.load) {
    stateReg := io.data
  }.otherwise {
    // Compute the next state of the game
    val nextState = Wire(Vec(256, Bool()))

    for (i <- 0 until 256) {
      // Calculate the row and column of the current cell
      val row = i / 16
      val col = i % 16

      // Calculate the indices of the 8 neighbors with wrap-around
      val neighbors = Seq(
        ((row - 1 + 16) % 16, (col - 1 + 16) % 16), // top-left
        ((row - 1 + 16) % 16, col),                 // top
        ((row - 1 + 16) % 16, (col + 1) % 16),      // top-right
        (row, (col - 1 + 16) % 16),                // left
        (row, (col + 1) % 16),                     // right
        ((row + 1) % 16, (col - 1 + 16) % 16),     // bottom-left
        ((row + 1) % 16, col),                     // bottom
        ((row + 1) % 16, (col + 1) % 16)           // bottom-right
      )

      // Count the number of alive neighbors
      val neighborCount = neighbors.map { case (r, c) =>
        stateReg(r * 16 + c)
      }.reduce(_ +& _)

      // Determine the next state of the cell based on the rules
      nextState(i) := MuxCase(stateReg(i), Seq(
        (neighborCount <= 1.U) -> false.B,
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

/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(), Array("--target-dir", "generated"))
}
*/
