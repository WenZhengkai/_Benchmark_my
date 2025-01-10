import chisel3._
import chisel3.util._

// Define the CreditIO interface
class CreditIO[D <: Data](data: D) extends Bundle {
  val valid = Output(Bool())
  val credit = Input(Bool())
  val bits = Output(data.cloneType)
}

// Define the DCCreditReceiver module
class dut[D <: Data](data: D, maxCredit: Int) extends Module {
  require(maxCredit > 0, "maxCredit must be greater than 0")

  // IO definitions
  val io = IO(new Bundle {
    val enq = Flipped(new CreditIO(data))
    val deq = Decoupled(data)
    val fifoCount = Output(UInt(log2Ceil(maxCredit + 1).W))
  })

  // Internal FIFO queue
  val fifo = Module(new Queue(data, maxCredit))
  val fifoCount = RegInit(0.U(log2Ceil(maxCredit + 1).W))

  // Wires for bypass logic
  val fifoEmpty = fifo.io.count === 0.U
  val bypassValid = io.enq.valid && io.deq.ready && fifoEmpty
  val bypassBits = io.enq.bits

  // Registers for delayed logic
  val enqueueReady = Wire(Bool())
  val dequeueReady = Wire(Bool())

  // Credit logic
  val nextCredit = Wire(Bool())
  io.enq.credit := nextCredit

  // Bypass logic
  when(bypassValid) {
    io.deq.valid := true.B
    io.deq.bits := bypassBits
    enqueueReady := false.B
    dequeueReady := false.B
    nextCredit := true.B
  }
}


