// package npc.core

import chisel3._
import chisel3.util._

// ================================================================
// Minimal infrastructure (NPC base / parameters)
// ================================================================
trait HasNPCParameter {
  val XLen: Int = 64
}

abstract class NPCBundle extends Bundle with HasNPCParameter
abstract class NPCModule extends Module with HasNPCParameter

// ================================================================
// Enums / Types (FuType, FuOpType, FuSrcType)
// ================================================================
object FuType {
  // width chosen to be small and sufficient
  def apply(): UInt = UInt(3.W)
  val alu :: lsu :: csr :: Nil = Enum(3)
}

object FuSrcType {
  def apply(): UInt = UInt(2.W)
  val reg :: imm :: pc :: Nil = Enum(3)
}

object FuOpType {
  // Use 6 bits as a generic opcode space for ALU/LSU/CSR ops
  def apply(): UInt = UInt(6.W)
}

// ================================================================
// Bundles (as referenced by the spec)
// ================================================================
class Redirect extends NPCBundle {
  val target = UInt(XLen.W)
  val valid  = Bool()
}

class CtrlFlow extends NPCBundle {
  val inst     = UInt(32.W)
  val pc       = UInt(XLen.W)
  val next_pc  = UInt(XLen.W)
  val isBranch = Bool()
}

class CtrlSignal extends NPCBundle {
  val MemWrite  = Bool()
  val ResSrc    = UInt(2.W)

  val fuSrc1Type = FuSrcType()
  val fuSrc2Type = FuSrcType()
  val fuType     = FuType()
  val fuOpType   = FuOpType()

  val rs1   = UInt(5.W)
  val rs2   = UInt(5.W)
  val rfWen = Bool()
  val rd    = UInt(5.W)
}

class DataSrc extends NPCBundle {
  val fuSrc1 = UInt(XLen.W)
  val fuSrc2 = UInt(XLen.W)
  val imm    = UInt(XLen.W)

  val Alu0Res       = Decoupled(UInt(XLen.W)) // driven by dut from ALU
  val data_from_mem = UInt(XLen.W)            // driven by dut from LSU
  val csrRdata      = UInt(XLen.W)            // driven by dut from CSR
  val rfSrc1        = UInt(XLen.W)
  val rfSrc2        = UInt(XLen.W)
}

class DecodeIO extends NPCBundle {
  val cf   = new CtrlFlow
  val ctrl = new CtrlSignal
  val data = new DataSrc
}

class ExuToWbuIO extends NPCBundle {
  val cf   = new CtrlFlow
  val ctrl = new CtrlSignal
  val data = new DataSrc
}

// ================================================================
// Memory interface (simple placeholder)
// ================================================================
class ToMem extends NPCBundle {
  val valid = Bool()
  val wen   = Bool()
  val addr  = UInt(XLen.W)
  val wdata = UInt(XLen.W)
  val wmask = UInt((XLen / 8).W)
}

class FromMem extends NPCBundle {
  val valid = Bool()
  val rdata = UInt(XLen.W)
}

// ================================================================
// BRU result bundle + calculation helper
// ================================================================
class BruRes extends NPCBundle {
  val valid    = Bool()
  val targetPc = UInt(XLen.W)
}

// ================================================================
// Functional Units (minimal but synthesizable placeholders)
// ================================================================
class AluIn extends NPCBundle {
  val srca     = UInt(XLen.W)
  val srcb     = UInt(XLen.W)
  val fuOpType = FuOpType()
  val pc       = UInt(XLen.W)
  val imm      = UInt(XLen.W)
}
class Alu extends NPCModule {
  val io = IO(new Bundle {
    val in  = Flipped(Decoupled(new AluIn))
    val out = Decoupled(UInt(XLen.W))
  })

  io.in.ready := io.out.ready
  io.out.valid := io.in.valid

  // Minimal generic ALU behavior
  val a = io.in.bits.srca
  val b = io.in.bits.srcb
  val pc = io.in.bits.pc
  val imm = io.in.bits.imm
  // A small opcode map:
  // 0:add, 1:sub, 2:and, 3:or, 4:xor, 5:slt, 6:sll, 7:srl, 8:copyB, 9:pc+imm
  io.out.bits := MuxLookup(io.in.bits.fuOpType, a + b, Seq(
    0.U -> (a + b),
    1.U -> (a - b),
    2.U -> (a & b),
    3.U -> (a | b),
    4.U -> (a ^ b),
    5.U -> (a.asSInt < b.asSInt).asUInt,
    6.U -> (a << b(5,0)),
    7.U -> (a >> b(5,0)),
    8.U -> b,
    9.U -> (pc + imm)
  ))
}

