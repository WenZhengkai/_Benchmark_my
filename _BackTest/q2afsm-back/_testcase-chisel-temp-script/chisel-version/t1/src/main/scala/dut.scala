import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val r = Input(UInt(3.W))
    val g = Output(UInt(3.W))
  })

  // One-hot state encoding
  val sA = "b0001".U
  val sB = "b0010".U
  val sC = "b0100".U
  val sD = "b1000".U
  val state = RegInit(sA)

  // Output logic
  io.g := MuxCase(0.U, Seq(
    (state === sB) -> "b001".U,
    (state === sC) -> "b010".U,
    (state === sD) -> "b100".U
  ))

  // Next state logic
  state := MuxCase(state, Seq(
    (state === sA) -> MuxCase(sA, Seq(
      (io.r(0))                     -> sB,
      (!io.r(0) && io.r(1))         -> sC,
      (io.r === "b100".U)           -> sD
    )),
    (state === sB) -> Mux(io.r(0), sB, sA),
    (state === sC) -> Mux(io.r(1), sC, sA),
    (state === sD) -> Mux(io.r(2), sD, sA)
  ))
}
