import chisel3._
import chisel3.util._
import scala.annotation.switch

//=== depandency ===

trait HasNPCParameter{
  val XLen = 32
  val CONFIG_RVE = true     // Support Riscv E extension
  val NR_GPR = if(CONFIG_RVE) 16 else 32
  val IndependentBru = false

}

abstract class NPCConfig extends HasNPCParameter

object MyNPCConfig extends NPCConfig

abstract class NPCBundle extends Bundle
with HasNPCParameter

abstract class NPCModule extends Module
with HasNPCParameter

class FromMem extends NPCBundle {
  //val inst = Input(UInt(32.W))
  val data = Input(UInt(XLen.W))
}
class ToMem extends NPCBundle {
  val data = Output(UInt(XLen.W))
  val addr = Output(UInt(XLen.W))
  val Wmask= Output(UInt(8.W))
  val MemWrite = Output(Bool())
  //val MemRead = Output(Bool())
}

object StageConnect {
  def apply[T <: Data](left: DecoupledIO[T], right: DecoupledIO[T], right_producer_fire: Bool, isFlush: Bool = false.B )   = {
    val arch = "pipeline"
    // 为展示抽象的思想, 此处代码省略了若干细节
    if      (arch == "single")   { 
      right.bits := left.bits 
      right.valid := left.valid
      left.ready := right.ready
    }
    else if (arch == "multi")    { right <> left }
    else if (arch == "pipeline") {
      
      // left.valid : output from combinational
      // right.valid : input from a reg
      val valid = RegInit(false.B)
      when(isFlush) {valid := false.B}
      .elsewhen(right.ready && left.valid) {valid := left.valid}
      .elsewhen(right_producer_fire) {valid := false.B}
      .otherwise {valid := valid}

      right.valid := valid
      left.ready := right.ready
      //right.valid <> RegEnable(left.valid, false.B, right.ready) // Justify it with `wbu_to_reg_valid_reg` at same time
      right.bits <> RegEnable(left.bits, left.valid && right.ready) 
    
    }    // TODO: correct connect
    else if (arch == "ooo")      { right <> Queue(left, 16) }
  }
}

object HandShakeDeal {
  def apply [T1 <: Data,T2 <: Data](consumer: DecoupledIO[T1], producer: DecoupledIO[T2], AnyInvalidCondition: Bool, AnyStopCodition: Bool = false.B) = {
      consumer.ready :=  ((false.B === consumer.valid) || producer.fire) && (false.B === AnyStopCodition ) // TODO: finish it
      producer.valid := consumer.valid && (false.B === AnyInvalidCondition) // TODO: finish it
  }

}

class Commit extends NPCBundle {
  val valid = Bool()
  val pc    = UInt(XLen.W)
  val next_pc    = UInt(XLen.W)   // Todo: abjust it according to jump result
  val inst  = UInt(32.W)
}

class Redirect extends NPCBundle {
  val target = UInt(XLen.W)
  val valid  = Bool()
}

//=== depandency ===

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

class ALU_golden extends NPCModule {
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
class EXU_golden extends NPCModule 
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
    val alu0 = Module(new ALU_golden)
    val alu0InBits = alu0.io.in.bits
    alu0InBits.srca := fuSrc1
    alu0InBits.srcb := fuSrc2
    alu0InBits.fuOpType := MicroOp.ctrl.fuOpType

    //val ALURes0 = alu0.io.out.bits

    // lsu
    val lsu0 = Module(new LSU_golden)
    lsu0.io.in.bits.srca := fuSrc1
    lsu0.io.in.bits.srcb := fuSrc2
    lsu0.io.in.bits.fuOpType := MicroOp.ctrl.fuOpType

    lsu0.io.from_mem <> io.from_mem
    io.to_mem <> lsu0.io.to_mem

    lsu0.io.ctrl <> MicroOp.ctrl
    lsu0.io.data <> MicroOp.data

    out.bits.data.data_from_mem := lsu0.io.out.bits

    // csr
    val csr0 = Module(new CSR_golden)
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



object LSUOpType { 
  def lb   = "b0000000".U
  def lh   = "b0000001".U
  def lw   = "b0000010".U
  def ld   = "b0000011".U
  def lbu  = "b0000100".U
  def lhu  = "b0000101".U
  def lwu  = "b0000110".U
  def sb   = "b0001000".U
  def sh   = "b0001001".U
  def sw   = "b0001010".U
  def sd   = "b0001011".U

  def lr      = "b0100000".U
  def sc      = "b0100001".U
  def amoswap = "b0100010".U
  def amoadd  = "b1100011".U
  def amoxor  = "b0100100".U
  def amoand  = "b0100101".U
  def amoor   = "b0100110".U
  def amomin  = "b0110111".U
  def amomax  = "b0110000".U
  def amominu = "b0110001".U
  def amomaxu = "b0110010".U

