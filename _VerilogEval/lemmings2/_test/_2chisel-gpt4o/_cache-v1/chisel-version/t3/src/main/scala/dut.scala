import chisel3._
import chisel3.util._

/** dut FSM Module */
class dut extends Module {
  val io = IO(new Bundle {
    val bump_left = Input(Bool())   // Input: bump on the left
    val bump_right = Input(Bool()) // Input: bump on the right
    val ground = Input(Bool())     // Input: whether the Lemming is on the ground

    val walk_left = Output(Bool()) // Output: Lemming walking left
    val walk_right = Output(Bool())// Output: Lemming walking right
    val aaah = Output(Bool())      // Output: Lemming falling
  })

  // Enum state definitions
  object State extends ChiselEnum {
    val WalkLeft, WalkRight, FallLeft, FallRight = Value
  }

  import State._

  val state = RegInit(WalkLeft) // Default reset state (walking left)

  // State transition logic (Moore FSM)
  switch(state) {
    is(WalkLeft) {
      when(!io.ground) {
        state := FallLeft // Ground disappears, start falling left
      } .elsewhen(io.bump_left) {
        state := WalkRight // Bumped on the left, switch to walking right
      }
    }
    is(WalkRight) {
      when(!io.ground) {
        state := FallRight // Ground disappears, start falling right
      } .elsewhen(io.bump_right) {
        state := WalkLeft // Bumped on the right, switch to walking left
      }
    }
    is(FallLeft) {
      when(io.ground) {
        state := WalkLeft // Ground reappears, resume walking left
      }
    }
    is(FallRight) {
      when(io.ground) {
        state := WalkRight // Ground reappears, resume walking right
      }
    }
  }

  // Output logic (Moore FSM: outputs depend only on the current state)
  io.walk_left := (state === WalkLeft)
  io.walk_right := (state === WalkRight)
  io.aaah := (state === FallLeft || state === FallRight)
}

