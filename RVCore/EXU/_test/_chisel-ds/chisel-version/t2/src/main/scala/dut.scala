import chisel3._
import chisel3.util._

// Define the NPCBundle trait
trait NPCBundle extends Bundle with HasNPCParameter

// Define the NPCModule trait
trait NPCModule extends Module with HasNPCParameter

// Define the FuSrcType and FuType enumerations
object FuSrcType extends ChiselEnum {
  val Src1, Src2 = Value
}

object FuType extends ChiselEnum {
  val ALU, LSU, CSR = Value
}

object FuOpType extends ChiselEnum {
  val ADD, SUB, AND, OR, XOR, LOAD, STORE, CSR_READ, CSR_WRITE = Value
}

// Define the Redirect bundle
class Redirect extends NPCBundle {
  val target = UInt(XLen.W)
  val valid = Bool()
}

// Define the CtrlFlow bundle
class CtrlFlow extends NPCBundle {
  val inst = UInt(32.W)
  val pc = UInt(XLen.W)
  val next_pc = UInt(XLen.W)
  val isBranch = Bool()
}

// Define the CtrlSignal bundle
class CtrlSignal extends NPCBundle {
  val MemWrite = Bool()
  val ResSrc = UInt()
  val fuSrc1Type = FuSrcType()
  val fuSrc2Type = FuSrcType()
  val fuType = FuType()
  val fuOpType = FuOpType()
  val rs1 = UInt(5.W)
  val rs2 = UInt(5.W)
  val rfWen = Bool()
  val rd = UInt(5.W)
}

// Define the DataSrc bundle
class DataSrc extends NPCBundle {
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
class ToMem extends NPCBundle {
  val addr = UInt(XLen.W)
  val data = UInt(XLen.W)
  val MemWrite = Bool()
}

class FromMem extends NPCBundle {
  val data = UInt(XLen.W)
}

// Define the ALU module
class ALU extends Module {
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
class LSU extends Module {
  val io = IO(new Bundle {
    val from_mem = Flipped(Decoupled(new FromMem))
    val to_mem = Decoupled(new ToMem)
    val ctrl = new CtrlSignal
    val data = new DataSrc
    val out = Decoupled(UInt(XLen.W))
  })
  // LSU logic here (not implemented for brevity)
}

// Define the CSR module
class CSR extends Module {
  val io = IO(new Bundle {
    val in = Flipped(Decoupled(new Bundle {
      val csrOp = FuOpType()
      val csrAddr = UInt(12.W)
      val csrData = UInt(XLen.W)
    }))
    val out = Decoupled(UInt(XLen.W))
  })
  // CSR logic here (not implemented for brevity)
}

// Define the dut module
class dut extends Module {
  val io = IO(new Bundle {
    val from_isu = Flipped(Decoupled(new DecodeIO))
    val to_wbu = Decoupled(new ExuToWbuIO)
    val to_mem = new ToMem
    val from_mem = new FromMem
    val redirect = Output(new Redirect)
  })

  // Instantiate the functional units
  val alu0 = Module(new ALU)
  val lsu0 = Module(new LSU)
  val csr0 = Module(new CSR)

  // Connect the input signals to the functional units
  alu0.io.in.bits.srca := io.from_isu.bits.data.fuSrc1
  alu0.io.in.bits.srcb := io.from_isu.bits.data.fuSrc2
  alu0.io.in.bits.fuOpType := io.from_isu.bits.ctrl.fuOpType
  alu0.io.in.valid := io.from_isu.valid && (io.from_isu.bits.ctrl.fuType === FuType.ALU)
  alu0.io.out.ready := io.to_wbu.ready

  lsu0.io.from_mem <> io.from_mem
  lsu0.io.ctrl <> io.from_isu.bits.ctrl
  lsu0.io.data <> io.from_isu.bits.data
  lsu0.io.out.ready := io.to_wbu.ready

  csr0.io.in.bits.csrOp := io.from_isu.bits.ctrl.fuOpType
  csr0.io.in.bits.csrAddr := io.from_isu.bits.ctrl.rs1
  csr0.io.in.bits.csrData := io.from_isu.bits.data.fuSrc1
  csr0.io.in.valid := io.from_isu.valid && (io.from_isu.bits.ctrl.fuType === FuType.CSR)
  csr0.io.out.ready := io.to_wbu.ready

  // Connect the output signals from the functional units
  io.to_wbu.bits.data.Alu0Res.bits := alu0.io.out.bits
  io.to_wbu.bits.data.data_from_mem := lsu0.io.out.bits
  io.to_wbu.bits.data.csrRdata := csr0.io.out.bits
  io.to_mem <> lsu0.io.to_mem

  // Branch jump processing
  val bruRes = Wire(new Bundle {
    val valid = Bool()
    val targetPc = UInt(XLen.W)
  })
  bruRes := CalBruRes(io.from_isu.bits, alu0, csr0)

  // Generate redirection signal
  io.redirect.valid := io.from_isu.valid && bruRes.valid && (io.from_isu.bits.cf.next_pc =/= bruRes.targetPc)
  io.redirect.target := bruRes.targetPc

  // Update next_pc in the output
  when(io.redirect.valid) {
    io.to_wbu.bits.cf.next_pc := bruRes.targetPc
  }.otherwise {
    io.to_wbu.bits.cf.next_pc := io.from_isu.bits.cf.next_pc
  }

  // Handshake signal processing
  HandShakeDeal(io.from_isu, io.to_wbu,
    AnyInvalidCondition = false.B,
    AnyStopCondition = io.redirect.valid && io.from_isu.valid
  )

  // Function to calculate branch result (not implemented for brevity)
  def CalBruRes(in: DecodeIO, alu: ALU, csr: CSR): Bundle = {
    val res = Wire(new Bundle {
      val valid = Bool()
      val targetPc = UInt(XLen.W)
    })
    // Branch calculation logic here
    res
  }

  // Function to handle handshake signals (not implemented for brevity)
  def HandShakeDeal(in: DecoupledIO[DecodeIO], out: DecoupledIO[ExuToWbuIO],
                    AnyInvalidCondition: Bool, AnyStopCondition: Bool): Unit = {
    // Handshake logic here
  }
}
