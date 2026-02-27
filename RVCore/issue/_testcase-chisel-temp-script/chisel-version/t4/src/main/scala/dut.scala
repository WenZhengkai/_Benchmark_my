// ScoreBoard implementation
class ScoreBoard(maxScore: Int) extends HasNPCParameter {
  private val busy = RegInit(VecInit(Seq.fill(NR_GPR)(0.U(log2Ceil(maxScore + 1).W))))

  def isBusy(idx: UInt): Bool = {
    busy(idx) =/= 0.U
  }

  def mask(idx: UInt): UInt = {
    UIntToOH(idx)(NR_GPR - 1, 0)
  }

  def update(setMask: UInt, clearMask: UInt): Unit = {
    for (i <- 0 until NR_GPR) {
      if (i == 0) {
        busy(i) := 0.U // x0 is always 0
      } else {
        val set = setMask(i).asBool
        val clear = clearMask(i).asBool
        
        when (set && clear) {
          // Keep the original value when both set and clear
        }.elsewhen (set) {
          busy(i) := Mux(busy(i) === maxScore.U, maxScore.U, busy(i) + 1.U)
        }.elsewhen (clear) {
          busy(i) := Mux(busy(i) === 0.U, 0.U, busy(i) - 1.U)
        }
      }
    }
  }
}

// Instruction Issue Unit (ISU) implementation
class ISU extends NPCModule {
  val io = IO(new Bundle {
    val from_idu = Flipped(Decoupled(new DecodeIO))
    val to_exu = Decoupled(new DecodeIO))
    val wb = Input(new WbuToRegIO)
    val from_reg = new Bundle {
      val rfSrc1 = Input(UInt(XLen.W))
      val rfSrc2 = Input(UInt(XLen.W))
    }
  })

  // Create ScoreBoard with maximum count 3
  val sb = new ScoreBoard(3)
  
  // Connect signals from IDU to EXU by default, will override some fields later
  io.to_exu.bits := io.from_idu.bits
  
  // Data hazard detection
  val inBits = io.from_idu.bits
  val rs1Busy = sb.isBusy(inBits.ctrl.rs1) && (inBits.ctrl.rs1 =/= 0.U) && 
                (inBits.ctrl.fuSrc1Type === FuSrcType.rfSrc1)
  val rs2Busy = sb.isBusy(inBits.ctrl.rs2) && (inBits.ctrl.rs2 =/= 0.U) && 
                (inBits.ctrl.fuSrc2Type === FuSrcType.rfSrc2)
  
  // Instruction issue control
  val AnyInvalidCondition = rs1Busy || rs2Busy
  
  // Handle handshake signal
  val out = io.to_exu
  val in = io.from_idu
  
  // HandShakeDeal function inline implementation
  out.valid := in.valid && !AnyInvalidCondition
  in.ready := out.ready && !AnyInvalidCondition
  
  // Register file connection function
  def rs1_rs2(rfSrc1: UInt, rfSrc2: UInt): (UInt, UInt) = {
    io.to_exu.bits.data.rfSrc1 := rfSrc1
    io.to_exu.bits.data.rfSrc2 := rfSrc2
    (rfSrc1, rfSrc2)
  }
  
  // Get operand values from register file
  val (rfSrc1, rfSrc2) = rs1_rs2(io.from_reg.rfSrc1, io.from_reg.rfSrc2)
  
  // Operand source selection
  io.to_exu.bits.data.fuSrc1 := MuxLookup(inBits.ctrl.fuSrc1Type, 0.U, Seq(
    FuSrcType.rfSrc1 -> rfSrc1,
    FuSrcType.pc -> inBits.cf.pc,
    FuSrcType.zero -> 0.U
  ))
  
  io.to_exu.bits.data.fuSrc2 := MuxLookup(inBits.ctrl.fuSrc2Type, 0.U, Seq(
    FuSrcType.rfSrc2 -> rfSrc2,
    FuSrcType.imm -> inBits.data.imm,
    FuSrcType.four -> 4.U
  ))
  
  // ScoreBoard update
  val wbuClearMask = Mux(io.wb.RegWrite, sb.mask(io.wb.rd), 0.U)
  val isFireSetMask = Mux(inBits.ctrl.rfWen && out.fire, sb.mask(inBits.ctrl.rd), 0.U)
  sb.update(isFireSetMask, wbuClearMask)
}