  def isAdd(func: UInt) = func(6)
  def isAtom(func: UInt): Bool = func(5)
  def isStore(func: UInt): Bool = func(3)
  def isLoad(func: UInt): Bool = !isStore(func) & !isAtom(func)
  def isLR(func: UInt): Bool = func === lr
  def isSC(func: UInt): Bool = func === sc
  def isAMO(func: UInt): Bool = isAtom(func) && !isLR(func) && !isSC(func)

  def needMemRead(func: UInt): Bool = isLoad(func) || isAMO(func) || isLR(func)
  def needMemWrite(func: UInt): Bool = isStore(func) || isAMO(func) || isSC(func)

  def atomW = "010".U
  def atomD = "011".U
  
}




class LsuToWbuIO extends NPCBundle {
    val data_from_mem = Output(UInt(XLen.W))

    val cf = new CtrlFlow
    val ctrl = new CtrlSignal
    val data = new DataSrc

}

class LSUIO extends FunctionUnitIO {
    val to_mem = new ToMem
    val from_mem = new FromMem
    val ctrl    = Input(new CtrlSignal)
    val data  = Input(new DataSrc)
}

class LSU_golden extends NPCModule 
with HasNPCParameter {
    /*
    val io = IO(new Bundle{
        val from_exu = Flipped(Decoupled(new ExuToLsuIO))
        val to_wbu = Decoupled(new LsuToWbuIO)
        val to_mem = new ToMem
        val from_mem = new FromMem
    })
    */
    val io = IO(new LSUIO)
    // io
    //>>> ready/valid
    io.out.valid := io.in.valid     // TODO: add memory response
    io.in.ready := true.B
    //<<< ready/valid
 
    io.to_mem.data := io.data.rfSrc2

    io.to_mem.addr := io.in.bits.srca + io.in.bits.srcb
    io.to_mem.Wmask := MuxLookup(io.ctrl.fuOpType, "h00".U, Array(
        LSUOpType.sb    -> "h01".U,
        LSUOpType.sh    -> "h03".U,
        LSUOpType.sw    -> "h0f".U,
        LSUOpType.sd    -> "hff".U
    ))

    io.to_mem.MemWrite := io.ctrl.MemWrite


    // signals used in LSU_golden


    // signals transport
    val from_mem_data = io.from_mem.data

    io.out.bits := MuxLookup(io.ctrl.fuOpType, 0.U, Array(
        LSUOpType.lb    -> SignExt(from_mem_data(7,0), XLen),
        LSUOpType.lh    -> SignExt(from_mem_data(15,0), XLen),
        LSUOpType.lw    -> SignExt(from_mem_data(31,0), XLen),
        //LSUOpType.ld    -> SignExt(from_mem_data(63,0), XLen),

        LSUOpType.lbu    -> ZeroExt(from_mem_data(7,0), XLen),
        LSUOpType.lhu    -> ZeroExt(from_mem_data(15,0), XLen),
        LSUOpType.lwu    -> ZeroExt(from_mem_data(31,0), XLen)    
    ))
  
    // io

}



object CSROpType {
  def jmp  = "b000".U
  def wrt  = "b001".U
  def set  = "b010".U
  def clr  = "b011".U
  def wrti = "b101".U
  def seti = "b110".U
  def clri = "b111".U
}

trait HasCSRConst {
  // User Trap Setup
  val Ustatus       = 0x000
  val Uie           = 0x004
  val Utvec         = 0x005

  // User Trap Handling
  val Uscratch      = 0x040
  val Uepc          = 0x041
  val Ucause        = 0x042
  val Utval         = 0x043
  val Uip           = 0x044

  // User Floating-Point CSRs (not implemented)
  val Fflags        = 0x001
  val Frm           = 0x002
  val Fcsr          = 0x003

  // User Counter/Timers
  val Cycle         = 0xC00
  val Time          = 0xC01
  val Instret       = 0xC02

  // Supervisor Trap Setup
  val Sstatus       = 0x100
  val Sedeleg       = 0x102
  val Sideleg       = 0x103
  val Sie           = 0x104
  val Stvec         = 0x105
  val Scounteren    = 0x106

  // Supervisor Trap Handling
  val Sscratch      = 0x140
  val Sepc          = 0x141
  val Scause        = 0x142
  val Stval         = 0x143
  val Sip           = 0x144

  // Supervisor Protection and Translation
  val Satp          = 0x180

  // Machine Information Registers
  val Mvendorid     = 0xF11
  val Marchid       = 0xF12
  val Mimpid        = 0xF13
  val Mhartid       = 0xF14

  // Machine Trap Setup
  val Mstatus       = 0x300
  val Misa          = 0x301
  val Medeleg       = 0x302
  val Mideleg       = 0x303
  val Mie           = 0x304
  val Mtvec         = 0x305
  val Mcounteren    = 0x306

  // Machine Trap Handling
  val Mscratch      = 0x340
  val Mepc          = 0x341
  val Mcause        = 0x342
  val Mtval         = 0x343
  val Mip           = 0x344

  // Machine Memory Protection
  // TBD
  val Pmpcfg0       = 0x3A0
  val Pmpcfg1       = 0x3A1
  val Pmpcfg2       = 0x3A2
  val Pmpcfg3       = 0x3A3
  val PmpaddrBase   = 0x3B0

