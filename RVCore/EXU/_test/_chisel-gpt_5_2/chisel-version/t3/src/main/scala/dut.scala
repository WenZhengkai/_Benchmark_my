// package npc

import chisel3._
import chisel3.util._

// ------------------------------
// Minimal infrastructure / params
// ------------------------------
trait HasNPCParameter {
  val XLen: Int = 64
}

abstract class NPCBundle extends Bundle with HasNPCParameter
abstract class NPCModule extends Module with HasNPCParameter

// ------------------------------
// Enums / Types
// ------------------------------
object FuType extends ChiselEnum {
  val alu, lsu, csr = Value
}
object FuOpType extends ChiselEnum {
  // Placeholder opcodes (expand as needed)
  val add, sub, and, or, xor, sll, srl, sra, slt, sltu, pass = Value
}
object FuSrcType extends ChiselEnum {
  val reg, imm, pc, csr = Value
}

// ------------------------------
// Bundles (as described by user)
// ------------------------------
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
  val MemWrite   = Bool()
  val ResSrc     = UInt(2.W)

  val fuSrc1Type = FuSrcType()
  val fuSrc2Type = FuSrcType()
  val fuType     = FuType()
  val fuOpType   = FuOpType()
  val rs1        = UInt(5.W)
  val rs2        = UInt(5.W)
  val rfWen      = Bool()
  val rd         = UInt(5.W)
}

class DataSrc extends NPCBundle {
  val fuSrc1        = UInt(XLen.W)
  val fuSrc2        = UInt(XLen.W)
  val imm           = UInt(XLen.W)

  val Alu0Res       = Decoupled(UInt(XLen.W)) // driven by dut (to WBU)
  val data_from_mem = UInt(XLen.W)            // driven by dut (from LSU)
  val csrRdata      = UInt(XLen.W)            // driven by dut (from CSR)
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

// ------------------------------
// LSU <-> Mem placeholder bundles
// ------------------------------
class ToMem extends NPCBundle {
  val valid = Bool()
  val addr  = UInt(XLen.W)
  val wdata = UInt(XLen.W)
  val wen   = Bool()
  val wmask = UInt((XLen / 8).W)
}

class FromMem extends NPCBundle {
  val valid = Bool()
  val rdata = UInt(XLen.W)
}

// ------------------------------
// Branch result bundle
// ------------------------------
class BruRes extends NPCBundle {
  val valid    = Bool()
  val targetPc = UInt(XLen.W)
}

// ------------------------------
// Handshake helper
// ------------------------------
object HandShakeDeal {
  def apply(in: DecoupledIO[DecodeIO],
            out: DecoupledIO[ExuToWbuIO],
            AnyInvalidCondition: Bool,
            AnyStopCodition: Bool): Unit = {
    val stop = AnyStopCodition
    in.ready  := out.ready && !stop
    out.valid := in.valid && !AnyInvalidCondition && !stop
  }
}

// ------------------------------
// Simple ALU / CSR / LSU modules
// ------------------------------
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

  io.in.ready  := io.out.ready
  io.out.valid := io.in.valid

  val a = io.in.bits.srca
  val b = io.in.bits.srcb
  val shamt = b(log2Ceil(XLen) - 1, 0)

  val res = WireDefault(0.U(XLen.W))
  switch(io.in.bits.fuOpType) {
    is(FuOpType.add)  { res := a + b }
    is(FuOpType.sub)  { res := a - b }
    is(FuOpType.and)  { res := a & b }
    is(FuOpType.or)   { res := a | b }
    is(FuOpType.xor)  { res := a ^ b }
    is(FuOpType.sll)  { res := a << shamt }
    is(FuOpType.srl)  { res := a >> shamt }
    is(FuOpType.sra)  { res := (a.asSInt >> shamt).asUInt }
    is(FuOpType.slt)  { res := (a.asSInt < b.asSInt).asUInt }
    is(FuOpType.sltu) { res := (a < b).asUInt }
    is(FuOpType.pass) { res := a }
  }
  io.out.bits := res
}

class CSR extends NPCModule {
  val io = IO(new Bundle {
    val in   = Flipped(Decoupled(new AluIn)) // reuse: srca/srcb/op
    val out  = Decoupled(UInt(XLen.W))
  })

  io.in.ready  := io.out.ready
  io.out.valid := io.in.valid
  // Placeholder behavior: pass srca as "csr read"
  io.out.bits  := io.in.bits.srca
}

class LSU extends NPCModule {
  val io = IO(new Bundle {
    val from_mem = Input(new FromMem)
    val to_mem   = Output(new ToMem)

    val ctrl     = Input(new CtrlSignal)
    val data     = Input(new DataSrc)

    val in       = Flipped(Decoupled(new AluIn)) // addr/data/op placeholder
    val out      = Decoupled(UInt(XLen.W))       // load data
  })

