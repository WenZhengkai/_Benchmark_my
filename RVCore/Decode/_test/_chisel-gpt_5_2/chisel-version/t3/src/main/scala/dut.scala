// package npc

import chisel3._
import chisel3.util._

/** dut: Instruction Decode Unit
  *
  * Notes:
  * - This module assumes the following are already defined elsewhere in your project:
  *   - NPCModule, NPCBundle, HasNPCParameter (with XLen, IndependentBru)
  *   - HandShakeDeal(in: DecoupledIO[_], out: DecoupledIO[_], invalid: Bool): Unit
  *   - SignExt(a: UInt, len: Int): UInt
  *   - RVI_Inst.table : Array[(BitPat, List[UInt])] (or compatible with ListLookup)
  *   - ALUOpType.sll : UInt (7.W or compatible with FuOpType())
  *   - Bundles: CtrlFlow, CtrlSignal, DataSrc, DecodeIO (as described)
  */
class dut extends NPCModule {

  // -----------------------------
  // Instruction type definitions
  // -----------------------------
  trait TYPE_INST {
    def TYPE_N = "b0000".U
    def TYPE_I = "b0100".U
    def TYPE_R = "b0101".U
    def TYPE_S = "b0010".U
    def TYPE_B = "b0001".U
    def TYPE_U = "b0110".U
    def TYPE_J = "b0111".U

    def isRegWrite(instType: UInt): Bool = instType(2, 2) === 1.U
  }

  // -----------------------------
  // FU related parameters
  // -----------------------------
  object FuType extends HasNPCParameter { // Determine which functional unit handles the signal bundle
    def num = 5
    def alu = "b000".U
    def lsu = "b001".U
    def mdu = "b010".U
    def csr = "b011".U
    def mou = "b100".U
    def bru = if (IndependentBru) "b101".U else alu
    def apply() = UInt(log2Up(num).W) // Define the type of this type of signal
  }

  object FuOpType { // Determine what operation the functional unit performs
    def apply() = UInt(7.W)
  }

  object FuSrcType { // Determine the source operand type required by the functional unit
    def rfSrc1 = "b000".U
    def rfSrc2 = "b001".U
    def pc     = "b010".U
    def imm    = "b011".U
    def zero   = "b100".U
    def four   = "b101".U
    def apply() = UInt(3.W)
  }

  object Instructions extends TYPE_INST with HasNPCParameter {
    def NOP = 0x00000013.U
    val DecodeDefault = List(TYPE_N, FuType.alu, ALUOpType.sll, FuSrcType.zero, FuSrcType.zero)
    def DecodeTable = RVI_Inst.table
  }

  // -----------------------------
  // IO
  // -----------------------------
  val io = IO(new NPCBundle {
    val from_ifu = Flipped(Decoupled(new CtrlFlow))
    val to_isu   = Decoupled(new DecodeIO)
  })

  // -----------------------------
  // 1) Handshake processing
  // -----------------------------
  val AnyInvalidCondition = false.B
  HandShakeDeal(io.from_ifu, io.to_isu, AnyInvalidCondition)

  // -----------------------------
  // 2) Instruction decoding
  // -----------------------------
  val inst = io.from_ifu.bits.inst
  val instType :: fuType :: fuOpType :: fuSrc1Type :: fuSrc2Type :: Nil =
    ListLookup(inst, Instructions.DecodeDefault, Instructions.DecodeTable)

  // -----------------------------
  // 3) Control signal generation
  // -----------------------------
  val ctrl = Wire(new CtrlSignal)

  ctrl.rs1   := inst(19, 15)
  ctrl.rs2   := inst(24, 20)
  ctrl.rd    := inst(11, 7)
  ctrl.rfWen := Instructions.isRegWrite(instType)

  ctrl.MemWrite := (instType === Instructions.TYPE_S)

  // ResSrc:
  // 0: ALU/others
  // 1: load
  // 2: CSR
  ctrl.ResSrc := MuxLookup(inst(6, 0), 0.U, Seq(
    "b0000011".U -> 1.U, // load
    "b1110011".U -> 2.U  // csr
  ))

  ctrl.fuSrc1Type := fuSrc1Type
  ctrl.fuSrc2Type := fuSrc2Type
  ctrl.fuType     := fuType
  ctrl.fuOpType   := fuOpType

  // -----------------------------
  // 4) Immediate extension
  // -----------------------------
  val immI = SignExt(inst(31, 20), XLen)

  val immU = SignExt(Cat(inst(31, 12), 0.U(12.W)), XLen)

  val immJ = SignExt(
    Cat(
      inst(31),      // imm[20]
      inst(19, 12),  // imm[19:12]
      inst(20),      // imm[11]
      inst(30, 21),  // imm[10:1]
      0.U(1.W)       // imm[0]
    ),
    XLen
  )

  val immS = SignExt(Cat(inst(31, 25), inst(11, 7)), XLen)

  val immB = SignExt(
    Cat(
      inst(31),      // imm[12]
      inst(7),       // imm[11]
      inst(30, 25),  // imm[10:5]
      inst(11, 8),   // imm[4:1]
      0.U(1.W)       // imm[0]
    ),
    XLen
  )

  val imm = Wire(UInt(XLen.W))
  imm := 0.U
  switch(instType) {
    is(Instructions.TYPE_I) { imm := immI }
    is(Instructions.TYPE_U) { imm := immU }
    is(Instructions.TYPE_J) { imm := immJ }
    is(Instructions.TYPE_S) { imm := immS }
    is(Instructions.TYPE_B) { imm := immB }
    // TYPE_R/TYPE_N: keep 0
  }

  // -----------------------------
  // 5) Data source preparation
  // -----------------------------
  val data = Wire(new DataSrc)
  data := DontCare
  data.imm := imm

  // -----------------------------
  // 6) Output connection
  // -----------------------------
  io.to_isu.bits.cf   := io.from_ifu.bits
  io.to_isu.bits.ctrl := ctrl
  io.to_isu.bits.data := data
}
