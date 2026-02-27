import chisel3._
import chisel3.util._
import chisel3.experimental.ChiselEnum

// Define common parameters and bundles
trait HasNPCParameter {
  val XLen = 32
  val NR_GPR = 32
  val IndependentBru = true
}

class NPCBundle extends Bundle with HasNPCParameter

class Redirect extends NPCBundle {
  val target = UInt(XLen.W)
  val valid = Bool()
}

class WbuToRegIO extends NPCBundle {
  val rd = UInt(5.W)
  val Res = UInt(XLen.W)
  val RegWrite = Bool()
}

class CtrlFlow extends NPCBundle {
  val inst = UInt(32.W)
  val pc = UInt(XLen.W)
  val next_pc = UInt(XLen.W)
  val isBranch = Bool()
}

class CtrlSignal extends NPCBundle {
  val MemWrite = Bool()
  val ResSrc = UInt(2.W)
  val fuSrc1Type = UInt(3.W)
  val fuSrc2Type = UInt(3.W)
  val fuType = UInt(3.W)
  val fuOpType = UInt(7.W)
  val rs1 = UInt(5.W)
  val rs2 = UInt(5.W)
  val rfWen = Bool()
  val rd = UInt(5.W)
}

class DataSrc extends NPCBundle {
  val fuSrc1 = UInt(XLen.W)
  val fuSrc2 = UInt(XLen.W)
  val imm = UInt(XLen.W)
  val Alu0Res = Decoupled(UInt(XLen.W))
  val data_from_mem = UInt(XLen.W)
  val csrRdata = UInt(XLen.W)
  val rfSrc1 = UInt(XLen.W)
  val rfSrc2 = UInt(XLen.W)
}

class DecodeIO extends NPCBundle {
  val cf = new CtrlFlow
  val ctrl = new CtrlSignal
  val data = new DataSrc
}

// IFU Module
class IFU extends Module with HasNPCParameter {
  val io = IO(new Bundle {
    val inst = Input(UInt(32.W))
    val redirect = Input(new Redirect)
    val to_idu = Decoupled(new CtrlFlow)
    val pc = Output(UInt(XLen.W))
  })

  val pcReg = RegInit("h80000000".U(XLen.W))
  val nextPc = Wire(UInt(XLen.W))

  // PC update logic
  when(io.redirect.valid) {
    nextPc := io.redirect.target
  }.otherwise {
    nextPc := pcReg + 4.U
  }

  pcReg := nextPc

  // Output logic
  io.pc := pcReg
  io.to_idu.bits.inst := io.inst
  io.to_idu.bits.pc := pcReg
  io.to_idu.bits.next_pc := nextPc
  io.to_idu.bits.isBranch := false.B
  io.to_idu.valid := true.B
}

// IDU Module
class IDU extends Module with HasNPCParameter {
  val io = IO(new Bundle {
    val from_ifu = Flipped(Decoupled(new CtrlFlow))
    val to_isu = Decoupled(new DecodeIO)
  })

  // Handshake logic
  io.to_isu.valid := io.from_ifu.valid
  io.from_ifu.ready := io.to_isu.ready

  // Decode logic
  val inst = io.from_ifu.bits.inst
  val instType = Wire(UInt(4.W))
  val fuType = Wire(UInt(3.W))
  val fuOpType = Wire(UInt(7.W))
  val fuSrc1Type = Wire(UInt(3.W))
  val fuSrc2Type = Wire(UInt(3.W))

  // Placeholder for decode logic
  instType := "b0100".U // TYPE_I
  fuType := "b000".U   // FuType.alu
  fuOpType := "b0000000".U // ALUOpType.add
  fuSrc1Type := "b000".U // FuSrcType.rfSrc1
  fuSrc2Type := "b011".U // FuSrcType.imm

  // Immediate extension
  val imm = Wire(UInt(XLen.W))
  imm := Cat(Fill(XLen - 12, inst(31)), inst(31, 20))

  // Control signal generation
  io.to_isu.bits.ctrl.MemWrite := false.B
  io.to_isu.bits.ctrl.ResSrc := 0.U
  io.to_isu.bits.ctrl.fuSrc1Type := fuSrc1Type
  io.to_isu.bits.ctrl.fuSrc2Type := fuSrc2Type
  io.to_isu.bits.ctrl.fuType := fuType
  io.to_isu.bits.ctrl.fuOpType := fuOpType
  io.to_isu.bits.ctrl.rs1 := inst(19, 15)
  io.to_isu.bits.ctrl.rs2 := inst(24, 20)
  io.to_isu.bits.ctrl.rfWen := true.B
  io.to_isu.bits.ctrl.rd := inst(11, 7)

  // Data source preparation
  io.to_isu.bits.data.fuSrc1 := DontCare
  io.to_isu.bits.data.fuSrc2 := DontCare
  io.to_isu.bits.data.imm := imm
  io.to_isu.bits.data.Alu0Res := DontCare
  io.to_isu.bits.data.data_from_mem := DontCare
  io.to_isu.bits.data.csrRdata := DontCare
  io.to_isu.bits.data.rfSrc1 := DontCare
  io.to_isu.bits.data.rfSrc2 := DontCare

