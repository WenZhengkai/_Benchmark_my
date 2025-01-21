Please act as a professional Chisel designer, correct the origianl code

## original code 

import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, n: Int) extends Module {
  val io = IO(new Bundle {
    val dst = Input(UInt(n.W))
    val c = Flipped(Decoupled(data.cloneType))
    val p = Vec(n, Decoupled(data.cloneType))
  })

  // Task 1: Define Registers
  val pData = Reg(data.cloneType)
  val pValid = RegInit(0.U(n.W))

  // Task 2: Compute `pReady` Vector
  val pReady = Wire(UInt(n.W))
  pReady := io.p.map(_.ready).asUInt

  // Task 3: Compute `nxtAccept` Signal
  val nxtAccept = (pValid === 0.U) || ((pValid & pReady) === pValid)

  // Task 4: Update Data and Validity
  when(nxtAccept) {
    pData := io.c.bits
    when(io.c.valid) {
      pValid := io.dst & Fill(n, io.c.valid)
    }.otherwise {
      pValid := 0.U
    }
  }.otherwise {
    pValid := pValid & ~pReady
  }

  // Task 5: Output Assignment
  for (i <- 0 until n) {
    io.p(i).valid := (pValid(i))
    io.p(i).bits := pData
  }

  // Task 6: Implement Ready/Valid Handshake
  io.c.ready := nxtAccept
}




## error information

[error] /home/kai/ChiselProject/Benchmarks/_Benchmark_my/_chisel-ip-contributions/DCMirror/chisel-version/t9/src/main/scala/dut.scala:17:31: value asUInt is not a member of IndexedSeq[chisel3.Bool]
[error]   pReady := io.p.map(_.ready).asUInt
[error]                               ^
[error] one error found
[error] (Compile / compileIncremental) Compilation failed
[error] Total time: 9 s, completed Jan 14, 2025 7:50:27 PM
make: *** [Makefile:3: doit] Error 1


Give me the complete correct Chisel code.