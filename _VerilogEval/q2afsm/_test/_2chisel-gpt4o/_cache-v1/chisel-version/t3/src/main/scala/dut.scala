import chisel3._
import chisel3.util._

/**
 * dut - A FSM that acts as an arbiter circuit to control access to a resource
 * requested by three devices. Each device makes requests via input `r`, and the
 * FSM handles them based on priority rules.
 */
class dut extends Module {
  val io = IO(new Bundle {
    val r = Input(UInt(3.W))  // 3-bit input representing device requests
    val g = Output(UInt(3.W)) // 3-bit output representing resource grants
  })

  // Define FSM states
  val A :: B :: C :: D :: Nil = Enum(4)
  val state = RegInit(A)  // Initial state is A

  // Default output values
  io.g := 0.U  // Default: no grants

  // Define the FSM behavior
  switch(state) {
    is(A) {
      when(io.r(0)) {
        state := B
      } .elsewhen(io.r(1)) {
        state := C
      } .elsewhen(io.r(2)) {
        state := D
      }
    }

    is(B) {
      io.g := "b001".U  // Grant to device 0 (g0 = 1)
      when(!io.r(0)) {
        state := A
      }
    }

    is(C) {
      io.g := "b010".U  // Grant to device 1 (g1 = 1)
      when(!io.r(1)) {
        state := A
      }
    }

    is(D) {
      io.g := "b100".U  // Grant to device 2 (g2 = 1)
      when(!io.r(2)) {
        state := A
      }
    }
  }
}

// Generate the Verilog code for the module
/*
object dutDriver extends App {
  chisel3.Driver.execute(args, () => new dut)
}
*/
