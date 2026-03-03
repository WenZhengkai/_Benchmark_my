import chisel3._
import chisel3.util._
import scala.annotation.switch

object SignExt {
  def apply(a: UInt, len: Int) = {
    val aLen = a.getWidth
    val signBit = a(aLen-1)
    if (aLen >= len) a(len-1,0) else Cat(Fill(len - aLen, signBit), a)
  }
}

object ZeroExt {
  def apply(a: UInt, len: Int) = {
    val aLen = a.getWidth
    if (aLen >= len) a(len-1,0) else Cat(0.U((len - aLen).W), a)
  }
}

object ALUOpType{
    def add  = "b1000000".U
    def sll  = "b0000001".U
    def slt  = "b0000010".U
    def sltu = "b0000011".U
    def xor  = "b0000100".U
    def srl  = "b0000101".U
    def or   = "b0000110".U
    def and  = "b0000111".U
    def sub  = "b0001000".U
    def sra  = "b0001101".U

    def addw = "b1100000".U
    def subw = "b0101000".U
    def sllw = "b0100001".U
    def srlw = "b0100101".U
    def sraw = "b0101101".U

    def isWordOp(func: UInt) = func(5)

    def jal  = "b1011000".U
    def jalr = "b1011010".U
    def beq  = "b0010000".U
    def bne  = "b0010001".U
    def blt  = "b0010100".U
    def bge  = "b0010101".U
    def bltu = "b0010110".U
    def bgeu = "b0010111".U

    // for RAS
    def call = "b1011100".U
    def ret  = "b1011110".U

    def isAdd(func: UInt) = func(6)
    def pcPlus2(func: UInt) = func(5)
    def isBru(func: UInt) = func(4)
    def isBranch(func: UInt) = !func(3)
    def isJump(func: UInt) = isBru(func) && !isBranch(func)
    def getBranchType(func: UInt) = func(2, 1)
    def isBranchInvert(func: UInt) = func(0)
}

class FunctionUnitOut extends NPCBundle {
    val out = Decoupled(UInt(XLen.W))
}

class FunctionUnitIO extends FunctionUnitOut {
    val in = Flipped(Decoupled(new Bundle {
        val srca = Output(UInt(XLen.W))
        val srcb = Output(UInt(XLen.W))
        val fuOpType = Output(FuOpType())
    }))
    
}

class ALUIO extends FunctionUnitIO {
    val taken = Output(Bool())      // if Branch Taken
}

class ALU extends NPCModule {
    val io = IO(new ALUIO)

    val srca = io.in.bits.srca
    val srcb = io.in.bits.srcb
    val fuOpType = io.in.bits.fuOpType
    val aluRes = WireDefault(0.U)

    io.in.ready := true.B
    io.out.valid := io.in.valid

    io.out.bits := aluRes


    val isAdderSub = !ALUOpType.isAdd(fuOpType)
    val adderRes = (srca +& (srcb ^ Fill(XLen, isAdderSub))) + isAdderSub
    val xorRes = srca ^ srcb
    val sltu = !adderRes(XLen)
    val slt = xorRes(XLen-1) ^ sltu

    val shsrc1 = MuxLookup(fuOpType, srca(XLen-1,0), Array(
      ALUOpType.srlw -> ZeroExt(srca(31,0), XLen),
      ALUOpType.sraw -> SignExt(srca(31,0), XLen)
    ))
    val shamt = Mux(ALUOpType.isWordOp(fuOpType), srcb(4, 0), if (XLen == 64) srcb(5, 0) else srcb(4, 0))
    val res = MuxLookup(fuOpType, adderRes, Array(
      ALUOpType.sll  -> ((shsrc1  << shamt)(XLen-1, 0)),
      ALUOpType.slt  -> ZeroExt(slt, XLen),
      ALUOpType.sltu -> ZeroExt(sltu, XLen),
      ALUOpType.xor  -> xorRes,
      ALUOpType.srl  -> (shsrc1  >> shamt),
      ALUOpType.or   -> (srca  |  srcb),
      ALUOpType.and  -> (srca  &  srcb),
      ALUOpType.sra  -> ((shsrc1.asSInt >> shamt).asUInt)
    ))
    aluRes := Mux(ALUOpType.isWordOp(fuOpType), SignExt(res(31,0), 64), res)

