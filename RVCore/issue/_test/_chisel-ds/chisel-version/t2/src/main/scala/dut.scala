import chisel3._
import chisel3.util._

// Define the NPCBundle which is the base class for all bundles
class NPCBundle extends Bundle {}

// Define the ScoreBoard module
class ScoreBoard(maxScore: Int, NR_GPR: Int) extends Module {
  val io = IO(new Bundle {
    val isBusy = Input(UInt(5.W))
    val mask = Input(UInt(NR_GPR.W))
    val update = Input(new Bundle {
      val setMask = UInt(NR_GPR.W)
      val clearMask = UInt(NR_GPR.W)
    })
    val busy = Output(Vec(NR_GPR, UInt(log2Ceil(maxScore + 1).W)))
  })

  // Create a register group to track the usage status of each register
  val busy = RegInit(VecInit(Seq.fill(NR_GPR)(0.U(log2Ceil(maxScore + 1).W))))

  // Function to check if a register is busy
  def isBusy(idx: UInt): Bool = {
    busy(idx) =/= 0.U
  }

  // Function to generate a register bit mask
  def mask(idx: UInt): UInt = {
    (1.U << idx)
  }

  // Function to update the scoreboard status
  def update(setMask: UInt, clearMask: UInt): Unit = {
    for (i <- 1 until NR_GPR) {
      when(setMask(i) && !clearMask(i)) {
        busy(i) := Mux(busy(i) < maxScore.U, busy(i) + 1.U, busy(i))
      }.elsewhen(!setMask(i) && clearMask(i)) {
        busy(i) := Mux(busy(i) > 0.U, busy(i) - 1.U, busy(i))
      }.otherwise {
        busy(i) := busy(i)
      }
    }
  }

  // Connect the IO ports
  io.busy := busy
}

// Define the WbuToRegIO bundle
class WbuToRegIO extends NPCBundle {
  val rd = UInt(5.W)
  val Res = UInt(32.W)
  val RegWrite = Bool()
}

// Define the DecodeIO bundle
class DecodeIO extends NPCBundle {
  val cf = new CtrlFlow
  val ctrl = new CtrlSignal
  val data = new DataSrc
}

// Define the CtrlFlow bundle
class CtrlFlow extends NPCBundle {
  val inst = UInt(32.W)
  val pc = UInt(32.W)
  val next_pc = UInt(32.W)
  val isBranch = Bool()
}

// Define the CtrlSignal bundle
class CtrlSignal extends NPCBundle {
  val MemWrite = Bool()
  val ResSrc = UInt(2.W)
  val fuSrc1Type = FuSrcType()
  val fuSrc2Type = FuSrcType()
  val fuType = FuType()
  val fuOpType = FuOpType()
  val rs1 = UInt(5.W)
  val rs2 = UInt(5.W)
  val rfWen = Bool()
  val rd = UInt(5.W)
}

// Define the DataSrc bundle
class DataSrc extends NPCBundle {
  val fuSrc1 = UInt(32.W)
  val fuSrc2 = UInt(32.W)
  val imm = UInt(32.W)
  val Alu0Res = Decoupled(UInt(32.W))
  val data_from_mem = UInt(32.W)
  val csrRdata = UInt(32.W)
  val rfSrc1 = UInt(32.W)
  val rfSrc2 = UInt(32.W)
}

// Define the FuSrcType enumeration
object FuSrcType extends ChiselEnum {
  val rfSrc1, pc, zero, rfSrc2, imm, four = Value
}

// Define the FuType enumeration
object FuType extends ChiselEnum {
  val ALU, MEM, CSR = Value
}

// Define the FuOpType enumeration
object FuOpType extends ChiselEnum {
  val ADD, SUB, AND, OR, XOR = Value
}

// Define the ISU module
class ISU(maxScore: Int, NR_GPR: Int, XLen: Int) extends Module {
  val io = IO(new Bundle {
    val from_idu = Flipped(Decoupled(new DecodeIO))
    val to_exu = Decoupled(new DecodeIO)
    val wb = Input(new WbuToRegIO)
    val from_reg = new Bundle {
      val rfSrc1 = Input(UInt(XLen.W))
      val rfSrc2 = Input(UInt(XLen.W))
    }
  })

  // Instantiate the ScoreBoard
  val sb = Module(new ScoreBoard(maxScore, NR_GPR))

  // Data hazard detection
  val rs1Busy = sb.isBusy(io.from_idu.bits.ctrl.rs1)
  val rs2Busy = sb.isBusy(io.from_idu.bits.ctrl.rs2)
  val AnyInvalidCondition = rs1Busy || rs2Busy

  // Handle handshake signal
  def HandShakeDeal(in: DecoupledIO[DecodeIO], out: DecoupledIO[DecodeIO], invalid: Bool): Unit = {
    out.valid := in.valid && !invalid
    in.ready := out.ready && !invalid
  }

  HandShakeDeal(io.from_idu, io.to_exu, AnyInvalidCondition)

  // Register file connection function
  def rs1_rs2(rfSrc1: UInt, rfSrc2: UInt): (UInt, UInt) = {
    (rfSrc1, rfSrc2)
  }

  val (rs1, rs2) = rs1_rs2(io.from_reg.rfSrc1, io.from_reg.rfSrc2)

  // Operand processing
  io.to_exu.bits.data.fuSrc1 := MuxLookup(io.from_idu.bits.ctrl.fuSrc1Type, 0.U, Seq(
    FuSrcType.rfSrc1 -> rs1,
    FuSrcType.pc -> io.from_idu.bits.cf.pc,
    FuSrcType.zero -> 0.U,
    FuSrcType.rfSrc2 -> rs2,
    FuSrcType.imm -> io.from_idu.bits.data.imm,
    FuSrcType.four -> 4.U
  ))

  io.to_exu.bits.data.fuSrc2 := MuxLookup(io.from_idu.bits.ctrl.fuSrc2Type, 0.U, Seq(
    FuSrcType.rfSrc1 -> rs1,
    FuSrcType.pc -> io.from_idu.bits.cf.pc,
    FuSrcType.zero -> 0.U,
    FuSrcType.rfSrc2 -> rs2,
    FuSrcType.imm -> io.from_idu.bits.data.imm,
    FuSrcType.four -> 4.U
  ))

  // Scoreboard update
  val wbuClearMask = Mux(io.wb.RegWrite, sb.mask(io.wb.rd), 0.U)
  val isFireSetMask = Mux(io.from_idu.bits.ctrl.rfWen && io.to_exu.fire, sb.mask(io.from_idu.bits.ctrl.rd), 0.U)
  sb.update(isFireSetMask, wbuClearMask)

  // Connect Output
  io.to_exu.bits := io.from_idu.bits
}

// Main object to generate the Verilog code
/*
object ISU extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new ISU(3, 32, 32), Array("--target-dir", "generated"))
}
*/
