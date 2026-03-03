// package npc.core

import chisel3._
import chisel3.util._

/** --------------------------
  * Minimal infrastructure
  * -------------------------- */
trait HasNPCParameter {
  val XLen: Int = 64
}

abstract class NPCBundle extends Bundle with HasNPCParameter
abstract class NPCModule extends Module with HasNPCParameter

/** --------------------------
  * Enums / Types (placeholders)
  * -------------------------- */
object FuType extends ChiselEnum {
  val alu, lsu, csr, none = Value
}
object FuSrcType extends ChiselEnum {
  val reg, imm, pc, none = Value
}
object FuOpType extends ChiselEnum {
  val add, sub, and_, or_, xor_, sll, srl, sra, slt, sltu,
      load, store,
      csrrw, csrrs, csrrc,
      jal, jalr, beq, bne, blt, bge, bltu, bgeu,
      none = Value
}

/** --------------------------
  * I/O bundles (per spec)
  * -------------------------- */
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

  // "this module needs to get alu to driver" => dut drives these
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

class ExuToWbuIO extends NPCBundle {
  val cf   = new CtrlFlow
  val ctrl = new CtrlSignal
  val data = new DataSrc
}

class BruRes extends NPCBundle {
  val valid    = Bool()
  val targetPc = UInt(XLen.W)
}

/** --------------------------
  * Memory interface placeholders
  * -------------------------- */
class ToMem extends NPCBundle {
  val addr  = UInt(XLen.W)
  val wdata = UInt(XLen.W)
  val wen   = Bool()
  val ren   = Bool()
  val mask  = UInt((XLen / 8).W)
}

class FromMem extends NPCBundle {
  val rdata = UInt(XLen.W)
  val valid = Bool()
}

/** --------------------------
  * Handshake helper (per spec)
  * -------------------------- */
object HandShakeDeal {
  /** A simple "in.fire => out.valid" pass-through handshake controller.
    * AnyStopCondition can be used to stall acceptance from input.
    *
    * This function only assigns ready/valid. Data wiring is done outside.
    */
  def apply(
    in: DecoupledIO[DecodeIO],
    out: DecoupledIO[ExuToWbuIO],
    AnyInvalidCondition: Bool,
    AnyStopCodition: Bool
  ): Unit = {
    val canProceed = !AnyInvalidCondition && !AnyStopCodition
    in.ready  := out.ready && canProceed
    out.valid := in.valid && canProceed
  }
}

/** --------------------------
  * ALU (Decoupled in/out)
  * -------------------------- */
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

  // Combinational ALU; out.valid follows in.valid; ready backpressure via in.ready.
  io.in.ready := io.out.ready
  io.out.valid := io.in.valid

  val a = io.in.bits.srca
  val b = io.in.bits.srcb
  val shamt = b(5, 0)

  val res = WireDefault(0.U(XLen.W))
  switch(io.in.bits.fuOpType) {
    is(FuOpType.add)  { res := a + b }
    is(FuOpType.sub)  { res := a - b }
    is(FuOpType.and_) { res := a & b }
    is(FuOpType.or_)  { res := a | b }
    is(FuOpType.xor_) { res := a ^ b }
    is(FuOpType.sll)  { res := a << shamt }
    is(FuOpType.srl)  { res := a >> shamt }
    is(FuOpType.sra)  { res := (a.asSInt >> shamt).asUInt }
    is(FuOpType.slt)  { res := (a.asSInt < b.asSInt).asUInt }
    is(FuOpType.sltu) { res := (a < b).asUInt }
  }
  io.out.bits := res
}

/** --------------------------
  * LSU (Decoupled in/out) + memory ports
  * -------------------------- */
class LsuOut extends NPCBundle {
  val rdata = UInt(XLen.W)
}
class Lsu extends NPCModule {
  val io = IO(new Bundle {
    val ctrl     = Input(new CtrlSignal)
    val data     = Input(new DataSrc)

    val from_mem = Input(new FromMem)
    val to_mem   = Output(new ToMem)

    val in       = Flipped(Decoupled(Bool())) // just a token for handshake
    val out      = Decoupled(new LsuOut)
  })

