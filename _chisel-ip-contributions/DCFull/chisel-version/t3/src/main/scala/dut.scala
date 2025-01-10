import chisel3._
import chisel3.util._

class dut[D <: Data](dataType: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(dataType)) // Enqueue interface
    val deq = Decoupled(dataType)          // Dequeue interface
  })

  // State encoding
  object State extends ChiselEnum {
    val s_0_0, s_1_0, s_0_1, s_2_1 = Value
  }
  
  // State register
  val state = RegInit(State.s_0_0)

  // Registers to hold data
  val hold_0 = Reg(dataType)
  val hold_1 = Reg(dataType)

  // Default control signal values
  val shift = WireDefault(false.B)
  val load = WireDefault(false.B)

  // Control outputs based on the current state and input conditions
  val push_vld = io.enq.valid && io.enq.ready
  val pop_vld = io.deq.valid && io.deq.ready
  val sendSel = WireDefault(false.B)

  // Output data and ready/valid handling
  io.enq.ready := state === State.s_0_0 || state === State.s_1_0
  io.deq.valid := state === State.s_1_0 || state === State.s_0_1 || state === State.s_2_1

  // Manage the current data to send based on state
  sendSel := state === State.s_0_1 || state === State.s_2_1
  io.deq.bits := Mux(sendSel, hold_0, hold_1)

  // FSM state transition and data register handling
  switch(state) {
    is(State.s_0_0) {
      when(push_vld) {
        load := true.B
        state := State.s_1_0
      }
    }
    is(State.s_1_0) {
      when(push_vld && pop_vld) {
        shift := true.B
        state := State.s_1_0
      }.elsewhen(push_vld) {
        shift := true.B
        load := true.B
        state := State.s_2_1
      }.elsewhen(pop_vld) {
        state := State.s_0_0
      }
    }
    is(State.s_0_1) {
      when(pop_vld) {
        state := State.s_0_0
      }.elsewhen(push_vld) {
        load := true.B
        state := State.s_2_1
      }
    }
    is(State.s_2_1) {
      when(pop_vld) {
        state := State.s_1_0
      }
    }
  }

  // Perform data transfers between hold registers
  when(load) {
    hold_1 := io.enq.bits
  }
  when(shift) {
    hold_0 := hold_1
  }
}

