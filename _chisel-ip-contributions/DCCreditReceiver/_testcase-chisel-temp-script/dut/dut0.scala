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

  // Internal FIFO queue
  val fifo = Module(new Queue(data, maxCredit))
  
  // Internal registers to track input valid and bits
  val ivalid = RegInit(false.B)
  val idata = Reg(data.cloneType)

  // Handling input data and valid signal
  when(io.enq.valid && io.enq.credit) {
    ivalid := true.B
    idata := io.enq.bits
  }.otherwise {
    ivalid := false.B
  }

  // Bypass logic
  val bypass = Wire(Bool())
  bypass := fifo.io.count === 0.U && io.deq.ready

  // Output to consumer
  io.deq.valid := Mux(bypass, ivalid, fifo.io.deq.valid)
  io.deq.bits := Mux(bypass, idata, fifo.io.deq.bits)
  fifo.io.deq.ready := !bypass && io.deq.ready

  // Credit logic
  val nextCredit = Wire(Bool())
  nextCredit := (bypass && io.deq.fire) || (!bypass && fifo.io.deq.fire)
  io.enq.credit := nextCredit

  // Connect input to FIFO
  fifo.io.enq.valid := io.enq.valid && !bypass
  fifo.io.enq.bits := io.enq.bits

  // FIFO count output
  io.fifoCount := fifo.io.count
}

