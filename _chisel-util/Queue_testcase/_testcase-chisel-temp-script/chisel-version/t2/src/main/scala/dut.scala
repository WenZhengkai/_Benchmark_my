import chisel3._
import chisel3.util._

class dut[T <: Data](gen: T, entries: Int, hasFlush: Boolean = false) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(gen))
    val deq = Decoupled(gen)
    val count = Output(UInt(log2Ceil(entries + 1).W))
    val flush = if (hasFlush) Some(Input(Bool())) else None
  })

  // Task 1: Implement Memory for Storage
  val ram = Mem(entries, gen)

  // Task 2: Implement Pointer Management
  val enq_ptr = RegInit(0.U(log2Ceil(entries).W))
  val deq_ptr = RegInit(0.U(log2Ceil(entries).W))
  val maybe_full = RegInit(false.B)

  // Task 3: Implement Full/Empty Logic
  val ptr_match = enq_ptr === deq_ptr
  val full = ptr_match && maybe_full
  val empty = ptr_match && !maybe_full

  // Task 4: Implement Data Enqueue Logic
  io.enq.ready := !full
  when(io.enq.fire()) {
    ram(enq_ptr) := io.enq.bits
    enq_ptr := enq_ptr + 1.U
    when(enq_ptr + 1.U === deq_ptr) {
      maybe_full := true.B
    }
  }

  // Task 5: Implement Data Dequeue Logic
  io.deq.valid := !empty
  io.deq.bits := ram(deq_ptr)
  when(io.deq.fire()) {
    deq_ptr := deq_ptr + 1.U
    maybe_full := false.B
  }

  // Task 6: Implement Flush Mechanism
  if (hasFlush) {
    when(io.flush.get) {
      enq_ptr := 0.U
      deq_ptr := 0.U
      maybe_full := false.B
    }
  }

  // Task 7: Calculate and Output Count
  io.count := Mux(full, entries.U, Mux(enq_ptr >= deq_ptr, enq_ptr - deq_ptr, entries.U + enq_ptr - deq_ptr))
}


