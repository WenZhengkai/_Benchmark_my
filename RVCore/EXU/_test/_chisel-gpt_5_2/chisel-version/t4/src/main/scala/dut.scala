// package npc.exu

import chisel3._
import chisel3.util._

/* -----------------------------------------------------------------------------
 * Minimal infrastructure (so this file is self-contained).
 * If your project already defines these, remove the duplicates and import yours.
 * ---------------------------------------------------------------------------*/

trait HasNPCParameter {
  val XLen: Int = 64
}

abstract class NPCModule extends Module with HasNPCParameter
abstract class NPCBundle extends Bundle with HasNPCParameter

object FuType extends ChiselEnum {
  val alu, lsu, csr, none = Value
}
object FuOpType extends ChiselEnum {
  val add, sub, and, or, xor, sll, srl, sra, slt, sltu, copyA, copyB = Value
}
object FuSrcType extends ChiselEnum {
  val rs, imm, pc, zero = Value
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

  // Results driven by EXU/FUs (kept as in your spec)
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

class Redirect extends NPCBundle {
  val target = UInt(XLen.W)
  val valid  = Bool()
}

class ExuToWbuIO extends NPCBundle {
  val cf   = new CtrlFlow
  val ctrl = new CtrlSignal
  val data = new DataSrc
}

class ToMem extends NPCBundle {
  // Placeholder; replace with your real mem request channel(s)
  val addr  = UInt(XLen.W)
  val wdata = UInt(XLen.W)
  val wen   = Bool()
  val valid = Bool()
  val ready = Bool()
}

class FromMem extends NPCBundle {
  // Placeholder; replace with your real mem response channel(s)
  val rdata = UInt(XLen.W)
  val valid = Bool()
}

/* -----------------------------------------------------------------------------
 * BRU result wrapper (given by your spec)
 * ---------------------------------------------------------------------------*/
class BruRes extends NPCBundle {
  val valid    = Bool()
  val targetPc = UInt(XLen.W)
}

/* -----------------------------------------------------------------------------
 * Handshake helper (as requested by the spec)
 * -----------------------------------------------------------------------------
 * This is a generic pass-through handshake controller:
 * - It drives in.ready based on out.ready and stop/invalid conditions.
 * - It drives out.valid based on in.valid and invalid conditions.
 */
object HandShakeDeal {
  def apply[T <: Data](
    in:  DecoupledIO[T],
    out: DecoupledIO[_],
    AnyInvalidCondition: Bool,
    AnyStopCodition:    Bool
  ): Unit = {
    // If we must stop, we don't accept new input and we don't present output valid.
    val allowFire = !AnyInvalidCondition && !AnyStopCodition
    in.ready  := out.ready && allowFire
    out.valid := in.valid && allowFire
  }
}

/* -----------------------------------------------------------------------------
 * Functional Units (minimal stubs; replace with your real modules)
 * ---------------------------------------------------------------------------*/
class AluIO extends NPCBundle {
  val in  = Flipped(Decoupled(new NPCBundle {
    val srca     = UInt(XLen.W)
    val srcb     = UInt(XLen.W)
    val fuOpType = FuOpType()
  }))
  val out = Decoupled(UInt(XLen.W))
}
class ALU extends NPCModule {
  val io = IO(new AluIO)

  // Combinational ALU (always-ready)
  io.in.ready := io.out.ready
  val res = Wire(UInt(XLen.W))
  res := 0.U
  switch(io.in.bits.fuOpType) {
    is(FuOpType.add)   { res := io.in.bits.srca + io.in.bits.srcb }
    is(FuOpType.sub)   { res := io.in.bits.srca - io.in.bits.srcb }
    is(FuOpType.and)   { res := io.in.bits.srca & io.in.bits.srcb }
    is(FuOpType.or)    { res := io.in.bits.srca | io.in.bits.srcb }
    is(FuOpType.xor)   { res := io.in.bits.srca ^ io.in.bits.srcb }
    is(FuOpType.sll)   { res := io.in.bits.srca << io.in.bits.srcb(5,0) }
    is(FuOpType.srl)   { res := io.in.bits.srca >> io.in.bits.srcb(5,0) }
    is(FuOpType.sra)   { res := (io.in.bits.srca.asSInt >> io.in.bits.srcb(5,0)).asUInt }
    is(FuOpType.slt)   { res := (io.in.bits.srca.asSInt < io.in.bits.srcb.asSInt).asUInt }
    is(FuOpType.sltu)  { res := (io.in.bits.srca < io.in.bits.srcb).asUInt }
    is(FuOpType.copyA) { res := io.in.bits.srca }
    is(FuOpType.copyB) { res := io.in.bits.srcb }
  }

