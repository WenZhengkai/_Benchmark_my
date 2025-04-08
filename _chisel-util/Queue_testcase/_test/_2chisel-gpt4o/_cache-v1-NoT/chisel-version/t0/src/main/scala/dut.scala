import chisel3._
import chisel3.util._

class dut[T <: Data](gen: T, entries: Int, hasFlush: Boolean = false) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(gen))  // Enqueue interface
    val deq = Decoupled(gen)           // Dequeue interface
    val count = Output(UInt(log2Ceil(entries + 1).W)) // Number of elements in the queue
    val flush = if (hasFlush) Some(Input(Bool())) else None // Optional flush signal
  })

  // Memory to store queue data entries
  val ram = Mem(entries, gen)

  // Pointer management
  val enqPtr = RegInit(0.U(log2Ceil(entries).W))
  val deqPtr = RegInit(0.U(log2Ceil(entries).W))
  val maybeFull = RegInit(false.B)

  val ptrMatch = enqPtr === deqPtr
  val empty = ptrMatch && !maybeFull
  val full = ptrMatch && maybeFull

  // Enqueue logic
  io.enq.ready := !full
  when(io.enq.fire()) {
    ram(enqPtr) := io.enq.bits
    enqPtr := Mux(enqPtr === (entries - 1).U, 0.U, enqPtr + 1.U)
    when(enqPtr === (entries - 1).U) {
      maybeFull := true.B
    }
  }

  // Dequeue logic
  io.deq.valid := !empty
  io.deq.bits := ram(deqPtr)
  when(io.deq.fire()) {
    deqPtr := Mux(deqPtr === (entries - 1).U, 0.U, deqPtr + 1.U)
    when(deqPtr === (entries - 1).U) {
      maybeFull := false.B
    }
  }

  // Flush mechanism
  if (hasFlush) {
    when(io.flush.get) {
      enqPtr := 0.U
      deqPtr := 0.U
      maybeFull := false.B
    }
  }

  // Calculate and output count
  io.count := Mux(ptrMatch,
    Mux(maybeFull, entries.U, 0.U),
    Mux(deqPtr > enqPtr, (entries.U + enqPtr) - deqPtr, enqPtr - deqPtr)
  )
}