class LsuIn extends NPCBundle {
  val srca     = UInt(XLen.W)  // base
  val srcb     = UInt(XLen.W)  // store data
  val imm      = UInt(XLen.W)  // offset
  val fuOpType = FuOpType()
  val memWrite = Bool()
}
class LsuOut extends NPCBundle {
  val rdata = UInt(XLen.W)
}
class LSU extends NPCModule {
  val io = IO(new Bundle {
    val in       = Flipped(Decoupled(new LsuIn))
    val out      = Decoupled(new LsuOut)
    val to_mem   = new ToMem
    val from_mem = new FromMem

    // passthrough (as in spec: lsu0.io.ctrl / lsu0.io.data exist)
    val ctrl = Input(new CtrlSignal)
    val data = Input(new DataSrc)
  })

  // Drive memory request when we accept an LSU op
  val fire = io.in.valid && io.in.ready

  // Single-cycle "request": valid follows in.valid; ready follows out.ready
  // (A real LSU would be multi-cycle; this keeps handshake consistent.)
  io.in.ready := io.out.ready

  io.to_mem.valid := io.in.valid
  io.to_mem.wen   := io.in.bits.memWrite
  io.to_mem.addr  := io.in.bits.srca + io.in.bits.imm
  io.to_mem.wdata := io.in.bits.srcb
  io.to_mem.wmask := Fill(XLen / 8, 1.U(1.W))

  io.out.valid := io.in.valid
  // read data comes from from_mem.rdata (assume aligned, already returned)
  io.out.bits.rdata := io.from_mem.rdata
}

class CsrIn extends NPCBundle {
  val srca     = UInt(XLen.W)
  val srcb     = UInt(XLen.W)
  val imm      = UInt(XLen.W)
  val fuOpType = FuOpType()
}
class CSR extends NPCModule {
  val io = IO(new Bundle {
    val in  = Flipped(Decoupled(new CsrIn))
    val out = Decoupled(UInt(XLen.W))
  })

  io.in.ready := io.out.ready
  io.out.valid := io.in.valid

  // Placeholder CSR read result: return srca by default
  io.out.bits := MuxLookup(io.in.bits.fuOpType, io.in.bits.srca, Seq(
    0.U -> io.in.bits.srca,         // read
    1.U -> (io.in.bits.srca | io.in.bits.srcb), // set bits
    2.U -> (io.in.bits.srca & ~io.in.bits.srcb) // clear bits
  ))
}

// ================================================================
// Handshake helper (as requested)
// ================================================================
object HandShakeDeal {
  def apply(
    in: DecoupledIO[DecodeIO],
    out: DecoupledIO[ExuToWbuIO],
    AnyInvalidCondition: Bool,
    AnyStopCodition: Bool
  ): Unit = {
    // If stopped, we must not consume input and should not advance output.
    // Basic policy:
    // - out.valid follows in.valid unless invalid condition or stop condition
    // - in.ready follows out.ready unless invalid condition or stop condition
    val allow = !AnyInvalidCondition && !AnyStopCodition
    out.valid := in.valid && allow
    in.ready  := out.ready && allow
  }
}

// ================================================================
// BRU calculation (minimal policy)
// - If isBranch: compute target = pc + imm (using fuSrc2 as imm if needed)
// - valid when instruction isBranch
// ================================================================
object CalBruRes {
  def apply(inBits: DecodeIO, alu0: Alu, csr0: CSR): BruRes = {
    val res = Wire(new BruRes)
    res.valid := inBits.cf.isBranch

    // Compute target:
    // Prefer ALU result when ALU op is used for branch address calc.
    val aluBased = alu0.io.out.bits
    val pcImm    = inBits.cf.pc + inBits.data.imm
    res.targetPc := Mux(inBits.ctrl.fuType === FuType.alu, aluBased, pcImm)
    res
  }
}

// ================================================================
// dut
// ================================================================
class dut extends NPCModule {
  val io = IO(new Bundle {
    val from_isu = Flipped(Decoupled(new DecodeIO))
    val to_wbu   = Decoupled(new ExuToWbuIO)
    val to_mem   = new ToMem
    val from_mem = new FromMem
    val redirect = Output(new Redirect)
  })

