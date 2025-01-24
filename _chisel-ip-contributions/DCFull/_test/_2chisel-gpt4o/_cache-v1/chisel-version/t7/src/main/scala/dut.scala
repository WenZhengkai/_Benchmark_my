import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data))
    val deq = Decoupled(data)
  })

  // Define the state encoding
  val s_0_0 :: s_1_0 :: s_0_1 :: s_2_1 :: Nil = Enum(4)
  val state = RegInit(s_0_0)

  // Registers to hold the data entries
  val hold_0 = Reg(data)
  val hold_1 = Reg(data)

  // Control signals
  val shift = Wire(Bool())
  val load = Wire(Bool())
  val sendSel = Wire(Bool())

  // Valid/ready control
  val push_vld = io.enq.valid && io.enq.ready
  val pop_vld = io.deq.valid && io.deq.ready

  // Output logic
  io.deq.bits := Mux(sendSel, hold_1, hold_0)

  // FSM for state transition and control signals
  shift := false.B
  load := false.B
  sendSel := false.B

  io.deq.valid := false.B
  io.enq.ready := false.B

  switch(state) {
    is(s_0_0) {
      io.enq.ready := true.B
      when(push_vld) {
        hold_1 := io.enq.bits
        state := s_0_1
      }
    }

    is(s_1_0) {
      io.deq.valid := true.B
      sendSel := false.B
      when(pop_vld) {
        state := s_0_0
      }.elsewhen(push_vld) {
        hold_1 := io.enq.bits
        state := s_2_1
      }
    }

    is(s_0_1) {
      io.deq.valid := true.B
      sendSel := true.B
      when(pop_vld) {
        state := s_0_0
      }.elsewhen(push_vld) {
        hold_0 := io.enq.bits
        state := s_2_1
      }
    }

    is(s_2_1) {
      io.deq.valid := true.B
      sendSel := true.B
      when(pop_vld) {
        hold_0 := hold_1
        io.enq.ready := true.B
        when(push_vld) {
          hold_1 := io.enq.bits
        }.otherwise {
          state := s_1_0
        }
      }
    }
  }
}
