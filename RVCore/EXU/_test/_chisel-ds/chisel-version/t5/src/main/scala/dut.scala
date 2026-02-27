import chisel3._
import chisel3.util._
import chisel3.experimental._

// Define the base NPCBundle and NPCModule
abstract class NPCBundle extends Bundle
abstract class NPCModule extends Module

// Define the HasNPCParameter trait
trait HasNPCParameter {
  val XLen = 64
}

// Define the FuType and FuOpType enums
object FuType extends ChiselEnum {
  val alu, lsu, csr = Value
}

object FuOpType extends ChiselEnum {
  val add, sub, and, or, xor, sll, srl, sra = Value
}

// Define the Redirect bundle
class Redirect extends NPCBundle with HasNPCParameter {
  val target = UInt(XLen.W)
  val valid = Bool()
}

// Define the CtrlFlow bundle
class CtrlFlow extends NPCBundle with HasNPCParameter {
  val inst = UInt(32.W)
  val pc = UInt(XLen.W)
  val next_pc = UInt(XLen.W)
  val isBranch = Bool()
}

// Define the CtrlSignal bundle
class CtrlSignal extends NPCBundle {
  val MemWrite = Bool()
  val ResSrc = UInt(2.W)
  val fuSrc1Type = UInt(2.W)
  val fuSrc2Type = UInt(2.W)
  val fuType = FuType()
  val fuOpType = FuOpType()
  val rs1 = UInt(5.W)
  val rs2 = UInt(5.W)
  val rfWen = Bool()
  val rd = UInt(5.W)
}

// Define the DataSrc bundle
class DataSrc extends NPCBundle with HasNPCParameter {
  val fuSrc1 = UInt(XLen.W)
  val fuSrc2 = UInt(XLen.W)
  val imm = UInt(XLen.W)
  val Alu0Res = Decoupled(UInt(XLen.W))
  val data_from_mem = UInt(XLen.W)
  val csrRdata = UInt(XLen.W)
  val rfSrc1 = UInt(XLen.W)
  val rfSrc2 = UInt(XLen.W)
}

// Define the DecodeIO bundle
class DecodeIO extends NPCBundle {
  val cf = new CtrlFlow
  val ctrl = new CtrlSignal
  val data = new DataSrc
}

// Define the ExuToWbuIO bundle
class ExuToWbuIO extends NPCBundle {
  val data = new DataSrc
  val cf = new CtrlFlow
  val ctrl = new CtrlSignal
}

// Define the ToMem and FromMem bundles
class ToMem extends NPCBundle with HasNPCParameter {
  val addr = UInt(XLen.W)
  val data = UInt(XLen.W)
  val valid = Bool()
}

class FromMem extends NPCBundle with HasNPCParameter {
  val data = UInt(XLen.W)
  val valid = Bool()
}

// Define the ALU module
class ALU extends NPCModule with HasNPCParameter {
  val io = IO(new Bundle {
    val in = Flipped(Decoupled(new Bundle {
      val srca = UInt(XLen.W)
      val srcb = UInt(XLen.W)
      val fuOpType = FuOpType()
    }))
    val out = Decoupled(UInt(XLen.W))
  })
  // ALU logic here (not implemented for brevity)
}

// Define the LSU module
class LSU extends NPCModule with HasNPCParameter {
  val io = IO(new Bundle {
    val in = Flipped(Decoupled(new Bundle {
      val addr = UInt(XLen.W)
      val data = UInt(XLen.W)
      val fuOpType = FuOpType()
    }))
    val out = Decoupled(UInt(XLen.W))
    val to_mem = new ToMem
    val from_mem = Flipped(new FromMem)
  })
  // LSU logic here (not implemented for brevity)
}

// Define the CSR module
class CSR extends NPCModule with HasNPCParameter {
  val io = IO(new Bundle {
    val in = Flipped(Decoupled(new Bundle {
      val addr = UInt(12.W)
      val data = UInt(XLen.W)
      val fuOpType = FuOpType()
    }))
    val out = Decoupled(UInt(XLen.W))
  })
  // CSR logic here (not implemented for brevity)
}

