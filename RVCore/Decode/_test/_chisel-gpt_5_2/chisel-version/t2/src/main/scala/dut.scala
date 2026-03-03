// package npc

import chisel3._
import chisel3.util._

/** dut: Decode unit */
class dut extends NPCModule with TYPE_INST with HasNPCParameter {
  val io = IO(new NPCBundle {
    val from_ifu = Flipped(Decoupled(new CtrlFlow)) // from IFU
    val to_isu   = Decoupled(new DecodeIO)          // to ISU
  })

  // ---------------------------------------------------------------------------
  // 1) Handshake processing
  // ---------------------------------------------------------------------------
  val AnyInvalidCondition = false.B
  HandShakeDeal(io.from_ifu, io.to_isu, AnyInvalidCondition)

  // ---------------------------------------------------------------------------
  // 2) Instruction decoding
  // ---------------------------------------------------------------------------
  val inst = io.from_ifu.bits.inst

  val instType :: fuType :: fuOpType :: fuSrc1Type :: fuSrc2Type :: Nil =
    ListLookup(inst, Instructions.DecodeDefault, Instructions.DecodeTable)

  // ---------------------------------------------------------------------------
  // 3) Control signal generation
  // ---------------------------------------------------------------------------
  val ctrl = Wire(new CtrlSignal)
  ctrl := 0.U.asTypeOf(new CtrlSignal)

  ctrl.rs1  := inst(19, 15)
  ctrl.rs2  := inst(24, 20)
  ctrl.rd   := inst(11, 7)
  ctrl.rfWen := isRegWrite(instType)

  ctrl.MemWrite := (instType === TYPE_S)

  ctrl.ResSrc := Mux(inst(6, 0) === "b0000011".U, 1.U,
                 Mux(inst(6, 0) === "b1110011".U, 2.U, 0.U))

  ctrl.fuType     := fuType
  ctrl.fuOpType   := fuOpType
  ctrl.fuSrc1Type := fuSrc1Type
  ctrl.fuSrc2Type := fuSrc2Type

  // ---------------------------------------------------------------------------
  // 4) Immediate extension
  // ---------------------------------------------------------------------------
  def SignExt(a: UInt, len: Int): UInt = {
    val w = a.getWidth
    Cat(Fill(len - w, a(w - 1)), a)
  }

  val immI = SignExt(inst(31, 20), XLen)

  val immU = {
    val upper = inst(31, 12)
    val u32   = Cat(upper, 0.U(12.W)) // << 12
    if (XLen == 32) u32 else SignExt(u32, XLen)
  }

  val immJ = {
    // J-type: imm[20|10:1|11|19:12|0]
    val raw = Cat(inst(31), inst(19, 12), inst(20), inst(30, 21), 0.U(1.W))
    SignExt(raw, XLen)
  }

  val immS = {
    val raw = Cat(inst(31, 25), inst(11, 7))
    SignExt(raw, XLen)
  }

  val immB = {
    // B-type: imm[12|10:5|4:1|11|0]
    val raw = Cat(inst(31), inst(7), inst(30, 25), inst(11, 8), 0.U(1.W))
    SignExt(raw, XLen)
  }

  val imm = MuxLookup(instType, 0.U(XLen.W), Seq(
    TYPE_I -> immI,
    TYPE_U -> immU,
    TYPE_J -> immJ,
    TYPE_S -> immS,
    TYPE_B -> immB
  ))

  // ---------------------------------------------------------------------------
  // 5) Data source preparation
  // ---------------------------------------------------------------------------
  val data = Wire(new DataSrc)
  data <> DontCare
  data.imm := imm

  // ---------------------------------------------------------------------------
  // 6) Output connection
  // ---------------------------------------------------------------------------
  io.to_isu.bits.cf   := io.from_ifu.bits
  io.to_isu.bits.ctrl := ctrl
  io.to_isu.bits.data := data
}