    //>>> Branch Taken
    val branchOpTable = Array(
    ALUOpType.getBranchType(ALUOpType.beq)  -> !xorRes.orR,
    ALUOpType.getBranchType(ALUOpType.blt)  -> slt,
    ALUOpType.getBranchType(ALUOpType.bltu) -> sltu
  )
    io.taken := MuxLookup(ALUOpType.getBranchType(fuOpType), false.B, branchOpTable) ^ ALUOpType.isBranchInvert(fuOpType)
    //<<< Branch Taken
}


class ExuToWbu extends NPCBundle {
    val ALURes = UInt(XLen.W)

}
class ExuToLsuIO extends NPCBundle {

    //val to_mem = new ToMem

    val cf      = new CtrlFlow
    val ctrl    = new CtrlSignal
    val data    = new DataSrc

}
class ExuToWbuIO extends NPCBundle {

    //val to_mem = new ToMem

    val cf      = new CtrlFlow
    val ctrl    = new CtrlSignal
    val data    = new DataSrc

}
class EXU extends NPCModule 
with HasNPCParameter 
with TYPE_INST{
    val io = IO(new Bundle{
        val from_isu = Flipped(Decoupled(new DecodeIO))
        val to_wbu = Decoupled(new ExuToWbuIO)
        //val bruRes = Output(new BruRes)
        val to_mem = new ToMem
        val from_mem = new FromMem
        val redirect = Output(new Redirect)

    })
    //>>> io




    val MicroOp = io.from_isu.bits
    val inBits = io.from_isu.bits
    val in     = io.from_isu

    val out    = io.to_wbu

    out.bits.cf <> MicroOp.cf 
    out.bits.ctrl <> MicroOp.ctrl
    out.bits.data <> MicroOp.data

    //out.bits.data.data_from_mem := io.from_mem.data    // TODO: from lsu

    val fuSrc1 = MicroOp.data.fuSrc1
    val fuSrc2 = MicroOp.data.fuSrc2
    //<<< io

    // alu
    val alu0 = Module(new ALU)
    val alu0InBits = alu0.io.in.bits
    alu0InBits.srca := fuSrc1
    alu0InBits.srcb := fuSrc2
    alu0InBits.fuOpType := MicroOp.ctrl.fuOpType

    //val ALURes0 = alu0.io.out.bits

    // lsu
    val lsu0 = Module(new LSU)
    lsu0.io.in.bits.srca := fuSrc1
    lsu0.io.in.bits.srcb := fuSrc2
    lsu0.io.in.bits.fuOpType := MicroOp.ctrl.fuOpType

    lsu0.io.from_mem <> io.from_mem
    io.to_mem <> lsu0.io.to_mem

    lsu0.io.ctrl <> MicroOp.ctrl
    lsu0.io.data <> MicroOp.data

    out.bits.data.data_from_mem := lsu0.io.out.bits

    // csr
    val csr0 = Module(new CSR)
    csr0.cfIn <> MicroOp.cf
    val csr0Out = csr0.access(
      in.valid && (in.bits.ctrl.fuType === FuType.csr),     // valid
      fuSrc1,
      fuSrc2,
      MicroOp.ctrl.fuOpType
    )
    out.bits.data.csrRdata := csr0Out

    //>>> ready/valid function unit //TODO : Demux
    alu0.io.out.ready := out.ready
    alu0.io.in.valid := in.valid && (in.bits.ctrl.fuType === FuType.alu)

    lsu0.io.out.ready := out.ready 
    lsu0.io.in.valid := in.valid && (in.bits.ctrl.fuType === FuType.lsu)

    csr0.io.out.ready := out.ready
    //csr0.io.in.valid := in.valid && (in.bits.ctrl.fuType === FuType.lsu)
    //<<<ready/valid function unit

    //>>> branch pc calculate
    val bruRes = Wire(new BruRes)
    val jalrBruRes = Wire(new BruRes)
    jalrBruRes.valid := in.valid && inBits.cf.isBranch && (inBits.cf.inst(6,0) === "b1100111".U)
    //jalrBruRes.valid := in.valid && inBits.cf.isBranch
    jalrBruRes.targetPc := (inBits.data.rfSrc1 + inBits.data.imm) & (~1.U(XLen.W))

    val typebBruRes = Wire(new BruRes)
    typebBruRes.valid := in.valid && inBits.cf.isBranch && (inBits.cf.inst(6,0) === "b1100011".U)   // TYPE_B
    val pcIfBranch = inBits.cf.pc + inBits.data.imm
    typebBruRes.targetPc := Mux(alu0.io.taken, pcIfBranch, inBits.cf.pc + 4.U)    //TODO

    val csrBruRes = Wire(new BruRes)
    csrBruRes.valid := in.valid && csr0.io.jmp
    csrBruRes.targetPc := csr0Out

    val defaultBruRes = Wire(new BruRes)
    defaultBruRes.valid := false.B 
    defaultBruRes.targetPc := 0.U


    bruRes := MuxCase(defaultBruRes, Array(
        jalrBruRes.valid  -> jalrBruRes,
        typebBruRes.valid   -> typebBruRes,
        csrBruRes.valid   -> csrBruRes
    ))

    // redirect
    val PredictError = bruRes.targetPc =/= MicroOp.cf.next_pc
    io.redirect.valid := in.valid && bruRes.valid && PredictError
    io.redirect.target := bruRes.targetPc

    out.bits.cf.next_pc := Mux(bruRes.valid, bruRes.targetPc, MicroOp.cf.next_pc)

    val isRedirect = io.redirect.valid

    //<<< branch pc calculate 

    // io

    //out.bits.data.Alu0Res <> alu0.io.out
    //out.bits.data.Alu0Res.valid := alu0.io.out.valid
    out.bits.data.Alu0Res.bits := alu0.io.out.bits


    // ready/valid setted here
    HandShakeDeal(io.from_isu, io.to_wbu, 
                  AnyInvalidCondition = false.B, 
                  AnyStopCodition = isRedirect && in.valid
                  )

}

