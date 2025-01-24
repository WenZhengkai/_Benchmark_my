import chisel3._
import chisel3.util._
import chisel.lib.dclib._

class dut[D <: Data](data: D, n: Int, op: (D, D) => D) extends Module {
  require(n >= 2, "The DCReduce module requires at least two inputs.")

  val io = IO(new Bundle {
    val a = Vec(n, Flipped(Decoupled(data.cloneType)))
    val z = Decoupled(data)
  })

  // Task 1: Implement Initialization of Internal Inputs
  val aInt: Vec[DecoupledIO[D]] = VecInit(io.a.map(DCInput(_)))

  // Task 2: Establish Intermediate Output Wire
  val zInt: DecoupledIO[D] = Wire(Decoupled(data))

  // Task 3: Compute Validity Signal
  val allValid: Bool = aInt.map(_.valid).reduce(_ && _)

  // Task 4: Implement Reduction Operation
  when(allValid) {
    // Reduce the valid inputs using the given binary operator
    val result: D = aInt.map(_.bits).reduce(op)
    zInt.bits := result
  } .otherwise {
    zInt.bits := DontCare
  }

  // Task 5: Manage Output Control and Validity
  zInt.valid := allValid && io.z.ready
  io.z.ready := true.B // Assuming combinational path for ready signaling

  for (a <- aInt) {
    a.ready := zInt.valid
  }

  // Task 6: Connect and Interface Output
  val zDcout: DecoupledIO[D] = DCOutput(zInt)
  io.z <> zDcout
}
