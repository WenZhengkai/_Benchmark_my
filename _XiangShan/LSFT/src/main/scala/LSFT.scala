import chisel3._ 
import chisel3.util._ 

class XSBundle() extends Bundle {

}

class XSModule() extends Module {

    
}

// Last Fetched Store Table Entry
class LFSTEntry(implicit p: Parameters) extends XSBundle  {
  val valid = Bool()
  val robIdx = new RobPtr
}

class LFSTReq(implicit p: Parameters) extends XSBundle {
  val isstore = Bool()
  val ssid = UInt(SSIDWidth.W) // use ssid to lookup LFST
  val robIdx = new RobPtr
}

class LFSTResp(implicit p: Parameters) extends XSBundle {
  val shouldWait = Bool()
  val robIdx = new RobPtr
}

class DispatchLFSTIO(implicit p: Parameters) extends XSBundle {
  val req = Vec(RenameWidth, Valid(new LFSTReq))
  val resp = Vec(RenameWidth, Flipped(Valid(new LFSTResp)))
}

// Last Fetched Store Table
class LFST(implicit p: Parameters) extends XSModule {
  val io = IO(new Bundle {
    // when redirect, mark canceled store as invalid
    val redirect = Input(Valid(new Redirect))
    val dispatch = Flipped(new DispatchLFSTIO)
    // when store issued, mark store as invalid
    val storeIssue = Vec(backendParams.StaExuCnt, Flipped(Valid(new DynInst)))
    val csrCtrl = Input(new CustomCSRCtrlIO)
  })

  val validVec = RegInit(VecInit(Seq.fill(LFSTSize)(VecInit(Seq.fill(LFSTWidth)(false.B)))))
  val robIdxVec = Reg(Vec(LFSTSize, Vec(LFSTWidth, new RobPtr)))
  val allocPtr = RegInit(VecInit(Seq.fill(LFSTSize)(0.U(log2Up(LFSTWidth).W))))
  val valid = Wire(Vec(LFSTSize, Bool()))
  (0 until LFSTSize).map(i => {
    valid(i) := validVec(i).asUInt.orR
  })

  // read LFST in rename stage
  for (i <- 0 until RenameWidth) {
    io.dispatch.resp(i).valid := io.dispatch.req(i).valid

    // If store-load pair is in the same dispatch bundle, loadWaitBit should also be set for load
    val hitInDispatchBundleVec = if(i > 0){
      WireInit(VecInit((0 until i).map(j =>
        io.dispatch.req(j).valid &&
        io.dispatch.req(j).bits.isstore &&
        io.dispatch.req(j).bits.ssid === io.dispatch.req(i).bits.ssid
      )))
    } else {
      WireInit(VecInit(Seq(false.B))) // DontCare
    }
    val hitInDispatchBundle = hitInDispatchBundleVec.asUInt.orR
    // Check if store set is valid in LFST
    io.dispatch.resp(i).bits.shouldWait := (
        (valid(io.dispatch.req(i).bits.ssid) || hitInDispatchBundle) &&
        io.dispatch.req(i).valid &&
        (!io.dispatch.req(i).bits.isstore || io.csrCtrl.storeset_wait_store)
      ) && !io.csrCtrl.lvpred_disable || io.csrCtrl.no_spec_load
    io.dispatch.resp(i).bits.robIdx := robIdxVec(io.dispatch.req(i).bits.ssid)(allocPtr(io.dispatch.req(i).bits.ssid)-1.U)
    if(i > 0){
      (0 until i).map(j =>
        when(hitInDispatchBundleVec(j)){
          io.dispatch.resp(i).bits.robIdx := io.dispatch.req(j).bits.robIdx
        }
      )
    }
  }

  // when store is issued, mark it as invalid
  (0 until backendParams.StaExuCnt).map(i => {
    // TODO: opt timing
    (0 until LFSTWidth).map(j => {
      when(io.storeIssue(i).valid && io.storeIssue(i).bits.storeSetHit && io.storeIssue(i).bits.robIdx.value === robIdxVec(io.storeIssue(i).bits.ssid)(j).value){
        validVec(io.storeIssue(i).bits.ssid)(j) := false.B
      }
    })
  })

  // when store is dispatched, mark it as valid
  (0 until RenameWidth).map(i => {
    when(io.dispatch.req(i).valid && io.dispatch.req(i).bits.isstore){
      val waddr = io.dispatch.req(i).bits.ssid
      val wptr = allocPtr(waddr)
      allocPtr(waddr) := allocPtr(waddr) + 1.U
      validVec(waddr)(wptr) := true.B
      robIdxVec(waddr)(wptr) := io.dispatch.req(i).bits.robIdx
    }
  })

  // when redirect, cancel store influenced
  (0 until LFSTSize).map(i => {
    (0 until LFSTWidth).map(j => {
      when(validVec(i)(j) && robIdxVec(i)(j).needFlush(io.redirect)){
        validVec(i)(j) := false.B
      }
    })
  })

  // recover robIdx after squash
  // behavior model, to be refactored later
  when(RegNext(io.redirect.fire)) {
    (0 until LFSTSize).map(i => {
      (0 until LFSTWidth).map(j => {
        val check_position = WireInit(allocPtr(i) + (j+1).U)
        when(!validVec(i)(check_position)){
          allocPtr(i) := check_position
        }
      })
    })
  }
}
