import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(DecoupledIO(data))
    val deq = DecoupledIO(data)
  })

  // Define the states for the FSM
  val s_0_0 :: s_1_0 :: s_0_1 :: s_2_1 :: Nil = Enum(4)
  val state = RegInit(s_0_0)

  // Registers to hold data
  val hold_0 = Reg(data.cloneType)
  val hold_1 = Reg(data.cloneType)

  // Control signals
  val shift = Wire(Bool())
  val load = Wire(Bool())
  val sendSel = Wire(Bool())

  // Valid and ready for push and pop
  val push_vld = io.enq.valid && io.enq.ready
  val pop_vld = io.deq.valid && io.deq.ready

  // State Machine
  switch(state) {
    is(s_0_0) {
      when(push_vld) {
        state := s_1_0
      }
    }
    is(s_1_0) {
      when(push_vld && pop_vld) {
        state := s_1_0
      } .elsewhen(push_vld) {
        state := s_2_1
      } .elsewhen(pop_vld) {
        state := s_0_0
      }
    }
    is(s_0_1) {
      when(push_vld && pop_vld) {
        state := s_1_0
      } .elsewhen(push_vld) {
        state := s_2_1
      } .elsewhen(pop_vld) {
        state := s_0_0
      }
    }
    is(s_2_1) {
      when(pop_vld) {
        state := s_0_1
      }
    }
  }

  // Define the control logic for shift, load, sendSel
  switch(state) {
    is(s_0_0) {
      shift := false.B
      load := push_vld
      sendSel := false.B
    }
    is(s_1_0) {
      shift := false.B
      load := push_vld
      sendSel := false.B
    }
    is(s_0_1) {
      shift := pop_vld
      load := false.B
      sendSel := true.B
    }
    is(s_2_1) {
      shift := pop_vld
      load := false.B
      sendSel := true.B
    }
  }

  // Logic for shifting and loading data
  when(shift) {
    hold_0 := hold_1
  }

  when(load) {
    hold_1 := io.enq.bits
  }

  // Assign the output
  io.deq.bits := Mux(sendSel, hold_1, hold_0)
  io.enq.ready := (state === s_0_0) || (state === s_1_0)
  io.deq.valid := (state === s_1_0) || (state === s_0_1) || (state === s_2_1)
}