  // Very simplified: drive memory request combinationally from ctrl/data.
  val isStore = io.ctrl.MemWrite
  val isLoad  = (io.ctrl.fuOpType === FuOpType.load) && !isStore

  io.to_mem.addr  := io.data.fuSrc1
  io.to_mem.wdata := io.data.fuSrc2
  io.to_mem.wen   := io.in.valid && isStore
  io.to_mem.ren   := io.in.valid && isLoad
  io.to_mem.mask  := Fill(XLen / 8, 1.U(1.W))

  // handshake: accept token when consumer ready
  io.in.ready := io.out.ready

  io.out.valid := io.in.valid
  io.out.bits.rdata := io.from_mem.rdata
}

/** --------------------------
  * CSR (Decoupled in/out)
  * -------------------------- */
class CsrIn extends NPCBundle {
  val srca     = UInt(XLen.W)
  val srcb     = UInt(XLen.W)
  val fuOpType = FuOpType()
  val imm      = UInt(XLen.W)
  val pc       = UInt(XLen.W)
}
class Csr extends NPCModule {
  val io = IO(new Bundle {
    val in  = Flipped(Decoupled(new CsrIn))
    val out = Decoupled(UInt(XLen.W))
  })

  io.in.ready  := io.out.ready
  io.out.valid := io.in.valid

  // Placeholder CSR read data behavior (not a real CSR file)
  io.out.bits := io.in.bits.srca // return something deterministic
}

/** --------------------------
  * BRU result calculator (per spec: CalBruRes(inBits, alu0, csr0))
  * -------------------------- */
object CalBruRes {
  def apply(inBits: DecodeIO, alu0: Alu, csr0: Csr): BruRes = {
    val bru = Wire(new BruRes)
    bru.valid := false.B
    bru.targetPc := 0.U

    // Minimal branch/jump target computation based on fuOpType.
    val pc   = inBits.cf.pc
    val imm  = inBits.data.imm
    val rs1  = inBits.data.fuSrc1
    val rs2  = inBits.data.fuSrc2

    val isBruOp = inBits.cf.isBranch ||
      (inBits.ctrl.fuOpType === FuOpType.jal)  ||
      (inBits.ctrl.fuOpType === FuOpType.jalr) ||
      (inBits.ctrl.fuOpType === FuOpType.beq)  ||
      (inBits.ctrl.fuOpType === FuOpType.bne)  ||
      (inBits.ctrl.fuOpType === FuOpType.blt)  ||
      (inBits.ctrl.fuOpType === FuOpType.bge)  ||
      (inBits.ctrl.fuOpType === FuOpType.bltu) ||
      (inBits.ctrl.fuOpType === FuOpType.bgeu)

    val taken = WireDefault(false.B)
    switch(inBits.ctrl.fuOpType) {
      is(FuOpType.jal)  { taken := true.B }
      is(FuOpType.jalr) { taken := true.B }
      is(FuOpType.beq)  { taken := (rs1 === rs2) }
      is(FuOpType.bne)  { taken := (rs1 =/= rs2) }
      is(FuOpType.blt)  { taken := (rs1.asSInt < rs2.asSInt) }
      is(FuOpType.bge)  { taken := (rs1.asSInt >= rs2.asSInt) }
      is(FuOpType.bltu) { taken := (rs1 < rs2) }
      is(FuOpType.bgeu) { taken := (rs1 >= rs2) }
    }

    val target = WireDefault(inBits.cf.next_pc)
    when(inBits.ctrl.fuOpType === FuOpType.jal) {
      target := pc + imm
    }.elsewhen(inBits.ctrl.fuOpType === FuOpType.jalr) {
      target := (rs1 + imm) & (~1.U(XLen.W))
    }.otherwise {
      // conditional branches
      target := Mux(taken, pc + imm, pc + 4.U)
    }

    bru.valid    := isBruOp
    bru.targetPc := target
    bru
  }
}

