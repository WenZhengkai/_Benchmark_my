import chisel3._
import chisel3.util._

class dut[T <: Data](gen: T, val entries: Int, val hasFlush: Boolean = false) extends Module {
  require(entries > 0, "Queue must have a positive number of entries.")

  // Define IOs
  class QueueIO extends Bundle {
    val enq = Input(Flipped(Decoupled(gen)))
    val deq = Output(Decoupled(gen))
    val count = Output(UInt(log2Ceil(entries + 1).W))
    val flush = if (hasFlush) Some(Input(Bool())) else None
  }
  val io = IO(new QueueIO)

  // Task 1: Implement Memory for Storage
  val ram = Mem(entries, gen)

  // Task 2: Implement Pointer Management
  val enqPtr = RegInit(0.U(log2Ceil(entries).W))
  val deqPtr = RegInit(0.U(log2Ceil(entries).W))

  // Task 3: Implement Full/Empty Logic
  val maybeFull = RegInit(false.B)
  val ptrMatch = enqPtr === deqPtr
  val isFull = ptrMatch && maybeFull
  val isEmpty = ptrMatch && !maybeFull

  // Task 4: Implement Data Enqueue Logic
  io.enq.ready := !isFull
  when(io.enq.fire()) {
    ram(enqPtr) := io.enq.bits
    enqPtr := enqPtr + 1.U
    when(enqPtr === (entries - 1).U) {
      enqPtr := 0.U
    }
    when(ptrMatch) {
      maybeFull := true.B
    }
  }

  // Task 5: Implement Data Dequeue Logic
  io.deq.valid := !isEmpty
  io.deq.bits := ram(deqPtr)
  when(io.deq.fire()) {
    deqPtr := deqPtr + 1.U
    when(deqPtr === (entries - 1).U) {
      deqPtr := 0.U
    }
    when(isFull) {
      maybeFull := false.B
    }
  }

  // Task 6: Implement Flush Mechanism
  if (hasFlush) {
    when(io.flush.get) {
      enqPtr := 0.U
      deqPtr := 0.U
      maybeFull := false.B
    }
  }

  // Task 7: Calculate and Output Count
  io.count := Mux(isFull, entries.U, Mux(ptrMatch, 0.U, 
    Mux(enqPtr > deqPtr, enqPtr - deqPtr, entries.U + enqPtr - deqPtr)))
}

