import chisel3._
import chisel3.util._

class dut[T <: Data](gen: T, entries: Int, hasFlush: Boolean = false) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(gen))
    val deq = Decoupled(gen)
    val count = Output(UInt(log2Ceil(entries + 1).W))
    val flush = if (hasFlush) Some(Input(Bool())) else None
  })

  // Task 1: Implement `ram` (Memory for Storage)
  val ram = Mem(entries, gen)

  // Task 2: Implement Pointer Management
  val enqPtr = RegInit(0.U(log2Ceil(entries).W))
  val deqPtr = RegInit(0.U(log2Ceil(entries).W))
  val ptrMatch = enqPtr === deqPtr

  // Task 3: Implement Full/Empty Logic
  val maybeFull = RegInit(false.B)
  val full = ptrMatch && maybeFull
  val empty = ptrMatch && !maybeFull

  // Task 4: Implement Data Enqueue Logic
  val doEnq = io.enq.valid && !full
  when(doEnq) {
    ram(enqPtr) := io.enq.bits
    enqPtr := Mux(enqPtr === (entries - 1).U, 0.U, enqPtr + 1.U)
    when(enqPtr === deqPtr) { maybeFull := true.B }
  }

  // Task 5: Implement Data Dequeue Logic
  val doDeq = io.deq.ready && !empty
  io.deq.bits := ram(deqPtr)
  when(doDeq) {
    deqPtr := Mux(deqPtr === (entries - 1).U, 0.U, deqPtr + 1.U)
    when(deqPtr === enqPtr) { maybeFull := false.B }
  }

  // Task 6: Implement Flush Mechanism (Optional Feature)
  if (hasFlush) {
    when(io.flush.get) {
      enqPtr := 0.U
      deqPtr := 0.U
      maybeFull := false.B
    }
  }

  // Task 7: Implement Count Calculation Logic
  io.count := Mux(
    enqPtr >= deqPtr,
    enqPtr - deqPtr,
    entries.U + enqPtr - deqPtr
  )

  // Task 8: Implement Module Interface and Signals
  io.enq.ready := !full
  io.deq.valid := !empty

  // Task 9: Integrate and Handle Corner Cases
  // The implementation inherently handles corner cases through logic definitions
}

// Chisel test bench is not included in this code snippet.