  io.out.bits  := res
  io.out.valid := io.in.valid
}

class LsuIO extends NPCBundle {
  val ctrl     = Input(new CtrlSignal)
  val data     = Input(new DataSrc)
  val from_mem = Input(new FromMem)
  val to_mem   = Output(new ToMem)

  val out      = Decoupled(UInt(XLen.W)) // load data result (or 0 for stores)
}
class LSU extends NPCModule {
  val io = IO(new LsuIO)

  // Very simple placeholder LSU:
  // - always issues a "request" when selected
  // - returns from_mem.rdata when from_mem.valid
  io.to_mem.addr  := io.data.fuSrc1
  io.to_mem.wdata := io.data.fuSrc2
  io.to_mem.wen   := io.ctrl.MemWrite
  io.to_mem.valid := io.out.valid
  io.to_mem.ready := io.out.ready

  io.out.bits  := io.from_mem.rdata
  io.out.valid := io.from_mem.valid
}

class CsrIO extends NPCBundle {
  val in  = Flipped(Decoupled(new NPCBundle {
    val srca     = UInt(XLen.W)
    val srcb     = UInt(XLen.W)
    val fuOpType = FuOpType()
    val inst     = UInt(32.W)
    val pc       = UInt(XLen.W)
  }))
  val out = Decoupled(UInt(XLen.W))
}
class CSR extends NPCModule {
  val io = IO(new CsrIO)
  io.in.ready := io.out.ready
  // Placeholder: just return srca
  io.out.bits  := io.in.bits.srca
  io.out.valid := io.in.valid
}

/* -----------------------------------------------------------------------------
 * BRU computation hook (requested by your spec).
 * Replace logic with your real branch/jump decode + target calculation.
 * ---------------------------------------------------------------------------*/
object CalBruRes {
  def apply(in: DecodeIO, alu0: ALU, csr0: CSR): BruRes = {
    val r = Wire(new BruRes)
    // Placeholder behavior:
    // Treat isBranch as "a branch/jump is present" and use ALU output as computed target.
    // In a real design, you'd decode inst for jal/jalr/branch and compute accordingly.
    r.valid    := in.cf.isBranch
    r.targetPc := alu0.io.out.bits
    r
  }
}

/* -----------------------------------------------------------------------------
 * dut
 * ---------------------------------------------------------------------------*/
class dut extends NPCModule {
  val io = IO(new Bundle {
    val from_isu = Flipped(Decoupled(new DecodeIO))
    val to_wbu   = Decoupled(new ExuToWbuIO)
    val to_mem   = new ToMem
    val from_mem = new FromMem
    val redirect = Output(new Redirect)
  })

  /* 1) Output connection: connect cf/ctrl/data first */
  io.to_wbu.bits.cf   := io.from_isu.bits.cf
  io.to_wbu.bits.ctrl := io.from_isu.bits.ctrl
  io.to_wbu.bits.data := io.from_isu.bits.data

  // Default: no redirect
  io.redirect.valid  := false.B
  io.redirect.target := 0.U

  /* 2) Instantiate and wire functional units */
  val alu0 = Module(new ALU)
  val lsu0 = Module(new LSU)
  val csr0 = Module(new CSR)

