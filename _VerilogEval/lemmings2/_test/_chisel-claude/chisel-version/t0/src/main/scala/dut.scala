// package lemmings

import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val bump_left = Input(Bool())
    val bump_right = Input(Bool())
    val ground = Input(Bool())
    val walk_left = Output(Bool())
    val walk_right = Output(Bool())
    val aaah = Output(Bool())
  })

  // Define the states
  object State extends ChiselEnum {
    val WALK_LEFT, WALK_RIGHT, FALL_LEFT, FALL_RIGHT = Value
  }
  import State._

  // State register with async reset to WALK_LEFT
  val state = RegInit(WALK_LEFT)

  // Default output values
  io.walk_left := false.B
  io.walk_right := false.B
  io.aaah := false.B

  // State transitions
  switch(state) {
    is(WALK_LEFT) {
      when(!io.ground) {
        // Start falling if there's no ground
        state := FALL_LEFT
      }.elsewhen(io.bump_left) {
        // Switch direction if bumped left
        state := WALK_RIGHT
      }.otherwise {
        // Stay walking left
        state := WALK_LEFT
      }
      io.walk_left := true.B
    }

    is(WALK_RIGHT) {
      when(!io.ground) {
        // Start falling if there's no ground
        state := FALL_RIGHT
      }.elsewhen(io.bump_right) {
        // Switch direction if bumped right
        state := WALK_LEFT
      }.otherwise {
        // Stay walking right
        state := WALK_RIGHT
      }
      io.walk_right := true.B
    }

    is(FALL_LEFT) {
      when(io.ground) {
        // Resume walking when ground reappears
        state := WALK_LEFT
      }.otherwise {
        // Continue falling
        state := FALL_LEFT
      }
      io.aaah := true.B
    }

    is(FALL_RIGHT) {
      when(io.ground) {
        // Resume walking when ground reappears
        state := WALK_RIGHT
      }.otherwise {
        // Continue falling
        state := FALL_RIGHT
      }
      io.aaah := true.B
    }
  }
}
