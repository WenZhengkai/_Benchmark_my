import chisel3._
import chisel3.util._

class dut[T <: Data](gen: T, entries: Int, hasFlush: Boolean = false) extends Module {
  require(entries > 0, "Queue size must be positive")
  
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(gen))
    val deq = Decoupled(gen)
    val count = Output(UInt(log2Ceil(entries + 1).W))
    val flush = if (hasFlush) Some(Input(Bool())) else None
  })

  // Task 1: Implement Memory for Storage
  val ram = Mem(entries, gen)

  // Task 2: Implement Pointer Management
  val enqPtr = RegInit(0.U(log2Ceil(entries).W))
  val deqPtr = RegInit(0.U(log2Ceil(entries).W))
  val ptrMatch = enqPtr === deqPtr

  // Task 3: Implement Full/Empty Logic
  val maybeFull = RegInit(false.B)
  val empty = ptrMatch && !maybeFull
  val full = ptrMatch && maybeFull

  // Task 4: Implement Data Enqueue Logic
  io.enq.ready := !full
  when(io.enq.fire()) {
    ram.write(enqPtr, io.enq.bits)
    enqPtr := enqPtr + 1.U
    when(enqPtr === (entries - 1).U) {
      enqPtr := 0.U
    }
    when(io.deq.ready && !io.deq.valid) {
      maybeFull := false.B
    }.otherwise {
      maybeFull := true.B
    }
  }

  // Task 5: Implement Data Dequeue Logic
  io.deq.valid := !empty
  io.deq.bits := ram.read(deqPtr)
  when(io.deq.fire()) {
    deqPtr := deqPtr + 1.U
    when(deqPtr === (entries - 1).U) {
      deqPtr := 0.U
    }
    when(io.enq.valid && !io.enq.ready) {
      maybeFull := true.B
    }.otherwise {
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
  val diff = enqPtr - deqPtr
  io.count := Mux(maybeFull, entries.U, Mux(diff < 0.U, entries.U + diff, diff))
}

