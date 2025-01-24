import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data))
    val deq = Decoupled(data)
  })

  // Task 1: Define Module Internal Components
  // State definitions
  val s_0_0 :: s_1_0 :: s_0_1 :: s_1_1 :: Nil = Enum(4)
  val stateReg = RegInit(s_0_0)

  // Registers for holding data
  val hold_0 = RegInit(0.U.asTypeOf(data))
  val hold_1 = RegInit(0.U.asTypeOf(data))

  // Control signals
  val shift = Wire(Bool())
  val load = Wire(Bool())
  val sendSel = Wire(Bool())
  val push_vld = Wire(Bool())
  val pop_vld = Wire(Bool())

  // Task 2: Implement Control Signal Logic
  push_vld := io.enq.valid && (stateReg === s_0_0 || stateReg === s_1_0)
  pop_vld := io.deq.ready && (stateReg === s_0_1 || stateReg === s_1_1)

  shift := (stateReg === s_1_0) && io.enq.valid && io.deq.ready
  load := (stateReg === s_0_0) && io.enq.valid

  // Send selection for muxing output
  sendSel := stateReg === s_0_1 || stateReg === s_1_1

  // Task 3: FSM State Transition Logic
  switch(stateReg) {
    is(s_0_0) {
      when(io.enq.valid) {
        stateReg := s_1_0
      }
    }
    is(s_1_0) {
      when(io.enq.valid && io.deq.ready) {
        stateReg := s_1_1
      }.elsewhen(io.enq.valid) {
        stateReg := s_0_1
      }.elsewhen(io.deq.ready) {
        stateReg := s_0_0
      }
    }
    is(s_0_1) {
      when(io.deq.ready) {
        stateReg := s_0_0
      }
    }
    is(s_1_1) {
      when(io.deq.ready) {
        stateReg := s_1_0
      }
    }
  }

  // Task 4: Data Holding and Transition Logic
  when(load) {
    hold_0 := io.enq.bits
  }
  when(shift) {
    hold_0 := hold_1
    hold_1 := io.enq.bits
  }.elsewhen(stateReg === s_0_0 && io.enq.valid) {
    hold_1 := io.enq.bits
  }

  // Task 5: Output Data Muxing Logic
  io.deq.bits := Mux(sendSel, hold_1, hold_0)

  // Task 6: Interface and Connection Logic
  io.enq.ready := push_vld
  io.deq.valid := pop_vld
}

