Please act as a professional Chisel designer, correct the origianl code

## original code
```
import chisel3._
import chisel3.util._
import chisel.lib.dclib._

class dut[D <: Data](data: D, n: Int, op: (D, D) => D) extends Module {
  require(n >= 2, "The number of inputs must be at least 2")

  val io = IO(new Bundle {
    val a = Vec(n, Flipped(Decoupled(data.cloneType)))
    val z = Decoupled(data.cloneType)
  })

  // Task 1: Initialization of Internal Structures
  val aInt = io.a.map(DCInput(_))
  val zInt = Wire(Decoupled(data.cloneType))

  // Task 2: Signal Generation for Validity Checking
  val all_valid = aInt.map(_.valid).reduce(_ && _)

  // Task 3: Implement Reduction Operation
  when(all_valid) {
    val reductionResult = aInt.map(_.bits).reduce(op)
    zInt.bits := reductionResult
  }

  // Task 4: Output Control Logic
  zInt.valid := all_valid && io.z.ready
  aInt.foreach(_.ready := zInt.ready)

  // Task 5: Interface the Output with DCOutput
  val zDcout = DCOutput(zInt)
  io.z <> zDcout
}



```
## error information
```
[error] firrtl.passes.PassExceptions: 
[error] firrtl.passes.CheckInitialization$RefNotInitializedException:  @[dut.scala 15:18] : [module dut]  Reference zInt is not fully initialized.
[error]    : zInt.bits <= mux(all_valid, reductionResult, VOID)
[error] firrtl.passes.CheckInitialization$RefNotInitializedException:  @[DCOutput.scala 29:22] : [module dut]  Reference zDcout_tout is not fully initialized.
[error]    : zInt.bits <= mux(all_valid, reductionResult, VOID)
[error]    @[DCOutput.scala 30:17] : zDcout_tout.io.enq.bits <= zInt.bits @[DCOutput.scala 30:17]
[error] firrtl.passes.PassException: 2 errors detected!
[error] stack trace is suppressed; run last Compile / run for the full output
[error] (Compile / run) firrtl.passes.PassExceptions: 
[error] firrtl.passes.CheckInitialization$RefNotInitializedException:  @[dut.scala 15:18] : [module dut]  Reference zInt is not fully initialized.
[error]    : zInt.bits <= mux(all_valid, reductionResult, VOID)
[error] firrtl.passes.CheckInitialization$RefNotInitializedException:  @[DCOutput.scala 29:22] : [module dut]  Reference zDcout_tout is not fully initialized.
[error]    : zInt.bits <= mux(all_valid, reductionResult, VOID)
[error]    @[DCOutput.scala 30:17] : zDcout_tout.io.enq.bits <= zInt.bits @[DCOutput.scala 30:17]
[error] firrtl.passes.PassException: 2 errors detected!

```


Give me the complete correct Chisel code.