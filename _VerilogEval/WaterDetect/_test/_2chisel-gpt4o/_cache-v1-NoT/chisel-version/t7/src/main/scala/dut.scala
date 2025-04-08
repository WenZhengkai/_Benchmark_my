import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val s     = Input(UInt(3.W))       // 3-bit input vector for sensor readings
    val fr3   = Output(Bool())        // Output for flow rate control - fr3
    val fr2   = Output(Bool())        // Output for flow rate control - fr2
    val fr1   = Output(Bool())        // Output for flow rate control - fr1
    val dfr   = Output(Bool())        // Output for supplemental flow valve - dfr
  })

  // Define synchronous reset signal
  val resetReg = RegInit(1.U(1.W)) // Reset signal is active-high during reset condition

  // Registers to store previous sensor state and current levels
  val previousSensors = RegInit(0.U(3.W)) // Previous state of sensor `s`

  // Default output values during reset
  io.fr3 := true.B
  io.fr2 := true.B
  io.fr1 := true.B
  io.dfr := true.B

  // Flow rate registers (storage for current outputs)
  val flowRateFr1 = RegInit(true.B)
  val flowRate`.RawInput
警告：dut7.scala格式异常