  // Machine Counter/Timers
  // Currently, NPC uses perfcnt csr set instead of standard Machine Counter/Timers
  // 0xB80 - 0x89F are also used as perfcnt csr

  // Machine Counter Setup (not implemented)
  // Debug/Trace Registers (shared with Debug Mode) (not implemented)
  // Debug Mode Registers (not implemented)

  def privEcall  = 0x000.U
  def privEbreak = 0x001.U
  def privMret   = 0x302.U
  def privSret   = 0x102.U
  def privUret   = 0x002.U

  def ModeM     = 0x3.U
  def ModeH     = 0x2.U
  def ModeS     = 0x1.U
  def ModeU     = 0x0.U

  def IRQ_UEIP  = 0
  def IRQ_SEIP  = 1
  def IRQ_MEIP  = 3

  def IRQ_UTIP  = 4
  def IRQ_STIP  = 5
  def IRQ_MTIP  = 7

  def IRQ_USIP  = 8
  def IRQ_SSIP  = 9
  def IRQ_MSIP  = 11

  val IntPriority = Seq(
    IRQ_MEIP, IRQ_MSIP, IRQ_MTIP,
    IRQ_SEIP, IRQ_SSIP, IRQ_STIP,
    IRQ_UEIP, IRQ_USIP, IRQ_UTIP
  )
}

trait HasExceptionNO {
  def instrAddrMisaligned = 0
  def instrAccessFault    = 1
  def illegalInstr        = 2
  def breakPoint          = 3
  def loadAddrMisaligned  = 4
  def loadAccessFault     = 5
  def storeAddrMisaligned = 6
  def storeAccessFault    = 7
  def ecallU              = 8
  def ecallS              = 9
  def ecallM              = 11
  def instrPageFault      = 12
  def loadPageFault       = 13
  def storePageFault      = 15

  val ExcPriority = Seq(
      breakPoint, // TODO: different BP has different priority
      instrPageFault,
      instrAccessFault,
      illegalInstr,
      instrAddrMisaligned,
      ecallM, ecallS, ecallU,
      storeAddrMisaligned,
      loadAddrMisaligned,
      storePageFault,
      loadPageFault,
      storeAccessFault,
      loadAccessFault
  )
}


class CSRIO extends FunctionUnitIO {
  val cfIn  = Input(new CtrlFlow)
  val jmp   = Output(Bool())

}

class CSR_golden extends NPCModule
with HasCSRConst
with HasExceptionNO
{
  val io = IO(new CSRIO)

  val (valid, srca, srcb, fuOpType) = (io.in.valid, io.in.bits.srca, io.in.bits.srcb, io.in.bits.fuOpType)
  def access(valid: Bool, src1: UInt, src2: UInt, func: UInt): UInt = {
    this.valid := valid
    this.srca := src1
    this.srcb := src2
    this.fuOpType := func
    io.out.bits
  }
  io.in.ready := true.B
  io.out.valid := valid
    val cfIn = io.cfIn
    // Machine-Level CSRs
    

    val mtvec = RegInit(UInt(XLen.W), 0.U)
    val mcause = RegInit(UInt(XLen.W), 0.U)

    val mepc = RegInit(UInt(XLen.W), 0.U)


    val mstatus_init = if(XLen == 64) "ha00001800".U else "h00001800".U
    val mstatus = RegInit(UInt(XLen.W), mstatus_init)

    val csrIndex = srcb

    val isEcall = cfIn.inst === "b000000000000_00000_000_00000_1110011".U
    val isMret  = cfIn.inst === "b0011000_00010_00000_000_00000_1110011".U
    val isEbreak = cfIn.inst === "b000000000001_00000_000_00000_1110011".U

    val csr = MuxLookup(csrIndex, 0.U, Array(
      Mtvec.U   -> mtvec,
      Mcause.U  -> mcause,
      Mepc.U    -> mepc,
      Mstatus.U  -> mstatus
    ))
    val csrUpdate = MuxLookup(fuOpType, 0.U, Array(
      CSROpType.wrt   ->  srca,
      CSROpType.set   ->  (srca | csr),
      CSROpType.clr ->  (~srca & csr)
    ))
    val csrWen = valid && (fuOpType =/= CSROpType.jmp)
    when(csrWen === true.B){
      when(csrIndex === Mtvec.U){
        mtvec := csrUpdate
      }
      when(csrIndex === Mcause.U){
        mcause := csrUpdate
      }
      when(csrIndex === Mepc.U){
        mepc  := csrUpdate
      }
      when(csrIndex === Mstatus.U){
        mstatus := csrUpdate
      }
    }
    // ecall
    when(csrWen === false.B && valid === true.B && isEcall ) {
      mcause  := ecallM.U
      mepc    := cfIn.pc
    }

    io.jmp := valid && (fuOpType === CSROpType.jmp) && !isEbreak
    io.out.bits   := MuxCase(csr, Array(
      (isEcall === true.B)   -> mtvec,
      (isMret === true.B)    -> mepc
    ))
  

}