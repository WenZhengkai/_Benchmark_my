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

  // Define states for the Lemming
  object LemmingState extends ChiselEnum {
    val WALK_LEFT, WALK_RIGHT, FALL_LEFT, FALL_RIGHT = Value
  }
  import LemmingState._

  // State register with asynchronous reset to WALK_LEFT
  val state = RegInit(WALK_LEFT)

  // Default output values
  io.walk_left := false.B
  io.walk_right := false.B
  io.aaah := false.B

  // State transition logic
  switch(state) {
    is(WALK_LEFT) {
      when(!io.ground) {
        // Start falling if no ground
        state := FALL_LEFT
      }.elsewhen(io.bump_left) {
        // Change direction if bumped on the left
        state := WALK_RIGHT
      }.otherwise {
        // Continue walking left
        state := WALK_LEFT
      }
    }

    is(WALK_RIGHT) {
      when(!io.ground) {
        // Start falling if no ground
        state := FALL_RIGHT
      }.elsewhen(io.bump_right) {
        // Change direction if bumped on the right
        state := WALK_LEFT
      }.otherwise {
        // Continue walking right
        state := WALK_RIGHT
      }
    }

    is(FALL_LEFT) {
      when(io.ground) {
        // Resume walking left when ground reappears
        state := WALK_LEFT
      }.otherwise {
        // Continue falling
        state := FALL_LEFT
      }
    }

    is(FALL_RIGHT) {
      when(io.ground) {
        // Resume walking right when ground reappears
        state := WALK_RIGHT
      }.otherwise {
        // Continue falling
        state := FALL_RIGHT
      }
    }
  }

  // Output logic (Moore machine - outputs depend only on current state)
  switch(state) {
    is(WALK_LEFT) {
      io.walk_left := true.B
      io.walk_right := false.B
      io.aaah := false.B
    }
    is(WALK_RIGHT) {
      io.walk_left := false.B
      io.walk_right := true.B
      io.aaah := false.B
    }
    is(FALL_LEFT) {
      io.walk_left := false.B
      io.walk_right := false.B
      io.aaah := true.B
    }
    is(FALL_RIGHT) {
      io.walk_left := false.B
      io.walk_right := false.B
      io.aaah := true.B
    }
  }
}
