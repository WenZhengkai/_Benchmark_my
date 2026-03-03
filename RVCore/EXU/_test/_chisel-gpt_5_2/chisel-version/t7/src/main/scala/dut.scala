// package npc.core

import chisel3._
import chisel3.util._

// -----------------------------
// Minimal base infrastructure
// (keep these if your project already defines them; otherwise this compiles standalone)
// -----------------------------
trait HasNPCParameter {
  val XLen: Int = 64
}

abstract class NPCModule extends Module with HasNPCParameter
abstract class NPCBundle extends Bundle with HasNPCParameter

// -----------------------------
// Enums (placeholders; replace with your real project definitions if already present)
// -----------------------------
object FuType extends ChiselEnum {
  val alu, lsu, csr, none = Value
}
object FuOpType extends ChiselEnum {
  val add, sub, and_, or_, xor_, sll, srl, sra, slt, sltu, pass = Value
}
object FuSrcType extends ChiselEnum {
  val rs, imm, pc, none = Value
}

// -----------------------------
// Bundles (those marked "already defined" in your spec are repeated here for completeness)
// -----------------------------
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

  // execution results driven by this dut
  val Alu0Res       = Decoupled(UInt(XLen.W))
  val data_from_mem = UInt(XLen.W)
  val csrRdata      = UInt(XLen.W)

  // register file read (not used here, but kept for compatibility)
  val rfSrc1 = UInt(XLen.W)
  val rfSrc2 = UInt(XLen.W)
}

class DecodeIO extends NPCBundle {
  val cf   = new CtrlFlow
  val ctrl = new CtrlSignal
  val data = new DataSrc
}

// WBU side (minimal)
class ExuToWbuIO extends NPCBundle {
  val cf   = new CtrlFlow
  val ctrl = new CtrlSignal
  val data = new DataSrc
}

// LSU <-> MEM bundles (minimal placeholders)
class ToMem extends NPCBundle {
  val valid = Bool()
  val addr  = UInt(XLen.W)
  val wdata = UInt(XLen.W)
  val wmask = UInt((XLen / 8).W)
  val wen   = Bool()
}
class FromMem extends NPCBundle {
  val rvalid = Bool()
  val rdata  = UInt(XLen.W)
}

// Branch result bundle (already defined in spec)
class BruRes extends NPCBundle {
  val valid    = Bool()
  val targetPc = UInt(XLen.W)
}

// -----------------------------
// Handshake helper (matches the spec usage)
// -----------------------------
object HandShakeDeal {
  def apply(in: DecoupledIO[DecodeIO],
            out: DecoupledIO[ExuToWbuIO],
            AnyInvalidCondition: Bool,
            AnyStopCodition: Bool): Unit = {
    val stop = AnyStopCodition
    out.valid := in.valid && !AnyInvalidCondition && !stop
    in.ready  := out.ready && !AnyInvalidCondition && !stop
  }
}

// -----------------------------
// Simple ALU / LSU / CSR module skeletons
// (Replace with your real implementations if present)
// -----------------------------
class AluIn extends NPCBundle {
  val srca     = UInt(XLen.W)
  val srcb     = UInt(XLen.W)
  val fuOpType = FuOpType()
}
class Alu extends NPCModule {
  val io = IO(new Bundle {
    val in  = Flipped(Decoupled(new AluIn))
    val out = Decoupled(UInt(XLen.W))
  })

  io.in.ready := io.out.ready
  io.out.valid := io.in.valid

  val a = io.in.bits.srca
  val b = io.in.bits.srcb
  val res = WireDefault(0.U(XLen.W))
  switch(io.in.bits.fuOpType) {
    is(FuOpType.add)  { res := a + b }
    is(FuOpType.sub)  { res := a - b }
    is(FuOpType.and_) { res := a & b }
    is(FuOpType.or_)  { res := a | b }
    is(FuOpType.xor_) { res := a ^ b }
    is(FuOpType.sll)  { res := a << b(5, 0) }
    is(FuOpType.srl)  { res := a >> b(5, 0) }
    is(FuOpType.sra)  { res := (a.asSInt >> b(5, 0)).asUInt }
    is(FuOpType.slt)  { res := (a.asSInt < b.asSInt).asUInt }
    is(FuOpType.sltu) { res := (a < b).asUInt }
    is(FuOpType.pass) { res := a }
  }
  io.out.bits := res
}

class LsuOut extends NPCBundle {
  val rdata = UInt(XLen.W)
}
class Lsu extends NPCModule {
  val io = IO(new Bundle {
    val in       = Flipped(Decoupled(new Bundle {
      val srca     = UInt(XLen.W) // base
      val srcb     = UInt(XLen.W) // store data (if any)
      val imm      = UInt(XLen.W) // offset
      val fuOpType = FuOpType()
      val ctrl     = new CtrlSignal
    }))
    val out      = Decoupled(new LsuOut)
    val to_mem   = Output(new ToMem)
    val from_mem = Input(new FromMem)
  })

  // very simplified "one-cycle" LSU interface
  val addr = io.in.bits.srca + io.in.bits.imm

  io.to_mem.valid := io.in.valid
  io.to_mem.addr  := addr
  io.to_mem.wdata := io.in.bits.srcb
  io.to_mem.wmask := Fill(XLen / 8, 1.U(1.W))
  io.to_mem.wen   := io.in.bits.ctrl.MemWrite

  // handshake: accept when downstream accepts (single-stage)
  io.in.ready := io.out.ready

