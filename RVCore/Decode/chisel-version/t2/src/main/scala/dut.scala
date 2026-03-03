import chisel3._
import chisel3.util._

class dut extends NPCModule with TYPE_INST {
  val io = IO(new NPCBundle {
    val from_ifu = Flipped(Decoupled(new CtrlFlow))
    val to_isu   = Decoupled(new DecodeIO)
  })

  // 1) Handshake
  val AnyInvalidCondition = false.B
  HandShakeDeal(io.from_ifu, io.to_isu, AnyInvalidCondition)

  // 2) Instruction decode
  val inst = io.from_ifu.bits.inst
  val instType :: fuType :: fuOpType :: fuSrc1Type :: fuSrc2Type :: Nil =
    ListLookup(inst, Instructions.DecodeDefault, Instructions.DecodeTable)

  // 3) Control signal generation
  val ctrl = Wire(new CtrlSignal)
  ctrl.rfWen      := isRegWrite(instType)
  ctrl.rs1        := inst(19, 15)
  ctrl.rs2        := inst(24, 20)
  ctrl.rd         := inst(11, 7)
  ctrl.MemWrite   := (instType === TYPE_S)
  ctrl.ResSrc     := MuxLookup(
    inst(6, 0),
    0.U,
    Seq(
      "b0000011".U -> 1.U, // load
      "b1110011".U -> 2.U  // csr
    )
  )
  ctrl.fuSrc1Type := fuSrc1Type
  ctrl.fuSrc2Type := fuSrc2Type
  ctrl.fuType     := fuType
  ctrl.fuOpType   := fuOpType

  // 4) Immediate extension
  val immI = SignExt(inst(31, 20), XLen)
  val immU = SignExt(Cat(inst(31, 12), 0.U(12.W)), XLen)
  val immJ = SignExt(Cat(inst(31), inst(19, 12), inst(20), inst(30, 21), 0.U(1.W)), XLen)
  val immS = SignExt(Cat(inst(31, 25), inst(11, 7)), XLen)
  val immB = SignExt(Cat(inst(31), inst(7), inst(30, 25), inst(11, 8), 0.U(1.W)), XLen)

  val imm = MuxLookup(
    instType,
    0.U(XLen.W),
    Seq(
      TYPE_I -> immI,
      TYPE_U -> immU,
      TYPE_J -> immJ,
      TYPE_S -> immS,
      TYPE_B -> immB
    )
  )

  // 5) Data source preparation
  val data = Wire(new DataSrc)
  data := DontCare
  data.imm := imm

  // 6) Output connection
  io.to_isu.bits.cf   := io.from_ifu.bits
  io.to_isu.bits.ctrl := ctrl
  io.to_isu.bits.data := data
}
