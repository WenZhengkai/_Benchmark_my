Please act as a professional Chisel designer, correct the origianl code

## original code
``` scala
import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  require(width < data.getWidth, "Output width must be less than the input data width.")
  
  val io = IO(new Bundle {
    val dataIn = Flipped(Decoupled(data))
    val dataOut = Decoupled(UInt(width.W))
  })

  // Task 1: Cycle Calculation Logic
  val dataWidth = data.getWidth
  val cycles = if (dataWidth % width != 0) dataWidth / width + 1 else dataWidth / width

  // Task 2: Cycle Counter Register
  val cycleCount = RegInit(0.U(log2Ceil(cycles).W))

  // Task 3: Data Selection and Storage
  val dataSelect = Wire(Vec(cycles, UInt(width.W)))

  // Slice the input data into fixed width words
  for (i <- 0 until cycles) {
    val lowerBound = i * width
    val upperBound = math.min((i + 1) * width, dataWidth)
    dataSelect(i) := data.asUInt()(upperBound-1, lowerBound)
  }

  io.dataOut.bits := dataSelect(cycleCount)

  // Task 4: Handshaking Logic for Data Input
  io.dataIn.ready := (cycleCount === (cycles - 1).U) && io.dataOut.ready

  // Task 5: Handshaking Logic for Data Output
  io.dataOut.valid := io.dataIn.valid

  when(io.dataOut.fire()) {
    when(cycleCount === (cycles - 1).U) {
      cycleCount := 0.U
    } .otherwise {
      cycleCount := cycleCount + 1.U
    }
  }

  when(io.dataIn.fire()) {
    cycleCount := 0.U
  }
}
```


## error information
``` plain text
[error] chisel3.package$ExpectedHardwareException: bits to be sliced 'UInt<8>' must be hardware, not a bare Chisel type. Perhaps you forgot to wrap it in Wire(_) or IO(_)?
[error] 	at ... ()
[error] 	at dut.$anonfun$new$3(dut.scala:26)
[error] 	at chisel3.Data.$anonfun$$colon$eq$1(Data.scala:796)
[error] 	at scala.runtime.java8.JFunction0$mcV$sp.apply(JFunction0$mcV$sp.java:23)
[error] 	at chisel3.internal.prefix$.apply(prefix.scala:31)
[error] 	at chisel3.Data.$colon$eq(Data.scala:796)
[error] 	at dut.$anonfun$new$2(dut.scala:26)
[error] 	at scala.collection.immutable.Range.foreach$mVc$sp(Range.scala:158)
[error] 	at dut.<init>(dut.scala:23)
[error] 	at Driver$.$anonfun$new$1(driver.scala:6)
[error] 	at ... ()
[error] 	at ... (Stack trace trimmed to user code only. Rerun with --full-stacktrace to see the full stack trace)
[error] stack trace is suppressed; run last Compile / run for the full output
[error] (Compile / run) chisel3.package$ExpectedHardwareException: bits to be sliced 'UInt<8>' must be hardware, not a bare Chisel type. Perhaps you forgot to wrap it in Wire(_) or IO(_)?
```

Give me the complete correct Chisel code.

##
t0
[error] /home/kai/ChiselProject/Benchmarks/_Benchmark_my/_chisel-ip-contributions/DCSerializer/chisel-version/t0/src/main/scala/dut.scala:24:36: D does not take parameters
[error]     dataSelect(i) := io.dataIn.bits(start, end - 1).asUInt
[error]                                    ^
[error] one error found
[error] (Compile / compileIncremental) Compilation failed

t8
[error] chisel3.package$ExpectedHardwareException: bits to be sliced 'UInt<8>' must be hardware, not a bare Chisel type. Perhaps you forgot to wrap it in Wire(_) or IO(_)?
[error] 	at ... ()
[error] 	at dut.$anonfun$new$3(dut.scala:26)
[error] 	at chisel3.Data.$anonfun$$colon$eq$1(Data.scala:796)
[error] 	at scala.runtime.java8.JFunction0$mcV$sp.apply(JFunction0$mcV$sp.java:23)
[error] 	at chisel3.internal.prefix$.apply(prefix.scala:31)
[error] 	at chisel3.Data.$colon$eq(Data.scala:796)
[error] 	at dut.$anonfun$new$2(dut.scala:26)
[error] 	at scala.collection.immutable.Range.foreach$mVc$sp(Range.scala:158)
[error] 	at dut.<init>(dut.scala:23)
[error] 	at Driver$.$anonfun$new$1(driver.scala:6)
[error] 	at ... ()
[error] 	at ... (Stack trace trimmed to user code only. Rerun with --full-stacktrace to see the full stack trace)
[error] stack trace is suppressed; run last Compile / run for the full output
[error] (Compile / run) chisel3.package$ExpectedHardwareException: bits to be sliced 'UInt<8>' must be hardware, not a bare Chisel type. Perhaps you forgot to wrap it in Wire(_) or IO(_)?
