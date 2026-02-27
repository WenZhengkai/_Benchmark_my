import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val i_en = Input(Bool())
    val adda = Input(UInt(64.W))
    val addb = Input(UInt(64.W))
    val result = Output(UInt(65.W))
    val o_en = Output(Bool())
  })

  // Pipeline registers for input operands
  val addaReg = Reg(Vec(4, UInt(16.W)))
  val addbReg = Reg(Vec(4, UInt(16.W)))

  // Pipeline registers for carry signals
  val carryReg = Reg(Vec(4, UInt(1.W)))
  carryReg(0) := 0.U // Initialize carry for the first stage

  // Pipeline registers for partial sums
  val sumReg = Reg(Vec(4, UInt(17.W)))

  // Pipeline register for enable signal
  val enReg = Reg(Vec(4, Bool()))

  // Stage 1: Calculate partial sum for bits [15:0]
  addaReg(0) := io.adda(15, 0)
  addbReg(0) := io.addb(15, 0)
  sumReg(0) := addaReg(0) +& addbReg(0) + carryReg(0)
  carryReg(1) := sumReg(0)(16)
  enReg(0) := io.i_en

  // Stage 2: Calculate partial sum for bits [31:16]
  addaReg(1) := io.adda(31, 16)
  addbReg(1) := io.addb(31, 16)
  sumReg(1) := addaReg(1) +& addbReg(1) + carryReg(1)
  carryReg(2) := sumReg(1)(16)
  enReg(1) := enReg(0)

  // Stage 3: Calculate partial sum for bits [47:32]
  addaReg(2) := io.adda(47, 32)
  addbReg(2) := io.addb(47, 32)
  sumReg(2) := addaReg(2) +& addbReg(2) + carryReg(2)
  carryReg(3) := sumReg(2)(16)
  enReg(2) := enReg(1)

  // Stage 4: Calculate partial sum for bits [63:48]
  addaReg(3) := io.adda(63, 48)
  addbReg(3) := io.addb(63, 48)
  sumReg(3) := addaReg(3) +& addbReg(3) + carryReg(3)
  enReg(3) := enReg(2)

  // Combine partial sums to form the final result
  io.result := Cat(sumReg(3)(15, 0), sumReg(2)(15, 0), sumReg(1)(15, 0), sumReg(0)(15, 0)) +& (sumReg(3)(16) << 64)
  io.o_en := enReg(3)
}

/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(), Array("--target-dir", "generated"))
}
*/
