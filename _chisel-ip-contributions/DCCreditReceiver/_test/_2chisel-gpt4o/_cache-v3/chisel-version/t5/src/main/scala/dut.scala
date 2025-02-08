import chisel3._
import chisel3.util._

class CreditIO[D <: Data](data: D) extends Bundle {
  val valid = Output(Bool())
  val credit = Input(Bool())
  val bits = Output(data.cloneType)
}

class dut[D <: Data](data: D, maxCredit: Int) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(new CreditIO(data))
    val deq = Decoupled(data)
    val fifoCount = Output(UInt(log2Ceil(maxCredit + 1).W))
  })
  
  // FIFO Queue
  val outFifo = Module(new Queue(data, maxCredit))
  
  // Registers for internal state handling
  val ivalidReg = RegInit(false.B)
  val idataReg = RegInit(0.U.asTypeOf(data))
  
  ivalidReg := io.enq.valid
  idataReg := io.enq.bits
  
  // Wire for credit logic
  val nextCredit = WireDefault(false.B)
  
  // Bypass logic
  val bypass = !outFifo.io.deq.valid && (outFifo.io.count === 0.U)
  
  when (bypass) {
    io.deq.valid := ivalidReg
    io.deq.bits := idataReg
    outFifo.io.deq.ready := false.B
    
    when (io.deq.ready) {
      outFifo.io.enq.valid := false.B
      nextCredit := ivalidReg
    }.otherwise {
      outFifo.io.enq.valid := ivalidReg
    }
  } .otherwise {
    io.deq.valid := outFifo.io.deq.valid
    io.deq.bits := outFifo.io.deq.bits
    outFifo.io.deq.ready := io.deq.ready
    outFifo.io.enq.valid := ivalidReg
    outFifo.io.enq.bits := idataReg
    nextCredit := outFifo.io.deq.fire
  }
  
  io.enq.credit := nextCredit
  io.fifoCount := outFifo.io.count
}