// Define the dut module
class dut extends NPCModule with HasNPCParameter {
  val io = IO(new Bundle {
    val from_isu = Flipped(Decoupled(new DecodeIO))
    val to_wbu = Decoupled(new ExuToWbuIO)
    val to_mem = new ToMem
    val from_mem = Flipped(new FromMem)
    val redirect = Output(new Redirect)
  })

  // Instantiate ALU, LSU, and CSR modules
  val alu0 = Module(new ALU)
  val lsu0 = Module(new LSU)
  val csr0 = Module(new CSR)

  // Connect from_isu to to_wbu
  io.to_wbu.bits.cf := io.from_isu.bits.cf
  io.to_wbu.bits.ctrl := io.from_isu.bits.ctrl
  io.to_wbu.bits.data := io.from_isu.bits.data

  // Connect ALU
  alu0.io.in.bits.srca := io.from_isu.bits.data.fuSrc1
  alu0.io.in.bits.srcb := io.from_isu.bits.data.fuSrc2
  alu0.io.in.bits.fuOpType := io.from_isu.bits.ctrl.fuOpType
  alu0.io.in.valid := io.from_isu.valid && (io.from_isu.bits.ctrl.fuType === FuType.alu)
  alu0.io.out.ready := io.to_wbu.ready
  io.to_wbu.bits.data.Alu0Res.bits := alu0.io.out.bits

  // Connect LSU
  lsu0.io.in.bits.addr := io.from_isu.bits.data.fuSrc1
  lsu0.io.in.bits.data := io.from_isu.bits.data.fuSrc2
  lsu0.io.in.bits.fuOpType := io.from_isu.bits.ctrl.fuOpType
  lsu0.io.in.valid := io.from_isu.valid && (io.from_isu.bits.ctrl.fuType === FuType.lsu)
  lsu0.io.out.ready := io.to_wbu.ready
  io.to_wbu.bits.data.data_from_mem := lsu0.io.out.bits
  io.to_mem <> lsu0.io.to_mem
  lsu0.io.from_mem <> io.from_mem

  // Connect CSR
  csr0.io.in.bits.addr := io.from_isu.bits.data.fuSrc1
  csr0.io.in.bits.data := io.from_isu.bits.data.fuSrc2
  csr0.io.in.bits.fuOpType := io.from_isu.bits.ctrl.fuOpType
  csr0.io.in.valid := io.from_isu.valid && (io.from_isu.bits.ctrl.fuType === FuType.csr)
  csr0.io.out.ready := io.to_wbu.ready
  io.to_wbu.bits.data.csrRdata := csr0.io.out.bits

  // Branch jump processing
  val bruRes = Wire(new Bundle {
    val valid = Bool()
    val targetPc = UInt(XLen.W)
  })
  bruRes := CalBruRes(io.from_isu.bits, alu0, csr0)

  // Generate redirection signal
  io.redirect.valid := io.from_isu.valid && bruRes.valid && (io.from_isu.bits.cf.next_pc =/= bruRes.targetPc)
  io.redirect.target := bruRes.targetPc

  // Update next_pc
  io.to_wbu.bits.cf.next_pc := Mux(io.redirect.valid, bruRes.targetPc, io.from_isu.bits.cf.next_pc)

  // Handshake signal processing
  HandShakeDeal(io.from_isu, io.to_wbu,
    AnyInvalidCondition = false.B,
    AnyStopCondition = io.redirect.valid && io.from_isu.valid
  )

  // Helper function for branch resolution (not implemented for brevity)
  def CalBruRes(in: DecodeIO, alu: ALU, csr: CSR): Bundle = {
    val res = Wire(new Bundle {
      val valid = Bool()
      val targetPc = UInt(XLen.W)
    })
    // Logic to calculate branch resolution
    res.valid := false.B
    res.targetPc := 0.U
    res
  }

  // Helper function for handshake signal processing
  def HandShakeDeal(in: DecoupledIO[DecodeIO], out: DecoupledIO[ExuToWbuIO], AnyInvalidCondition: Bool, AnyStopCondition: Bool): Unit = {
    in.ready := out.ready && !AnyInvalidCondition && !AnyStopCondition
    out.valid := in.valid && !AnyInvalidCondition && !AnyStopCondition
  }
}
