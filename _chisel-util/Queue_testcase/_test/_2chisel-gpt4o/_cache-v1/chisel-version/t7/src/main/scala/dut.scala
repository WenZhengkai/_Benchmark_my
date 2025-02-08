import chisel3._
import chisel3.util._

class QueueIO[T <: Data](gen: T, val entries: Int, val hasFlush: Boolean) extends Bundle {
  val enq = Flipped(Decoupled(gen))
  val deq = Decoupled(gen)
  val flush = if (hasFlush) Some(Input(Bool())) else None
  val count = Output(UInt(log2Ceil(entries + 1).W))
}

class dut[T <: Data](gen: T, entries: Int, hasFlush: Boolean = false) extends Module {
  require(entries > 0, "Number of entries must be positive")

  val io = IO(new QueueIO(gen, entries, hasFlush))

  val ram = Mem(entries, gen) // Memory for storage
  val enqPtr = RegInit(0.U(log2Ceil(entries).W))
  val deqPtr = RegInit(0.U(log2Ceil(entries).W))
  val maybeFull = RegInit(false.B)

  val ptrMatch = enqPtr === deqPtr
  val empty = ptrMatch && !maybeFull
  val full = ptrMatch && maybeFull

  // Enqueue logic
  val doEnq = io.enq.fire()
  when(doEnq) {
    ram(enqPtr) := io.enq.bits
    enqPtr := enqPtr + 1.U
    when(enqPtr === (entries - 1).U) {
      maybeFull := true.B
    }
  }

  // Dequeue logic
  val doDeq = io.deq.fire()
  io.deq.valid := !empty
  io.deq.bits := ram(deqPtr)
  when(doDeq) {
    deqPtr := deqPtr + 1.U
    when(deqPtr === (entries - 1).U) {
      maybeFull := false.B
    }
  }

  io.enq.ready := !full

  // Optional flush mechanism
  if (hasFlush) {
    when(io.flush.get) {
      enqPtr := 0.U
      deqPtr := 0.U
      maybeFull := false.B
    }
  }

  // Count calculation
  val ptrDiff = enqPtr - deqPtr
  io.count := Mux(ptrMatch, Mux(maybeFull, entries.U, 0.U), Mux(deqPtr > enqPtr, entries.U + ptrDiff, ptrDiff))
}