  io.out.valid := io.in.valid
  io.out.bits.rdata := Mux(io.from_mem.rvalid, io.from_mem.rdata, 0.U)
}

class CsrIn extends NPCBundle {
  val srca     = UInt(XLen.W)
  val srcb     = UInt(XLen.W)
  val imm      = UInt(XLen.W)
  val fuOpType = FuOpType()
  val inst     = UInt(32.W)
}
class Csr extends NPCModule {
  val io = IO(new Bundle {
    val in  = Flipped(Decoupled(new CsrIn))
    val out = Decoupled(UInt(XLen.W))
  })

  io.in.ready := io.out.ready
  io.out.valid := io.in.valid
  // placeholder CSR behavior
  io.out.bits := io.in.bits.srca ^ io.in.bits.srcb ^ io.in.bits.imm
}

// -----------------------------
// Branch calc helper
// - In your real design, decode inst/ctrl and use ALU/CSR results as needed.
// -----------------------------
object CalBruRes {
  def apply(inBits: DecodeIO, alu0: Alu, csr0: Csr): BruRes = {
    val r = Wire(new BruRes)
    // placeholder: treat isBranch as "has bru result", target = ALU result (srca+srcb default add)
    r.valid    := inBits.cf.isBranch
    r.targetPc := alu0.io.out.bits
    r
  }
}

// -----------------------------
// dut
// -----------------------------
class dut extends NPCModule {
  val io = IO(new Bundle {
    val from_isu = Flipped(Decoupled(new DecodeIO))
    val to_wbu   = Decoupled(new ExuToWbuIO)
    val to_mem   = new ToMem
    val from_mem = new FromMem
    val redirect = Output(new Redirect)
  })

  // 1) Output connection: pass through cf/ctrl/data first
  io.to_wbu.bits.cf   := io.from_isu.bits.cf
  io.to_wbu.bits.ctrl := io.from_isu.bits.ctrl
  io.to_wbu.bits.data := io.from_isu.bits.data

  // Default tie-offs for result channels inside DataSrc
  io.to_wbu.bits.data.Alu0Res.valid := false.B
  io.to_wbu.bits.data.Alu0Res.bits  := 0.U
  io.to_wbu.bits.data.data_from_mem := 0.U
  io.to_wbu.bits.data.csrRdata      := 0.U

  // 2) Functional unit distribution
  val isAlu = io.from_isu.bits.ctrl.fuType === FuType.alu
  val isLsu = io.from_isu.bits.ctrl.fuType === FuType.lsu
  val isCsr = io.from_isu.bits.ctrl.fuType === FuType.csr

  // ---- ALU
  val alu0 = Module(new Alu)
  alu0.io.in.bits.srca     := io.from_isu.bits.data.fuSrc1
  alu0.io.in.bits.srcb     := io.from_isu.bits.data.fuSrc2
  alu0.io.in.bits.fuOpType := io.from_isu.bits.ctrl.fuOpType
  alu0.io.in.valid         := io.from_isu.valid && isAlu
  alu0.io.out.ready        := io.to_wbu.ready

  io.to_wbu.bits.data.Alu0Res.valid := alu0.io.out.valid
  io.to_wbu.bits.data.Alu0Res.bits  := alu0.io.out.bits

  // ---- LSU
  val lsu0 = Module(new Lsu)
  lsu0.io.in.bits.srca     := io.from_isu.bits.data.fuSrc1
  lsu0.io.in.bits.srcb     := io.from_isu.bits.data.fuSrc2
  lsu0.io.in.bits.imm      := io.from_isu.bits.data.imm
  lsu0.io.in.bits.fuOpType := io.from_isu.bits.ctrl.fuOpType
  lsu0.io.in.bits.ctrl     := io.from_isu.bits.ctrl
  lsu0.io.in.valid         := io.from_isu.valid && isLsu
  lsu0.io.out.ready        := io.to_wbu.ready

  lsu0.io.from_mem := io.from_mem
  io.to_mem        := lsu0.io.to_mem

  io.to_wbu.bits.data.data_from_mem := lsu0.io.out.bits.rdata

  // ---- CSR
  val csr0 = Module(new Csr)
  csr0.io.in.bits.srca     := io.from_isu.bits.data.fuSrc1
  csr0.io.in.bits.srcb     := io.from_isu.bits.data.fuSrc2
  csr0.io.in.bits.imm      := io.from_isu.bits.data.imm
  csr0.io.in.bits.fuOpType := io.from_isu.bits.ctrl.fuOpType
  csr0.io.in.bits.inst     := io.from_isu.bits.cf.inst
  csr0.io.in.valid         := io.from_isu.valid && isCsr
  csr0.io.out.ready        := io.to_wbu.ready

  io.to_wbu.bits.data.csrRdata := csr0.io.out.bits

  // 3) Branch jump processing
  val bruRes = Wire(new BruRes)
  bruRes := CalBruRes(io.from_isu.bits, alu0, csr0)

  val predictError = bruRes.valid && (io.from_isu.bits.cf.next_pc =/= bruRes.targetPc)

  io.redirect.valid  := io.from_isu.valid && bruRes.valid && predictError
  io.redirect.target := bruRes.targetPc

  // Update next_pc to correct target when mispredicted
  when(predictError) {
    io.to_wbu.bits.cf.next_pc := bruRes.targetPc
  }

  // 4) Handshake signal processing
  HandShakeDeal(
    io.from_isu,
    io.to_wbu,
    AnyInvalidCondition = false.B,
    AnyStopCodition     = io.redirect.valid && io.from_isu.valid
  )
}