  // --------------------------------------------------------------
  // 1) Output connection: cf/ctrl/data connected first
  // --------------------------------------------------------------
  io.to_wbu.bits.cf   := io.from_isu.bits.cf
  io.to_wbu.bits.ctrl := io.from_isu.bits.ctrl
  io.to_wbu.bits.data := io.from_isu.bits.data

  // Provide defaults for decoupled fields inside data
  io.to_wbu.bits.data.Alu0Res.valid := false.B
  io.to_wbu.bits.data.Alu0Res.bits  := 0.U

  // --------------------------------------------------------------
  // 2) Instantiate functional units + wiring
  // --------------------------------------------------------------
  val alu0 = Module(new Alu)
  val lsu0 = Module(new LSU)
  val csr0 = Module(new CSR)

  // ---- ALU wiring
  alu0.io.in.bits.srca     := io.from_isu.bits.data.fuSrc1
  alu0.io.in.bits.srcb     := io.from_isu.bits.data.fuSrc2
  alu0.io.in.bits.fuOpType := io.from_isu.bits.ctrl.fuOpType
  alu0.io.in.bits.pc       := io.from_isu.bits.cf.pc
  alu0.io.in.bits.imm      := io.from_isu.bits.data.imm
  alu0.io.out.ready        := io.to_wbu.ready

  alu0.io.in.valid := io.from_isu.valid && (io.from_isu.bits.ctrl.fuType === FuType.alu)

  // Drive ALU result into wbu payload (Decoupled field inside DataSrc)
  io.to_wbu.bits.data.Alu0Res.valid := alu0.io.out.valid
  io.to_wbu.bits.data.Alu0Res.bits  := alu0.io.out.bits

  // ---- LSU wiring
  lsu0.io.in.bits.srca     := io.from_isu.bits.data.fuSrc1
  lsu0.io.in.bits.srcb     := io.from_isu.bits.data.fuSrc2
  lsu0.io.in.bits.imm      := io.from_isu.bits.data.imm
  lsu0.io.in.bits.fuOpType := io.from_isu.bits.ctrl.fuOpType
  lsu0.io.in.bits.memWrite := io.from_isu.bits.ctrl.MemWrite
  lsu0.io.out.ready        := io.to_wbu.ready

  lsu0.io.in.valid := io.from_isu.valid && (io.from_isu.bits.ctrl.fuType === FuType.lsu)

  lsu0.io.from_mem := io.from_mem
  lsu0.io.ctrl     := io.from_isu.bits.ctrl
  lsu0.io.data     := io.from_isu.bits.data

  // LSU outputs
  io.to_mem := lsu0.io.to_mem
  io.to_wbu.bits.data.data_from_mem := lsu0.io.out.bits.rdata

  // ---- CSR wiring
  csr0.io.in.bits.srca     := io.from_isu.bits.data.fuSrc1
  csr0.io.in.bits.srcb     := io.from_isu.bits.data.fuSrc2
  csr0.io.in.bits.imm      := io.from_isu.bits.data.imm
  csr0.io.in.bits.fuOpType := io.from_isu.bits.ctrl.fuOpType
  csr0.io.out.ready        := io.to_wbu.ready

  csr0.io.in.valid := io.from_isu.valid && (io.from_isu.bits.ctrl.fuType === FuType.csr)

  io.to_wbu.bits.data.csrRdata := csr0.io.out.bits

  // --------------------------------------------------------------
  // 3) Branch/jump processing + redirect generation
  // --------------------------------------------------------------
  val bruRes = Wire(new BruRes)
  bruRes := CalBruRes(io.from_isu.bits, alu0, csr0)

  val predictedNext = io.from_isu.bits.cf.next_pc
  val actualTarget  = bruRes.targetPc
  val mispredict    = bruRes.valid && (predictedNext =/= actualTarget)

  io.redirect.valid  := io.from_isu.valid && mispredict
  io.redirect.target := actualTarget

  // Update outgoing next_pc to the correct target when mispredict
  when(mispredict) {
    io.to_wbu.bits.cf.next_pc := actualTarget
  }

  // --------------------------------------------------------------
  // 4) Handshake
  // --------------------------------------------------------------
  // Stop when redirect is asserted while input is valid
  val stopCond = io.redirect.valid && io.from_isu.valid

  // valid/ready deal
  HandShakeDeal(
    io.from_isu,
    io.to_wbu,
    AnyInvalidCondition = false.B,
    AnyStopCodition     = stopCond
  )
}