class EXU_LLM0 extends NPCModule 
with HasNPCParameter 
with TYPE_INST{
    val io = IO(new Bundle{
        val from_isu = Flipped(Decoupled(new DecodeIO))
        val to_wbu = Decoupled(new ExuToWbuIO)
        //val bruRes = Output(new BruRes)
        val to_mem = new ToMem
        val from_mem = new FromMem
        val redirect = Output(new Redirect)

    })
    //>>> io




    val MicroOp = io.from_isu.bits
    val inBits = io.from_isu.bits
    val in     = io.from_isu

    val out    = io.to_wbu

    out.bits.cf <> MicroOp.cf 
    out.bits.ctrl <> MicroOp.ctrl
    out.bits.data <> MicroOp.data

    //out.bits.data.data_from_mem := io.from_mem.data    // TODO: from lsu

    val fuSrc1 = MicroOp.data.fuSrc1
    val fuSrc2 = MicroOp.data.fuSrc2
    //<<< io

    // alu
    val alu0 = Module(new ALU)
    val alu0InBits = alu0.io.in.bits
    alu0InBits.srca := fuSrc1
    alu0InBits.srcb := fuSrc2
    alu0InBits.fuOpType := MicroOp.ctrl.fuOpType

    //val ALURes0 = alu0.io.out.bits

    // lsu
    val lsu0 = Module(new LSU)
    lsu0.io.in.bits.srca := fuSrc1
    lsu0.io.in.bits.srcb := fuSrc2
    lsu0.io.in.bits.fuOpType := MicroOp.ctrl.fuOpType

    lsu0.io.from_mem <> io.from_mem
    io.to_mem <> lsu0.io.to_mem

    lsu0.io.ctrl <> MicroOp.ctrl
    lsu0.io.data <> MicroOp.data

    out.bits.data.data_from_mem := lsu0.io.out.bits

    // csr
    val csr0 = Module(new CSR)
    csr0.cfIn <> MicroOp.cf
    val csr0Out = csr0.access(
      in.valid && (in.bits.ctrl.fuType === FuType.csr),     // valid
      fuSrc1,
      fuSrc2,
      MicroOp.ctrl.fuOpType
    )
    out.bits.data.csrRdata := csr0Out

    //>>> ready/valid function unit //TODO : Demux
    alu0.io.out.ready := out.ready
    alu0.io.in.valid := in.valid && (in.bits.ctrl.fuType === FuType.alu)

    lsu0.io.out.ready := out.ready 
    lsu0.io.in.valid := in.valid && (in.bits.ctrl.fuType === FuType.lsu)

    csr0.io.out.ready := out.ready
    //csr0.io.in.valid := in.valid && (in.bits.ctrl.fuType === FuType.lsu)
    //<<<ready/valid function unit

    //>>> branch pc calculate
    val bruRes = Wire(new BruRes)
    bruRes := CalBruRes(inBits, alu0, csr0)
    
    // redirect
    val PredictError = bruRes.targetPc =/= MicroOp.cf.next_pc
    io.redirect.valid := in.valid && bruRes.valid && PredictError
    io.redirect.target := bruRes.targetPc

    out.bits.cf.next_pc := Mux(bruRes.valid, bruRes.targetPc, MicroOp.cf.next_pc)

    val isRedirect = io.redirect.valid

    //<<< branch pc calculate 

    // io

    //out.bits.data.Alu0Res <> alu0.io.out
    //out.bits.data.Alu0Res.valid := alu0.io.out.valid
    out.bits.data.Alu0Res.bits := alu0.io.out.bits


    // ready/valid setted here
    HandShakeDeal(io.from_isu, io.to_wbu, 
                  AnyInvalidCondition = false.B, 
                  AnyStopCodition = isRedirect && in.valid
                  )

}


