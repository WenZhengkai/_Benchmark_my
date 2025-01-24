import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data))
    val deq = Decoupled(data)
  })

  // Register declarations for holding data
  val hold_0 = RegInit(0.U.asTypeOf(data))
  val hold_1 = RegInit(0.U.asTypeOf(data))

  // State representation
  val s_0_0 :: s_1_0 :: s_0_1 :: s_2_1 :: Nil = Enum(4)
  val state = RegInit(s_0_0)

  // Control signals
  val shift = WireDefault(false.B)
  val load = WireDefault(false.B)
  val sendSel = WireDefault(false.B)
  val push_vld = WireDefault(false.B)
  val pop_vld = WireDefault(false.B)

  // Control signal logic
  push_vld := io.enq.valid && io.enq.ready
  pop_vld := io.deq.valid && io.deq.ready

  // FSM State Transition Logic
  switch(state) {
    is(s_0_0) {
      when(push_vld) {
        state := s_1_0
        load := true.B
        sendSel := false.B
      }
    }
    is(s_1_0) {
      when(pop_vld && io.enq.valid) {
        state := s_1_0
        shift := true.B
        load := true.B
      }.elsewhen(pop_vld) {
        state := s_0_0
      }.elsewhen(push_vld) {
        state := s_2_1
        load := true.B
      }
    }
    is(s_0_1) {
      when(pop_vld) {
        state := s_0_0
      }
    }
    is(s_2_1) {
      when(pop_vld) {
        state := s_0_1
        shift := true.B
      }
    }
  }

  // Data Holding and Transition Logic
  when(load) {
    hold_1 := io.enq.bits
  }

  when(shift) {
    hold_0 := hold_1
  }

  // Output Data Muxing Logic
  io.deq.bits := Mux(sendSel, hold_1, hold_0)

  // Interface and Connection Logic
  io.enq.ready := (state === s_0_0 || state === s_1_0)
  io.deq.valid := (state === s_1_0 || state === s_0_1 || state === s_2_1)

  // Ensure the FSM transitions correctly and outputs the right data
  sendSel := (state === s_1_0 || state === s_0_1)
}


