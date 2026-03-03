import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val r = Input(UInt(3.W))
    val g = Output(UInt(3.W))
  })

  // State encoding
  val sA :: sB :: sC :: sD :: Nil = Enum(4)
  val state = RegInit(sA)

  // Synchronous state transition logic
  switch(state) {
    is(sA) {
      when(io.r(0)) {
        state := sB
      }.elsewhen(io.r(1)) {
        state := sC
      }.elsewhen(io.r(2)) {
        state := sD
      }.otherwise {
        state := sA
      }
    }
    is(sB) {
      when(io.r(0)) { state := sB }.otherwise { state := sA }
    }
    is(sC) {
      when(io.r(1)) { state := sC }.otherwise { state := sA }
    }
    is(sD) {
      when(io.r(2)) { state := sD }.otherwise { state := sA }
    }
  }

  // Output logic (Moore-style)
  io.g := MuxLookup(state.asUInt, 0.U(3.W), Seq(
    sA.asUInt -> "b000".U,
    sB.asUInt -> "b001".U, // g0=1
    sC.asUInt -> "b010".U, // g1=1
    sD.asUInt -> "b100".U  // g2=1
  ))
}
