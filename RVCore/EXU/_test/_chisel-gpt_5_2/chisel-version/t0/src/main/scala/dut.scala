// package npc

import chisel3._
import chisel3.util._

// ================================================================
// Minimal infrastructure (parameters / base classes / enums / IOs)
// ================================================================

trait HasNPCParameter {
  val XLen: Int = 64
}

abstract class NPCBundle extends Bundle with HasNPCParameter
abstract class NPCModule extends Module with HasNPCParameter

// ---------- FU type / operand type / op type (simple encodings) ----------
object FuType {
  def width: Int = 3
  def apply(): UInt = UInt(width.W)

  val alu: UInt = 0.U(width.W)
  val lsu: UInt = 1.U(width.W)
  val csr: UInt = 2.U(width.W)
  val bru: UInt = 3.U(width.W) // optional, if decode uses a separate type
}

object FuSrcType {
  def width: Int = 2
  def apply(): UInt = UInt(width.W)
}

object FuOpType {
  def width: Int = 6
  def apply(): UInt = UInt(width.W)
}

// ================================================================
// Bundles described in the prompt (and required surrounding bundles)
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
  val ResSrc    = UInt() // left unspecified width by prompt

  val fuSrc1Type = FuSrcType()
  val fuSrc2Type = FuSrcType()
  val fuType     = FuType()
  val fuOpType   = FuOpType()

  val rs1  = UInt(5.W)
  val rs2  = UInt(5.W)
  val rfWen = Bool()
  val rd   = UInt(5.W)
}

class DataSrc extends NPCBundle {
  val fuSrc1 = UInt(XLen.W)
  val fuSrc2 = UInt(XLen.W)
  val imm    = UInt(XLen.W)

  val Alu0Res       = Decoupled(UInt(XLen.W))
  val data_from_mem = UInt(XLen.W)
  val csrRdata      = UInt(XLen.W)
  val rfSrc1        = UInt(XLen.W)
  val rfSrc2        = UInt(XLen.W)
}

class DecodeIO extends NPCBundle {
  val cf   = new CtrlFlow
  val ctrl = new CtrlSignal
  val data = new DataSrc
}

// ---- ExuToWbuIO: includes cf/ctrl/data; matches "connect cf/ctrl/data first" ----
class ExuToWbuIO extends NPCBundle {
  val cf   = new CtrlFlow
  val ctrl = new CtrlSignal
  val data = new DataSrc
}

// ---- Memory interfaces (placeholders; adapt to your actual system) ----
class ToMem extends NPCBundle {
  val valid = Output(Bool())
  val addr  = Output(UInt(XLen.W))
  val wdata = Output(UInt(XLen.W))
  val wstrb = Output(UInt((XLen / 8).W))
  val wen   = Output(Bool())
}

class FromMem extends NPCBundle {
  val valid = Input(Bool())
  val rdata = Input(UInt(XLen.W))
}

// ---- Branch result bundle (as per prompt) ----
class BruRes extends NPCBundle {
  val valid    = Bool()
  val targetPc = UInt(XLen.W)
}

// ================================================================
// Handshake helper (as required by prompt)
// ================================================================
object HandShakeDeal {
  /**
    * Generic ready/valid routing for "single-stage pass-through".
    *
    * - Connects out.valid and in.ready with optional invalid/stop conditions.
    * - AnyInvalidCondition: forces out.valid low (drop)
    * - AnyStopCondition: forces in.ready low (stall)
    */
  def apply[T <: Data](
    in: DecoupledIO[T],
    out: DecoupledIO[_],
    AnyInvalidCondition: Bool,
    AnyStopCodition: Bool
  ): Unit = {
    out.valid := in.valid && !AnyInvalidCondition
    in.ready  := out.ready && !AnyStopCodition
  }
}

// ================================================================
// Functional Units (simple, synthesizable stubs; replace with yours)
// ================================================================

class AluIn extends NPCBundle {
  val srca     = UInt(XLen.W)
  val srcb     = UInt(XLen.W)
  val fuOpType = FuOpType()
}

class ALU extends NPCModule {
  val io = IO(new Bundle {
    val in  = Flipped(Decoupled(new AluIn))
    val out = Decoupled(UInt(XLen.W))
  })

