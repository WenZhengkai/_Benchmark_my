import chisel3._
import chisel3.util._

class dut[D <: Data](gen: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(gen))
    val deq = Decoupled(gen)
  })

  // State Definitions
  val s_0_0 :: s_1_0 :: s_0_1 :: s_2_1 :: Nil = Enum(4)
  val state = RegInit(s_0_0)

  // Registers for holding data
  val hold_0 = Reg(gen)
  val hold_1 = Reg(gen)

  // Control signals
  val shift = WireDefault(false.B)
  val load = WireDefault(false.B)
  val sendSel = WireDefault(false.B)

  // Determine valid push and pop conditions
  val push_vld = io.enq.valid && io.enq.ready
  val pop_vld = io.deq.valid && io.deq.ready

  // Default Ready/Valid
  io.enq.ready := false.B
  io.deq.valid := false.B

  // State Machine
  switch(state) {
    is(s_0_0) {
      io.enq.ready := true.B
      when(push_vld) {
        hold_1 := io.enq.bits
        state := s_1_0
      }
    }
    is(s_1_0) {
      io.enq.ready := true.B
      when(push_vld) {
        hold_0 := hold_1
        hold_1 := io.enq.bits
        state := s_2_1
      }
      when(pop_vld) { state := s_0_1 }
    }
    is(s_0_1) {
      io.deq.valid := true.B
      sendSel := true.B
      when(pop_vld) {
        state := s_0_0
      }
    }
    is(s_2_1) {
      io.enq.ready := false.B
      io.deq.valid := true.B
      sendSel := false.B
      when(pop_vld) {
        hold_1 := hold_0
        state := s_1_0
      }
    }
  }

  // Output data selection via multiplexer based on sendSel
  io.deq.bits := Mux(sendSel, hold_0, hold_1)
}

