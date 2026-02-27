import chisel3._
import chisel3.util._
import chisel3.experimental._

// Define the base bundles and traits
trait NPCParameter {
  val XLen: Int = 64
}

class NPCBundle extends Bundle with NPCParameter

class Redirect extends NPCBundle {
  val target = UInt(XLen.W)
  val valid = Bool()
}

class CtrlFlow extends NPCBundle {
  val inst = UInt(32.W)
  val pc = UInt(XLen.W)
  val next_pc = UInt(XLen.W)
  val isBranch = Bool()
}

class CtrlSignal extends NPCBundle {
  val MemWrite = Bool()
  val ResSrc = UInt(2.W)
  val fuSrc1Type = UInt(2.W)
  val fuSrc2Type = UInt(2.W)
  val fuType = UInt(3.W)
  val fuOpType = UInt(4.W)
  val rs1 = UInt(5.W)
  val rs2 = UInt(5.W)
  val rfWen = Bool()
  val rd = UInt(5.W)
}

class DataSrc extends NPCBundle {
  val fuSrc1 = UInt(XLen.W)
  val fuSrc2 = UInt(XLen.W)
  val imm = UInt(XLen.W)
  val Alu0Res = DecoupledIO(UInt(XLen.W))
  val data_from_mem = UInt(XLen.W)
  val csrRdata = UInt(XLen.W)
  val rfSrc1 = UInt(XLen.W)
  val rfSrc2 = UInt(XLen.W)
}

class DecodeIO extends NPCBundle {
  val cf = new CtrlFlow
  val ctrl = new CtrlSignal
  val data = new DataSrc
}

class ExuToWbuIO extends NPCBundle {
  val data = new DataSrc
  val cf = new CtrlFlow
  val ctrl = new CtrlSignal
}

class ToMem extends NPCBundle {
  val addr = UInt(XLen.W)
  val data = UInt(XLen.W)
  val valid = Bool()
}

class FromMem extends NPCBundle {
  val data = UInt(XLen.W)
  val valid = Bool()
}

// Define the functional unit modules (ALU, LSU, CSR)
class ALU extends Module {
  val io = IO(new Bundle {
    val in = Flipped(DecoupledIO(new Bundle {
      val srca = UInt(XLen.W)
      val srcb = UInt(XLen.W)
      val fuOpType = UInt(4.W)
    }))
    val out = DecoupledIO(UInt(XLen.W))
  })
  // ALU logic here (omitted for brevity)
}

class LSU extends Module {
  val io = IO(new Bundle {
    val from_mem = Flipped(new FromMem)
    val to_mem = new ToMem
    val in = Flipped(DecoupledIO(new Bundle {
      val addr = UInt(XLen.W)
      val data = UInt(XLen.W)
      val fuOpType = UInt(4.W)
    }))
    val out = DecoupledIO(UInt(XLen.W))
  })
  // LSU logic here (omitted for brevity)
}

class CSR extends Module {
  val io = IO(new Bundle {
    val in = Flipped(DecoupledIO(new Bundle {
      val addr = UInt(12.W)
      val data = UInt(XLen.W)
      val fuOpType = UInt(4.W)
    }))
    val out = DecoupledIO(UInt(XLen.W))
  })
  // CSR logic here (omitted for brevity)
}

// Main dut module
class dut extends Module with NPCParameter {
  val io = IO(new Bundle {
    val from_isu = Flipped(Decoupled(new DecodeIO))
    val to_wbu = Decoupled(new ExuToWbuIO)
    val to_mem = new ToMem
    val from_mem = new FromMem
    val redirect = Output(new Redirect)
  })

  // Instantiate functional units
  val alu0 = Module(new ALU)
  val lsu0 = Module(new LSU)
  val csr0 = Module(new CSR)

