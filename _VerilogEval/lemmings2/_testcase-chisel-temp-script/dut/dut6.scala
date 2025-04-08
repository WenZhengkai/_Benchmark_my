import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val bump_left = Input(Bool())
    val bump_right = Input(Bool())
    val ground = Input(Bool())
    val reset = Input(Bool()) // Added explicit reset input for asynchronous reset
    val walk_left = Output(Bool())
    val walk_right = Output(Bool())
    val aaah = Output(Bool())
  })

  // Task 1: Define FSM states
  object State extends ChiselEnum {
    val WalkLeft, WalkRight, Fall = Value
  }
  val state = RegInit(State.WalkLeft) // Default state on reset is WalkLeft

  // Preserve walking direction during Fall
  val directionPreserved = RegInit(State.WalkLeft)

  // Task 2: Initialization of output signals
  io.walk_left := false.B
  io.walk_right := false.B
  io.aaah := false.B

  // Task 3: Handle reset functionality
  when(io.reset) {
    state := State.WalkLeft
    directionPreserved := State.WalkLeft
  }

  // Task 7: Define state transition logic (accordance with the FSM)
  switch(state) {
    is(State.WalkLeft) {
      when(!io.ground) { // Fall if no ground
        state := State.Fall
        directionPreserved := State.WalkLeft
      }.elsewhen(io.bump_left) { // Bump left -> WalkRight
        state := State.WalkRight
      }.elsewhen(io.bump_right) { // Bump right -> Keep walking left
        state := State.WalkRight
      }
    }

    is(State.WalkRight) {
      when(!io.ground) { // Fall if no ground
        state := State.Fall
        directionPreserved := State.WalkRight
      }.elsewhen(io.bump_right) { // Bump right -> WalkLeft
        state := State.WalkLeft
      }.elsewhen(io.bump_left) { // Bump left -> Keep walking right
        state := State.WalkLeft
      }
    }

    is(State.Fall) {
      io.aaah:= latch.-- ->
警告：dut6.scala格式异常
