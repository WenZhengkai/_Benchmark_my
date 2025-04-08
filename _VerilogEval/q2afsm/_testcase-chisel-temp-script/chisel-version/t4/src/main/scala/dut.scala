import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val r = Input(UInt(3.W))  // 3-bit input signal for requests
    val g = Output(UInt(3.W)) // 3-bit output signal for grants
  })

  // Define state encoding
  val A :: B :: C :: D :: Nil = Enum(4)

  // State register
  val state = RegInit(A)

  // Default output: no grant
  io.g := 0.U 

  // State transition logic
  switch(state) {
    is(A) {
      when(io.r(0)) {
        state := B  // Priority to device 0
      }.elsewhen(io.r(1)) {
        state := C  // Priority to device 1
      }.elsewhen(io.r(2)) {
        state := D  // Priority to device 2
      }
    }
    is(B) {
      when(io.r(0)) {
        state := B  // Stay in B as long as r0 is active
      }.otherwise {
        state := A  // Go back to A if r0 is inactive
      }
    }
    is(C) {
      when(io.r(1)) {
        state := C  // Stay in C as long as r1 is active
      }.otherwise {
        state := A  // Go back to A if r1 is inactive
      }
    }
    is(D) {
      when(io.r(2)) {
        state := D  // Stay in D as long as r2 is active
      }.otherwise {
        state := A  // Go back to A if r2 is inactive
      }
    }
  }

  // Output logic
  switch(state) {
    is(B) {
      io.g := "b001".U  // Grant to device 0
    }
    is(C) {
      io.g := "b010".U  // Grant to device 1
    }
    is(D) {
      io.g := "b100".U  // Grant to device 2
    }
  }
}

// Main object to generate Verilog
/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut)
}
*/
