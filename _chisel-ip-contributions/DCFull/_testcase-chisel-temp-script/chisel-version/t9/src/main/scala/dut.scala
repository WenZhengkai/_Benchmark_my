import chisel3._
import chisel3.util._

class dut[D <: Data](dataType: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(dataType))
    val deq = Decoupled(dataType)
  })

  // Task 1: Define Module Internal Components
  // State representation
  val s_0_0 :: s_1_0 :: s_0_1 :: s_2_1 :: Nil = Enum(4)
  val state = RegInit(s_0_0)

  // Registers for holding data
  val hold_0 = Reg(dataType)
  val hold_1 = Reg(dataType)

  // Control signals
  val shift = Wire(Bool())
  val load = Wire(Bool())
  val sendSel = Wire(Bool())
  val push_vld = Wire(Bool())
  val pop_vld = Wire(Bool())

  // Task 2: Implement Control Signal Logic
  push_vld := io.enq.valid && io.enq.ready
  pop_vld := io.deq.valid && io.deq.ready

  shift := false.B
  load := false.B
  sendSel := false.B

  switch(state) {
    is(s_0_0) {
      when(push_vld) {
        load := true.B
        state := s_1_0
      }
    }
    is(s_1_0) {
      when(push_vld && pop_vld) {
        shift := true.B
        load := true.B
        state := s_1_0
      }.elsewhen(push_vld) {
        load := true.B
        state := s_2_1
      }.elsewhen(pop_vld) {
        shift := true.B
        state := s_0_0
      }
    }
    is(s_0_1) {
      when(push_vld && pop_vld) {
        load := true.B
        shift := true.B
        state := s_1_0
      }.elsewhen(push_vld) {
        state := s_2_1
        shift := true.B
      }.elsewhen(pop_vld) {
        state := s_0_0
      }
    }
    is(s_2_1) {
      when(pop_vld) {
        shift := true.B
        state := s_1_0
      }
    }
  }

  // Task 4: Data Holding and Transition Logic
  when(load) {
    hold_1 := io.enq.bits
  }
  when(shift) {
    hold_0 := hold_1
  }

  // Task 5: Output Data Muxing Logic
  sendSel := state === s_0_1 || state === s_2_1
  io.deq.bits := Mux(sendSel, hold_1, hold_0)

  // Task 6: Interface and Connection Logic
  io.enq.ready := state === s_0_0 || state === s_1_0 || state === s_0_1
  io.deq.valid := state === s_1_0 || state === s_0_1 || state === s_2_1
}