  // Combinational execution, 1-cycle decoupled (valid passes through)
  io.in.ready := io.out.ready
  io.out.valid := io.in.valid

  val a = io.in.bits.srca
  val b = io.in.bits.srcb

  // Minimal op mapping; extend to match your FuOpType encoding
  io.out.bits := MuxLookup(io.in.bits.fuOpType, 0.U, Seq(
    0.U -> (a + b),
    1.U -> (a - b),
    2.U -> (a & b),
    3.U -> (a | b),
    4.U -> (a ^ b),
    5.U -> (a << b(5,0)),
    6.U -> (a >> b(5,0))
  ))
}

class LSU extends NPCModule {
  val io = IO(new Bundle {
    val in       = Flipped(Decoupled(new AluIn)) // reuse srca/srcb/fuOpType as address/data/op
    val ctrl     = Input(new CtrlSignal)
    val data     = Input(new DataSrc)
    val to_mem   = new ToMem
    val from_mem = new FromMem
    val out      = Decoupled(UInt(XLen.W)) // load data (or store "result"=0)
  })

  // Very simple: srca is address, srcb is store data.
  val addr = io.in.bits.srca
  val wdata = io.in.bits.srcb

  // Drive memory request when LSU instruction accepted
  io.in.ready := io.out.ready

  io.to_mem.valid := io.in.valid
  io.to_mem.addr  := addr
  io.to_mem.wdata := wdata
  io.to_mem.wstrb := Fill(XLen/8, 1.U(1.W))
  io.to_mem.wen   := io.ctrl.MemWrite

  // For loads, return from_mem.rdata when from_mem.valid, else 0.
  // This is a stub; real LSU would handle latency/queues.
  io.out.valid := io.in.valid
  io.out.bits  := Mux(io.ctrl.MemWrite, 0.U, io.from_mem.rdata)
}

class CSR extends NPCModule {
  val io = IO(new Bundle {
    val in  = Flipped(Decoupled(new AluIn)) // srca/srcb carry CSR operands; fuOpType encodes CSR op
    val out = Decoupled(UInt(XLen.W))
  })

  // Stub: just pass srca (pretend CSR read)
  io.in.ready  := io.out.ready
  io.out.valid := io.in.valid
  io.out.bits  := io.in.bits.srca
}

// ================================================================
// BRU result calculation (placeholder, per prompt API)
// ================================================================
object CalBruRes {
  /**
    * Produce branch/jump resolution.
    * Replace with your real branch/jump/ret logic.
    */
  def apply(inBits: DecodeIO, alu0: ALU, csr0: CSR): BruRes = {
    val res = Wire(new BruRes)
    res.valid := inBits.cf.isBranch
    // default target: pc + imm
    res.targetPc := inBits.cf.pc + inBits.data.imm
    res
  }
}

// ================================================================
// dut (as specified)
// ================================================================
class dut extends NPCModule {
  val io = IO(new Bundle {
    val from_isu = Flipped(Decoupled(new DecodeIO))
    val to_wbu   = Decoupled(new ExuToWbuIO)
    val to_mem   = new ToMem
    val from_mem = new FromMem
    val redirect = Output(new Redirect)
  })

  // -------------------------
  // 1) Output connection first
  // -------------------------
  io.to_wbu.bits.cf   := io.from_isu.bits.cf
  io.to_wbu.bits.ctrl := io.from_isu.bits.ctrl
  io.to_wbu.bits.data := io.from_isu.bits.data

  // Default: do not change predicted next_pc
  val correctedNextPc = WireDefault(io.from_isu.bits.cf.next_pc)

  // -------------------------
  // 2) Instantiate FUs and distribute
  // -------------------------
  val alu0 = Module(new ALU)
  val lsu0 = Module(new LSU)
  val csr0 = Module(new CSR)

  // Common in-bits for ALU/LSU/CSR
  alu0.io.in.bits.srca     := io.from_isu.bits.data.fuSrc1
  alu0.io.in.bits.srcb     := io.from_isu.bits.data.fuSrc2
  alu0.io.in.bits.fuOpType := io.from_isu.bits.ctrl.fuOpType