  // Simplified: "addr" = srca + srcb (or srca), store data = data.rfSrc2
  val addr = io.in.bits.srca + io.in.bits.srcb

  io.to_mem.valid := io.in.valid && (io.ctrl.fuType === FuType.lsu)
  io.to_mem.addr  := addr
  io.to_mem.wdata := io.data.rfSrc2
  io.to_mem.wen   := io.ctrl.MemWrite
  io.to_mem.wmask := Fill(XLen / 8, 1.U(1.W))

  // Handshake: assume mem responds combinationally via from_mem.valid
  io.in.ready    := io.out.ready
  io.out.valid   := io.in.valid
  io.out.bits    := Mux(io.from_mem.valid, io.from_mem.rdata, 0.U)
}

// ------------------------------
// BRU result calculation (stub)
// ------------------------------
object CalBruRes {
  // Per spec: bruRes := CalBruRes(inBits, alu0, csr0)
  // Here we keep it conservative (no branch) unless isBranch is asserted.
  def apply(inBits: DecodeIO, alu0: ALU, csr0: CSR): BruRes = {
    val r = Wire(new BruRes)
    r.valid    := inBits.cf.isBranch
    // Use ALU result as target (common in simple cores: pc + imm computed by ALU)
    r.targetPc := alu0.io.out.bits
    r
  }
}

// ------------------------------
// dut
// ------------------------------
class dut extends NPCModule {
  val io = IO(new Bundle {
    val from_isu = Flipped(Decoupled(new DecodeIO))
    val to_wbu   = Decoupled(new ExuToWbuIO)
    val to_mem   = new ToMem
    val from_mem = new FromMem
    val redirect = Output(new Redirect)
  })

  // 1) Output connection: pass-through first
  io.to_wbu.bits.cf   := io.from_isu.bits.cf
  io.to_wbu.bits.ctrl := io.from_isu.bits.ctrl
  io.to_wbu.bits.data := io.from_isu.bits.data

  // Instantiate FUs
  val alu0 = Module(new ALU)
  val lsu0 = Module(new LSU)
  val csr0 = Module(new CSR)

  // Common operand wiring for ALU/CSR/LSU
  def driveFuIn(fuIn: DecoupledIO[AluIn]): Unit = {
    fuIn.bits.srca     := io.from_isu.bits.data.fuSrc1
    fuIn.bits.srcb     := io.from_isu.bits.data.fuSrc2
    fuIn.bits.fuOpType := io.from_isu.bits.ctrl.fuOpType
  }

  driveFuIn(alu0.io.in)
  driveFuIn(lsu0.io.in)
  driveFuIn(csr0.io.in)

  // Valid gating by fuType
  alu0.io.in.valid := io.from_isu.valid && (io.from_isu.bits.ctrl.fuType === FuType.alu)
  lsu0.io.in.valid := io.from_isu.valid && (io.from_isu.bits.ctrl.fuType === FuType.lsu)
  csr0.io.in.valid := io.from_isu.valid && (io.from_isu.bits.ctrl.fuType === FuType.csr)

  // Ready from WBU
  alu0.io.out.ready := io.to_wbu.ready
  lsu0.io.out.ready := io.to_wbu.ready
  csr0.io.out.ready := io.to_wbu.ready

  // LSU extra ports
  lsu0.io.from_mem := io.from_mem
  lsu0.io.ctrl     := io.from_isu.bits.ctrl
  lsu0.io.data     := io.from_isu.bits.data
  io.to_mem        := lsu0.io.to_mem

  // Drive results into to_wbu.data fields (Decoupled for ALU result)
  io.to_wbu.bits.data.Alu0Res.valid := alu0.io.out.valid
  io.to_wbu.bits.data.Alu0Res.bits  := alu0.io.out.bits
  io.to_wbu.bits.data.data_from_mem := lsu0.io.out.bits
  io.to_wbu.bits.data.csrRdata      := csr0.io.out.bits

  // Always ready to "accept" ALU result at WBU side (it is embedded in to_wbu)
  io.to_wbu.bits.data.Alu0Res.ready := io.to_wbu.ready

  // 3) Branch jump processing
  val bruRes = Wire(new BruRes)
  bruRes := CalBruRes(io.from_isu.bits, alu0, csr0)

  val predErr = bruRes.valid && (io.from_isu.bits.cf.next_pc =/= bruRes.targetPc)
  io.redirect.valid  := io.from_isu.valid && bruRes.valid && predErr
  io.redirect.target := bruRes.targetPc

  // Update next_pc for WBU (correct it on prediction error)
  when(io.redirect.valid) {
    io.to_wbu.bits.cf.next_pc := bruRes.targetPc
  }

  // 4) Handshake processing
  HandShakeDeal(
    io.from_isu,
    io.to_wbu,
    AnyInvalidCondition = false.B,
    AnyStopCodition     = io.redirect.valid && io.from_isu.valid
  )
}
