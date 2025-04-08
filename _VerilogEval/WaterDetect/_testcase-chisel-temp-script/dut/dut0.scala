import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val s    = Input(UInt(3.W))  // Water level sensors input (3:1)
    val fr3  = Output(Bool())   // Flow rate control for fr3
    val fr2  = Output(Bool())   // Flow rate control for fr2
    val fr1  = Output(Bool())   // Flow rate control for fr1
    val dfr  = Output(Bool())   // Supplemental flow rate control
    val reset_n = Input(Bool()) // Active-high reset (asynchronous)
  })

  // States for tracking the system state
  val idle :: low :: midlow :: midhigh :: high :: Nil = Enum(5)

  // Internal state register for water level tracking
  val stateReg = RegInit(idle)

  // Register to track the previous water level state
  val lastStateWasLow = RegInit(false.B)

  // Synchronous reset handling - if `reset_n` is high
  when(io.reset_n) {
    stateReg := idle
    lastStateWasLow:= Either -
警告：dut0.scala格式异常