  // Common input operands/op
  alu0.io.in.bits.srca     := io.from_isu.bits.data.fuSrc1
  alu0.io.in.bits.srcb     := io.from_isu.bits.data.fuSrc2
  alu0.io.in.bits.fuOpType := io.from_isu.bits.ctrl.fuOpType
  alu0.io.out.ready        := io.to_wbu.ready
  alu0.io.in.valid         := io.from_isu.valid && (io.from_isu.bits.ctrl.fuType === FuType.alu)

  // LSU wiring
  lsu0.io.from_mem := io.from_mem
  lsu0.io.ctrl     := io.from_isu.bits.ctrl
  lsu0.io.data     := io.from_isu.bits.data
  lsu0.io.out.ready := io.to_wbu.ready
  io.to_mem        := lsu0.io.to_mem

  // CSR wiring
  csr0.io.in.bits.srca     := io.from_isu.bits.data.fuSrc1
  csr0.io.in.bits.srcb     := io.from_isu.bits.data.fuSrc2
  csr0.io.in.bits.fuOpType := io.from_isu.bits.ctrl.fuOpType
  csr0.io.in.bits.inst     := io.from_isu.bits.cf.inst
  csr0.io.in.bits.pc       := io.from_isu.bits.cf.pc
  csr0.io.out.ready        := io.to_wbu.ready
  csr0.io.in.valid         := io.from_isu.valid && (io.from_isu.bits.ctrl.fuType === FuType.csr)

  // Select FU output into WBU payload
  // Drive DataSrc result fields (including the Decoupled Alu0Res subfield)
  io.to_wbu.bits.data.Alu0Res.bits  := alu0.io.out.bits
  io.to_wbu.bits.data.Alu0Res.valid := alu0.io.out.valid
  alu0.io.out.ready                 := io.to_wbu.ready

  io.to_wbu.bits.data.data_from_mem := lsu0.io.out.bits
  io.to_wbu.bits.data.csrRdata      := csr0.io.out.bits

  // Ensure the embedded Alu0Res ready is driven (consumer is WBU)
  io.to_wbu.bits.data.Alu0Res.ready := io.to_wbu.ready

  /* 3) Branch jump processing */
  val bruRes = Wire(new BruRes)
  bruRes := CalBruRes(io.from_isu.bits, alu0, csr0)

  val predErr = bruRes.valid && (io.from_isu.bits.cf.next_pc =/= bruRes.targetPc)
  io.redirect.valid  := io.from_isu.valid && bruRes.valid && predErr
  io.redirect.target := bruRes.targetPc

  // Update next_pc in output cf if mispredict
  when(io.redirect.valid) {
    io.to_wbu.bits.cf.next_pc := bruRes.targetPc
  }

  /* 4) Handshake signal processing */
  HandShakeDeal(
    io.from_isu,
    io.to_wbu,
    AnyInvalidCondition = false.B,
    AnyStopCodition     = io.redirect.valid && io.from_isu.valid
  )

  // Additionally, only one FU should be considered producing the architecturally-selected result.
  // WBU valid is governed by HandShakeDeal; here we gate FU valids by fuType for cleanliness.
  val isAlu = io.from_isu.bits.ctrl.fuType === FuType.alu
  val isLsu = io.from_isu.bits.ctrl.fuType === FuType.lsu
  val isCsr = io.from_isu.bits.ctrl.fuType === FuType.csr

  // Gate sub-results
  io.to_wbu.bits.data.Alu0Res.valid := io.to_wbu.valid && isAlu && alu0.io.out.valid
  // For LSU/CSR simple placeholders:
  // - lsu0.io.out.valid comes from from_mem.valid; gate by isLsu
  // - csr0.io.out.valid equals csr0.io.in.valid; gate by isCsr
  // The data fields are still driven; WBU should use ctrl.ResSrc / fuType to select.
  when(!isLsu) { io.to_wbu.bits.data.data_from_mem := 0.U }
  when(!isCsr) { io.to_wbu.bits.data.csrRdata      := 0.U }

  // LSU valid participation (not explicitly in DataSrc as Decoupled); WBU uses io.to_wbu.valid.
  // If you want WBU to only see valid when LSU response returns, you must stall here.
  // This placeholder does not stall; integrate your real LSU handshake if needed.
}

