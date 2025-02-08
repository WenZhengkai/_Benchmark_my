import chisel3._
import chisel3.util._

class CreditIO[D <: Data](data: D) extends Bundle {
  val valid = Output(Bool())
  val credit = Input(Bool())
  val bits = Output(data.cloneType)
}

class dut[D <: Data](dataType: D, maxCredit: Int) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(new CreditIO(dataType))
    val deq = Decoupled(dataType)
    val fifoCount = Output(UInt(log2Ceil(maxCredit + 1).W))
  })

  // Internal FIFO buffer
  val outFifo = Module(new Queue(dataType, maxCredit))
  
  // Registers for input valid and data
  val ivalid = RegNext(io.enq.valid, init = false.B)
  val idata = RegNext(io.enq.bits)

  // Bypass logic
  val bypassMode = !outFifo.io.deq.valid && (outFifo.io.count === 0.U)
  
  io.deq.valid := Mux(bypassMode, ivalid, outFifo.io.deq.valid)
  io.deq.bits := Mux(bypassMode, idata, outFifo.io.deq.bits)
  outFifo.io.deq.ready := !bypassMode && io.deq.ready
  
  // Enqueue logic
  outFifo.io.enq.valid := Mux(io.deq.ready, false.B, ivalid)
  outFifo.io.enq.bits := idata
  
  // Credit update logic
  val nextCredit = Wire(Bool())
  nextCredit := Mux(bypassMode, Mux(io.deq.ready, ivalid, false.B), outFifo.io.deq.fire)
  
  // Connect credit signal to input
  val ocredit = RegNext(nextCredit, init = false.B)
  io.enq.credit := ocredit

  // FIFO count output
  io.fifoCount := outFifo.io.count
}