  // Connect from_isu to functional units
  alu0.io.in.bits.srca := io.from_isu.bits.data.fuSrc1
  alu0.io.in.bits.srcb := io.from_isu.bits.data.fuSrc2
  alu0.io.in.bits.fuOpType := io.from_isu.bits.ctrl.fuOpType
  alu0.io.in.valid := io.from_isu.valid && (io.from_isu.bits.ctrl.fuType === 0.U) // ALU type

  lsu0.io.in.bits.addr := io.from_isu.bits.data.fuSrc1
  lsu0.io.in.bits.data := io.from_isu.bits.data.fuSrc2
  lsu0.io.in.bits.fuOpType := io.from_isu.bits.ctrl.fuOpType
  lsu0.io.in.valid := io.from_isu.valid && (io.from_isu.bits.ctrl.fuType === 1.U) // LSU type

  csr0.io.in.bits.addr := io.from_isu.bits.data.fuSrc1
  csr0.io.in.bits.data := io.from_isu.bits.data.fuSrc2
  csr0.io.in.bits.fuOpType := io.from_isu.bits.ctrl.fuOpType
  csr0.io.in.valid := io.from_isu.valid && (io.from_isu.bits.ctrl.fuType === 2.U) // CSR type

  // Connect functional unit outputs to to_wbu
  io.to_wbu.bits.data.Alu0Res.bits := alu0.io.out.bits
  io.to_wbu.bits.data.data_from_mem := lsu0.io.out.bits
  io.to_wbu.bits.data.csrRdata := csr0.io.out.bits

  // Connect to_mem and from_mem
  io.to_mem <> lsu0.io.to_mem
  lsu0.io.from_mem <> io.from_mem

  // Branch jump processing
  val bruRes = Wire(new Bundle {
    val valid = Bool()
    val targetPc = UInt(XLen.W)
  })
  bruRes := CalBruRes(io.from_isu.bits, alu0, csr0)

  // Generate redirection signal
  io.redirect.valid := io.from_isu.valid && bruRes.valid && (io.from_isu.bits.cf.next_pc =/= bruRes.targetPc)
  io.redirect.target := bruRes.targetPc

  // Update next_pc in to_wbu
  io.to_wbu.bits.cf.next_pc := Mux(io.redirect.valid, bruRes.targetPc, io.from_isu.bits.cf.next_pc)

  // Handshake signal processing
  HandShakeDeal(io.from_isu, io.to_wbu, false.B, io.redirect.valid && io.from_isu.valid)

  // Helper function for branch resolution (dummy implementation)
  def CalBruRes(in: DecodeIO, alu: ALU, csr: CSR): Bundle = {
    val res = Wire(new Bundle {
      val valid = Bool()
      val targetPc = UInt(XLen.W)
    })
    // Logic to calculate branch resolution (omitted for brevity)
    res.valid := false.B
    res.targetPc := 0.U
    res
  }

  // Helper function for handshake signal processing
  def HandShakeDeal(in: DecoupledIO[DecodeIO], out: DecoupledIO[ExuToWbuIO], anyInvalidCondition: Bool, anyStopCondition: Bool): Unit = {
    in.ready := out.ready && !anyInvalidCondition && !anyStopCondition
    out.valid := in.valid && !anyInvalidCondition && !anyStopCondition
  }
}

// Top-level module
class Top extends Module with NPCParameter {
  val io = IO(new Bundle {
    val from_isu = Flipped(Decoupled(new DecodeIO))
    val to_wbu = Decoupled(new ExuToWbuIO)
    val to_mem = new ToMem
    val from_mem = new FromMem
    val redirect = Output(new Redirect)
  })
  val dutInst = Module(new dut)
  dutInst.io.from_isu <> io.from_isu
  dutInst.io.to_wbu <> io.to_wbu
  dutInst.io.to_mem <> io.to_mem
  dutInst.io.from_mem <> io.from_mem
  io.redirect <> dutInst.io.redirect
}

/*
object Main extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new Top, Array("--target-dir", "generated"))
}
*/
