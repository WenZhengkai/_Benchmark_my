import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val a = Input(UInt(32.W))
    val b = Input(UInt(32.W))
    val z = Output(UInt(32.W))
  })

  // Internal registers and wires
  val a_sign = io.a(31)
  val b_sign = io.b(31)
  val z_sign = WireDefault(a_sign ^ b_sign)

  val a_exponent = io.a(30, 23)
  val b_exponent = io.b(30, 23)
  val z_exponent = RegInit(0.U(9.W))

  val a_mantissa = Cat(1.U(1.W), io.a(22, 0)) // Add hidden 1 for normalized inputs
  val b_mantissa = Cat(1.U(1.W), io.b(22, 0)) // Add hidden 1 for normalized inputs
  val z_mantissa = RegInit(0.U(24.W)) // Result mantissa storage

  val product = RegInit(0.U(50.W)) // Intermediate product of mantissa multiplication
  val guard_bit = WireInit(false.B)
  val round_bit = WireInit(false.B)
  val sticky = WireInit(false.B)

  val counter = RegInit(0.U(3.W))

  // FSM-like operation sequencing
  switch(counter) {
    is(0.U) { // Initialization step
      z_exponent := 0.U
      z_mantissa := 0.U
      product := 0.U
      counter := 1.U
    }

    is(1.U) { // Parse and multiply mantissas
      when(a_exponent === 0.U || b_exponent === 0.U) { // Handle zero cases
        z_mantissa := 0.U
        z_exponent := 0.U
        z_sign := 0.U
        counter := 4.U // skip rounding
      }.otherwise {
        product := a_mantissa * b_mantissa
        z_exponent := a_expon while
警告：dut3.scala格式异常
