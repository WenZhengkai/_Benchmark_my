import chisel3._
import chisel3.util._
import chisel.lib.dclib._

class dut[D <: Data](data: D, n: Int, op: (D, D) => D) extends Module {
  require(n >= 2, "The module requires at least two inputs.")
  val io = IO(new Bundle {
    val a = Input(Vec(n, Flipped(Decoupled(data.cloneType))))
    val z = Output(Decoupled(data.cloneType))
  })

  // Task 1: Implement Initialization of Internal Inputs
  val aInt = VecInit(io.a.map(DCInput(_)))

  // Task 2: Establish Intermediate Output Wire
  val zInt = Wire(Decoupled(data))

  // Task 3: Compute Validity Signal
  val all_valid = aInt.map(_.valid).reduce(_ && _)

  // Task 4: Implement Reduction Operation
  when(all_valid) {
    zInt.bits := aInt.map(_.bits).reduce(op)
  }.otherwise {
    zInt.bits := DontCare
  }

  // Task 5: Manage Output Control and Validity
  zInt.valid := all_valid && io.z.ready
  aInt.foreach(_.ready := zInt.valid)

  // Task 6: Connect and Interface Output
  val zDcout = DCOutput(zInt)
  io.z <> zDcout
}
