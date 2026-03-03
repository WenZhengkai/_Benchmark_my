import chisel3._
import chisel3.util._

class dut extends Module with RequireSyncReset {
  val io = IO(new Bundle {
    val r = Input(UInt(3.W))   // r(0)=device0, r(1)=device1, r(2)=device2
    val g = Output(UInt(3.W))  // g(0)=grant0,  g(1)=grant1,  g(2)=grant2
  })

  val sA :: sB :: sC :: sD :: Nil = Enum(4)
  val state = RegInit(sA)

  // Next-state logic
  switch(state) {
    is(sA) {
      when(io.r(0)) {
        state := sB // highest priority
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

  // Output logic
  io.g := 0.U
  switch(state) {
    is(sB) { io.g := "b001".U } // g0=1
    is(sC) { io.g := "b010".U } // g1=1
    is(sD) { io.g := "b100".U } // g2=1
  }
}

// Optional: generate Verilog
/*
object dutMain extends App {
  emitVerilog(new dut)
}
*/
