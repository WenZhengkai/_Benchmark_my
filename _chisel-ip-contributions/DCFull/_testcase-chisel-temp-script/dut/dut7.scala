import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data))
    val deq = Decoupled(data)
  })

  // Task 1: Define Module Internal Components
  val hold_0 = Reg(data.cloneType)
  val hold_1 = Reg(data.cloneType)

  // FSM states
  val s_0_0 :: s_1_0 :: s_0_1 :: s_2_1 :: Nil = Enum(4)
  val state = RegInit(s_0_0)

  // Control Signals
  val shift = Wire(Bool())
  val load = Wire(Bool())
  val sendSel = Wire(Bool())
  val push_vld = Wire(Bool())
  val pop_vld = Wire(Bool())

  // Task 2: Implement Control Signal Logic
  push_vld := io.enq.valid && io.enq.ready
  pop_vld := io.deq.valid && io.deq.ready

  // Task 3: FSM State Transition Logic
  switch(state) {
    is(s_0_0) {
      when(push_vld) {
        state := s_1_0
      }
    }
    is(s_1_0) {
      when(push_vld) {
        state := s_2_1
      }.elsewhen(pop_vld) {
        state := s_0_1
      }
    }
    is(s_0_1) {
      when(pop_vld) {
        state := s_0_0
      }
    }
    is(s_2_1) {
      when(pop_vld) {
        state := s_1_0
      }
    }
  }

  // Task 4: Data Holding and Transition Logic
  load := (state === s_0_0 && push_vld)
  shift := (state === s_1_0 && pop_vld)

  when(load) {
    hold_0 := io.enq.bits
  }.elsewhen(shift) {
    hold_0 := hold_1
  }

  when(state === s_1_0 && push_vld) {
    hold_1 := io.enq.bits
  }

  // Task 5: Output Data Muxing Logic
  sendSel := (state === s_2_1)

  io.deq.bits := Mux(sendSel, hold_1, hold_0)
  io.deq.valid := (state === s_1_0 || state === s_0_1 || state === s_2_1)

  // Task 6: Interface and Connection Logic
  io.enq.ready := (state =/= s_2_1)

}