class EXU_LLM extends NPCModule with HasNPCParameter {
  val io = IO(new Bundle {
    val from_isu = Flipped(Decoupled(new DecodeIO)) // Input from instruction decode unit
    val to_wbu = Decoupled(new ExuToWbuIO)         // Output to write-back unit
    val to_mem = new ToMem                         // Output to memory interface
    val from_mem = new FromMem                     // Input from memory
    val redirect = Output(new Redirect)            // Redirection signal for branch correction
  })

  io.to_wbu.bits.ctrl <> io.from_isu.bits.ctrl
  io.to_wbu.bits.cf <> io.from_isu.bits.cf
  io.to_wbu.bits.data <> io.from_isu.bits.data
  // ** Functional Units Instantiation **
  val alu0 = Module(new ALU)
  val lsu0 = Module(new LSU)
  val csr0 = Module(new CSR)

  // ** Decode and Connect Input Fields **
  alu0.io.in.bits.srca := io.from_isu.bits.data.fuSrc1
  alu0.io.in.bits.srcb := io.from_isu.bits.data.fuSrc2
  alu0.io.in.bits.fuOpType := io.from_isu.bits.ctrl.fuOpType
  alu0.io.in.valid := io.from_isu.valid && (io.from_isu.bits.ctrl.fuType === FuType.alu)
  alu0.io.out.ready := io.to_wbu.ready

  lsu0.io.in.bits.srca := io.from_isu.bits.data.fuSrc1
  lsu0.io.in.bits.srcb := io.from_isu.bits.data.fuSrc2
  lsu0.io.in.bits.fuOpType := io.from_isu.bits.ctrl.fuOpType
  lsu0.io.ctrl := io.from_isu.bits.ctrl
  lsu0.io.data := io.from_isu.bits.data
  lsu0.io.from_mem := io.from_mem
  lsu0.io.out.ready := io.to_wbu.ready
  lsu0.io.in.valid := io.from_isu.valid && (io.from_isu.bits.ctrl.fuType === FuType.lsu)
  // TODO

  csr0.io.in.bits.srca := io.from_isu.bits.data.fuSrc1
  csr0.io.in.bits.srcb := io.from_isu.bits.data.fuSrc2
  csr0.io.in.bits.fuOpType := io.from_isu.bits.ctrl.fuOpType
  csr0.io.cfIn <> io.from_isu.bits.cf
  csr0.io.in.valid := io.from_isu.valid && (io.from_isu.bits.ctrl.fuType === FuType.csr)
  csr0.io.out.ready := io.to_wbu.ready

  // ** Connect Data Outputs **
  io.to_wbu.bits.data.Alu0Res.bits := alu0.io.out.bits
  io.to_wbu.bits.data.data_from_mem := lsu0.io.out.bits
  io.to_mem := lsu0.io.to_mem
  io.to_wbu.bits.data.csrRdata := csr0.io.out.bits

  // ** Branch Handling Logic **
  val bruRes = Wire(new BruRes)
  bruRes := CalBruRes(io.from_isu.bits, alu0, csr0)

  // Generate redirection signals
  io.redirect.valid := io.from_isu.valid && bruRes.valid && (io.from_isu.bits.cf.next_pc =/= bruRes.targetPc)
  io.redirect.target := bruRes.targetPc

  // Update next_pc only if prediction error occurs
  io.to_wbu.bits.cf.next_pc := Mux(io.redirect.valid, bruRes.targetPc, io.from_isu.bits.cf.next_pc)

  // ** Handshake Logic **
  HandShakeDeal(
    io.from_isu,
    io.to_wbu,
    AnyInvalidCondition = false.B,
    AnyStopCodition = io.redirect.valid && io.from_isu.valid
  )
}