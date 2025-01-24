import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(DecoupledIO(data))  // Enqueue interface
    val deq = DecoupledIO(data)           // Dequeue interface
  })

  // Task 1: Define Module Internal Components
  val hold_0 = Reg(data)
  val hold_1 = Reg(data)
  val s_0_0 :: s_1_0 :: s_0_1 :: s_2_1 :: Nil = Enum(4)
  val state = RegInit(s_0_0)

  // Task 2: Implement Control Signal Logic
  val push_vld = io.enq.valid && io.enq.ready
  val pop_vld = io.deq.valid && io.deq.ready
  
  val shift = Wire(Bool())
  val load = Wire(Bool())
  val sendSel = Wire(UInt(1.W))

  // Task 3: FSM State Transition Logic
  switch(state) {
    is(s_0_0) {
      io.deq.valid := false.B
      when(io.enq.valid) {
        state := s_1_0
      }
    }
    is(s_1_0) {
      io.deq.valid := false.B
      when(io.deq.ready && io.enq.valid) {
        state := s_0_1
      }.elsewhen(io.enq.valid) {
        state := s_2_1
      }.elsewhen(io.deq.ready) {
        state := s_0_0
      }
    }
    is(s_0_1) {
      io.deq.valid := true.B
      when(pop_vld && io.enq.valid) {
        state := s_1_0
      }.elsewhen(pop_vld) {
        state := s_0_0
      }.elsewhen(io.enq.valid) {
        state := s_2_1
      }
    }
    is(s_2_1) {
      io.deq.valid := true.B
      when(pop_vld) {
        state := s_1_0
      }
    }
  }

  // Task 4: Data Holding and Transition Logic
  shift := (state === s_2_1 && pop_vld)
  load := (state === s_1_0 && !pop_vld)

  when(shift) {
    hold_0 := hold_1
  }

  when(load || push_vld) {
    hold_1 := io.enq.bits
  }

  // Task 5: Output Data Muxing Logic
  sendSel := 0.U
  when(state === s_0_1 || state === s_2_1) {
    sendSel := 1.U
  }

  io.deq.bits := Mux(sendSel === 0.U, hold_0, hold_1)

  // Task 6: Interface and Connection Logic
  io.enq.ready := (state === s_0_0 || state === s_1_0) && (state =/= s_2_1)
}


