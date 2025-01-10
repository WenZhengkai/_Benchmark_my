import chisel3._
import chisel3.util._

class QueueIO[T <: Data](gen: T) extends Bundle {
  val enq = Flipped(Decoupled(gen))
  val deq = Decoupled(gen)
  val count = Output(UInt())
  val flush = Input(Option(Bool()))
}

class dut[T <: Data](gen: T, val entries: Int, val hasFlush: Boolean = false) extends Module {
  require(entries > 0, "Queue entries must be a positive integer")

  // Instantiate IO
  val io = IO(new QueueIO(gen))

  // Memory storage for the queue
  val ram = Mem(entries, gen)

  // Pointers for enqueue and dequeue
  val enqPtr = RegInit(0.U(log2Ceil(entries).W))
  val deqPtr = RegInit(0.U(log2Ceil(entries).W))
  val maybeFull = RegInit(false.B)

  // Pointer match logic
  val ptrMatch = enqPtr === deqPtr
  val full = ptrMatch && maybeFull
  val empty = ptrMatch && !maybeFull

  // Enqueue and Dequeue operation flags
  val doEnq = io.enq.valid && !full
  val doDeq = io.deq.ready && !empty

  // Enqueue operation
  when (doEnq) {
    ram(enqPtr) := io.enq.bits
    enqPtr := (enqPtr + 1.U) % entries.U
    when (enqPtr + 1.U === deqPtr) {
      maybeFull := true.B
    }
  }

  // Dequeue operation
  when (doDeq) {
    deqPtr := (deqPtr + 1.U) % entries.U
    when (deqPtr + 1.U === enqPtr) {
      maybeFull := false.B
    }
  }

  // Flush operation
  if (hasFlush) {
    when (io.flush.getOrElse(false.B)) {
      enqPtr := 0.U
      deqPtr := 0.U
      maybeFull := false.B
    }
  }

  // Output assignments
  io.deq.bits := ram(deqPtr)
  io.deq.valid := !empty
  io.enq.ready := !full

  // Count calculation
  val ptrDiff = enqPtr - deqPtr
  io.count := Mux(maybeFull && ptrMatch, entries.U, ptrDiff)

  // Ensure block behavior is correct in the case of configuration without flush
  assert(!(io.flush.isDefined && !hasFlush), "Flush signal provided while hasFlush is false")
}