  // Control flow
  io.to_isu.bits.cf := io.from_ifu.bits
}

// ScoreBoard Module
class ScoreBoard(maxScore: Int) extends Module with HasNPCParameter {
  val io = IO(new Bundle {
    val setMask = Input(UInt(NR_GPR.W))
    val clearMask = Input(UInt(NR_GPR.W))
    val isBusy = Output(UInt(NR_GPR.W))
  })

  val busy = RegInit(VecInit(Seq.fill(NR_GPR)(0.U(log2Up(maxScore + 1).W))))

  // Update logic
  for (i <- 0 until NR_GPR) {
    when(io.setMask(i) && !io.clearMask(i)) {
      busy(i) := Mux(busy(i) < maxScore.U, busy(i) + 1.U, busy(i))
    }.elsewhen(!io.setMask(i) && io.clearMask(i)) {
      busy(i) := Mux(busy(i) > 0.U, busy(i) - 1.U, busy(i))
    }
  }

  io.isBusy := busy.asUInt
}

// ISU Module
class ISU extends Module with HasNPCParameter {
  val io = IO(new Bundle {
    val from_idu = Flipped(Decoupled(new DecodeIO))
    val to_exu = Decoupled(new DecodeIO)
    val wb = Input(new WbuToRegIO)
    val from_reg = new Bundle {
      val rfSrc1 = Input(UInt(XLen.W))
      val rfSrc2 = Input(UInt(XLen.W))
    }
  })

  val sb = Module(new ScoreBoard(3))

  // Data hazard detection
  val rs1Busy = sb.io.isBusy(io.from_idu.bits.ctrl.rs1)
  val rs2Busy = sb.io.isBusy(io.from_idu.bits.ctrl.rs2)
  val hazardDetected = rs1Busy.orR || rs2Busy.orR

  // Handshake logic
  io.to_exu.valid := io.from_idu.valid && !hazardDetected
  io.from_idu.ready := io.to_exu.ready && !hazardDetected

  // Operand processing
  io.to_exu.bits.data.fuSrc1 := MuxLookup(io.from_idu.bits.ctrl.fuSrc1Type, 0.U, Seq(
    "b000".U -> io.from_reg.rfSrc1,
    "b010".U -> io.from_idu.bits.cf.pc,
    "b100".U -> 0.U
  ))

  io.to_exu.bits.data.fuSrc2 := MuxLookup(io.from_idu.bits.ctrl.fuSrc2Type, 0.U, Seq(
    "b001".U -> io.from_reg.rfSrc2,
    "b011".U -> io.from_idu.bits.data.imm,
    "b101".U -> 4.U
  ))

  // Scoreboard update
  val wbuClearMask = Mux(io.wb.RegWrite, sb.io.mask(io.wb.rd), 0.U)
  val isFireSetMask = Mux(io.from_idu.bits.ctrl.rfWen && io.to_exu.fire, sb.io.mask(io.from_idu.bits.ctrl.rd), 0.U)
  sb.io.setMask := isFireSetMask
  sb.io.clearMask := wbuClearMask

  // Connect other signals
  io.to_exu.bits.cf := io.from_idu.bits.cf
  io.to_exu.bits.ctrl := io.from_idu.bits.ctrl
  io.to_exu.bits.data.rfSrc1 := io.from_reg.rfSrc1
  io.to_exu.bits.data.rfSrc2 := io.from_reg.rfSrc2
}

// dut Module
class dut extends Module with HasNPCParameter {
  val io = IO(new Bundle {
    val redirect = Input(Bool())
    val inst = Input(UInt(32.W))
    val ifuredirect = Input(new Redirect)
    val wb = Input(new WbuToRegIO)
    val rfSrc1 = Input(UInt(XLen.W))
    val rfSrc2 = Input(UInt(XLen.W))
    val pc = Output(UInt(XLen.W))
    val to_exu = Decoupled(new DecodeIO)
    val rs1 = Output(UInt(5.W))
    val rs2 = Output(UInt(5.W))
  })

  val ifu = Module(new IFU)
  val idu = Module(new IDU)
  val isu = Module(new ISU)

  // Interconnections
  ifu.io.inst := io.inst
  io.pc := ifu.io.pc
  ifu.io.redirect := io.ifuredirect

  idu.io.from_ifu <> ifu.io.to_idu
  isu.io.from_idu <> idu.io.to_isu
  io.to_exu <> isu.io.to_exu

  isu.io.wb := io.wb
  isu.io.from_reg.rfSrc1 := io.rfSrc1
  isu.io.from_reg.rfSrc2 := io.rfSrc2

  // Stage connections
  def StageConnect(from: DecoupledIO[DecodeIO], to: DecoupledIO[DecodeIO], fire: Bool, redirect: Bool): Unit = {
    to.valid := from.valid
    from.ready := to.ready
    to.bits := from.bits
    when(redirect) {
      to.valid := false.B
      from.ready := true.B
    }
  }

  StageConnect(idu.io.to_isu, isu.io.from_idu, isu.io.to_exu.fire, io.redirect)

  // Register source connections
  val (rs1, rs2) = isu.rs1_rs2(io.rfSrc1, io.rfSrc2)
  io.rs1 := rs1
  io.rs2 := rs2
}