  lsu0.io.in.bits.srca     := io.from_isu.bits.data.fuSrc1
  lsu0.io.in.bits.srcb     := io.from_isu.bits.data.fuSrc2
  lsu0.io.in.bits.fuOpType := io.from_isu.bits.ctrl.fuOpType
  lsu0.io.ctrl             := io.from_isu.bits.ctrl
  lsu0.io.data             := io.from_isu.bits.data
  lsu0.io.from_mem         := io.from_mem

  csr0.io.in.bits.srca     := io.from_isu.bits.data.fuSrc1
  csr0.io.in.bits.srcb     := io.from_isu.bits.data.fuSrc2
  csr0.io.in.bits.fuOpType := io.from_isu.bits.ctrl.fuOpType

  // Valid qualification by fuType
  val isAlu = io.from_isu.bits.ctrl.fuType === FuType.alu
  val isLsu = io.from_isu.bits.ctrl.fuType === FuType.lsu
  val isCsr = io.from_isu.bits.ctrl.fuType === FuType.csr

  alu0.io.in.valid := io.from_isu.valid && isAlu
  lsu0.io.in.valid := io.from_isu.valid && isLsu
  csr0.io.in.valid := io.from_isu.valid && isCsr

  // Ready from WBU for selected FU only
  alu0.io.out.ready := io.to_wbu.ready && isAlu
  lsu0.io.out.ready := io.to_wbu.ready && isLsu
  csr0.io.out.ready := io.to_wbu.ready && isCsr

  // Collect FU results into to_wbu.bits.data.*
  io.to_wbu.bits.data.Alu0Res.bits  := alu0.io.out.bits
  io.to_wbu.bits.data.Alu0Res.valid := alu0.io.out.valid
  alu0.io.out.ready                := io.to_wbu.ready && isAlu

  io.to_wbu.bits.data.data_from_mem := lsu0.io.out.bits
  io.to_wbu.bits.data.csrRdata      := csr0.io.out.bits

  // LSU to_mem passthrough
  io.to_mem := lsu0.io.to_mem

  // If you don't want ISU's DataSrc to carry valid here, tie off safely when unused
  when(!isAlu) {
    io.to_wbu.bits.data.Alu0Res.valid := false.B
    io.to_wbu.bits.data.Alu0Res.bits  := 0.U
  }
  when(!isLsu) {
    io.to_wbu.bits.data.data_from_mem := 0.U
  }
  when(!isCsr) {
    io.to_wbu.bits.data.csrRdata := 0.U
  }

  // -------------------------
  // 3) Branch/jump processing and redirect
  // -------------------------
  val bruRes = Wire(new BruRes)
  bruRes := CalBruRes(io.from_isu.bits, alu0, csr0)

  val predErr = bruRes.valid && (io.from_isu.bits.cf.next_pc =/= bruRes.targetPc)

  io.redirect.valid  := io.from_isu.valid && bruRes.valid && predErr
  io.redirect.target := bruRes.targetPc

  when(predErr) {
    correctedNextPc := bruRes.targetPc
  }

  io.to_wbu.bits.cf.next_pc := correctedNextPc

  // -------------------------
  // 4) Handshake deal
  // - Stop condition: redirect.valid && in.valid (as required)
  // -------------------------
  val stopCond = io.redirect.valid && io.from_isu.valid

  // Select the actual producer valid for WBU based on FU type
  val fuOutValid = Mux1H(Seq(
    isAlu -> alu0.io.out.valid,
    isLsu -> lsu0.io.out.valid,
    isCsr -> csr0.io.out.valid
  )) || (!isAlu && !isLsu && !isCsr && io.from_isu.valid) // fallback for "no-fu" instructions

  // Drive to_wbu.valid using handshake helper, but override with FU-selected valid
  // (HandshakeDeal sets out.valid := in.valid; we want out.valid := fuOutValid)
  HandShakeDeal(io.from_isu, io.to_wbu, AnyInvalidCondition = false.B, AnyStopCodition = stopCond)
  io.to_wbu.valid := fuOutValid && !false.B

  // Feed back from_isu.ready: can accept only if selected FU is ready (or no-fu)
  val fuInReady = Mux1H(Seq(
    isAlu -> alu0.io.in.ready,
    isLsu -> lsu0.io.in.ready,
    isCsr -> csr0.io.in.ready
  )) || (!isAlu && !isLsu && !isCsr)

  io.from_isu.ready := io.to_wbu.ready && fuInReady && !stopCond
}
