import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val s = Input(UInt(3.W)) // 3-bit input representing s[3:1]
    val fr3 = Output(Bool()) // Output for fr3
    val fr2 = Output(Bool()) // Output for fr2
    val fr1 = Output(Bool()) // Output for fr1
    val dfr = Output(Bool()) // Output for dfr
  })

  // State Enumeration Definition (Task 1)
  object States extends ChiselEnum {
    val BelowS1, BetweenS2S1, BetweenS3S2, AboveS3 = Value // Enumerated states
  }
  import States._

  // Current State Logic (Task 2)
  val currentState = WireDefault(BelowS1) // Default state
  when(io.s(2)) { // Check s[3] (MSB is bit 2 index in Chisel)
    currentState := AboveS3
  }.elsewhen(io.s(1)) { // Check s[2]
    currentState := BetweenS3S2
   ...


Remmcalaintedec...
Logprinting or(debugging
警告：dut7.scala格式异常