/** --------------------------
  * dut module (per spec)
  * -------------------------- */
class dut extends NPCModule {
  val io = IO(new Bundle {
    val from_isu = Flipped(Decoupled(new DecodeIO))
    val to_wbu   = Decoupled(new ExuToWbuIO)
    val to_mem   = new ToMem
    val from_mem = new FromMem
    val redirect = Output(new Redirect)
  })

  /** 1) Output connection: connect cf/ctrl/data first */
  io.to_wbu.bits.cf   := io.from_isu.bits.cf
  io.to_wbu.bits.ctrl := io.from_isu.bits.ctrl
  io.to_wbu.bits.data := io.from_isu.bits.data

  /** 2) Instantiate functional units and wire */
  val alu0 = Module(new Alu)
  val lsu0 = Module(new Lsu)
  val csr0 = Module(new Csr)

  // Defaults for internal decoupled outputs inside DataSrc that dut must drive
  io.to_wbu.bits.data.Alu0Res.valid := false.B
  io.to_wbu.bits.data.Alu0Res.bits  := 0.U

  // ALU wiring
  alu0.io.in.bits.srca     := io.from_isu.bits.data.fuSrc1
  alu0.io.in.bits.srcb     := io.from_isu.bits.data.fuSrc2
  alu0.io.in.bits.fuOpType := io.from_isu.bits.ctrl.fuOpType
  alu0.io.out.ready        := io.to_wbu.ready
  alu0.io.in.valid         := io.from_isu.valid && (io.from_isu.bits.ctrl.fuType === FuType.alu)

  // Expose ALU result through DataSrc.Alu0Res (as requested)
  io.to_wbu.bits.data.Alu0Res.valid := alu0.io.out.valid
  io.to_wbu.bits.data.Alu0Res.bits  := alu0.io.out.bits

  // LSU wiring
  lsu0.io.from_mem := io.from_mem
  lsu0.io.ctrl     := io.from_isu.bits.ctrl
  lsu0.io.data     := io.from_isu.bits.data
  lsu0.io.out.ready := io.to_wbu.ready
  lsu0.io.in.valid  := io.from_isu.valid && (io.from_isu.bits.ctrl.fuType === FuType.lsu)
  lsu0.io.in.bits   := true.B

  io.to_mem := lsu0.io.to_mem
  io.to_wbu.bits.data.data_from_mem := lsu0.io.out.bits.rdata

  // CSR wiring
  csr0.io.in.bits.srca     := io.from_isu.bits.data.fuSrc1
  csr0.io.in.bits.srcb     := io.from_isu.bits.data.fuSrc2
  csr0.io.in.bits.imm      := io.from_isu.bits.data.imm
  csr0.io.in.bits.pc       := io.from_isu.bits.cf.pc
  csr0.io.in.bits.fuOpType := io.from_isu.bits.ctrl.fuOpType
  csr0.io.out.ready        := io.to_wbu.ready
  csr0.io.in.valid         := io.from_isu.valid && (io.from_isu.bits.ctrl.fuType === FuType.csr)

  io.to_wbu.bits.data.csrRdata := csr0.io.out.bits

  /** 3) Branch/jump processing */
  val bruRes = Wire(new BruRes)
  bruRes := CalBruRes(io.from_isu.bits, alu0, csr0)

  val predErr = bruRes.valid && (io.from_isu.bits.cf.next_pc =/= bruRes.targetPc)

  io.redirect.valid  := io.from_isu.valid && bruRes.valid && predErr
  io.redirect.target := bruRes.targetPc

  // Update out.bits.cf.next_pc to correct target when mispredict
  when(io.redirect.valid) {
    io.to_wbu.bits.cf.next_pc := bruRes.targetPc
  }

  /** 4) Handshake signal processing */
  HandShakeDeal(
    io.from_isu,
    io.to_wbu,
    AnyInvalidCondition = false.B,
    AnyStopCodition     = io.redirect.valid && io.from_isu.valid
  )
}
