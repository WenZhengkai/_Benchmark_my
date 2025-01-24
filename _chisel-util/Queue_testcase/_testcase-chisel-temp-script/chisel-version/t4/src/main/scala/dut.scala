import chisel3._
import chisel3.util._

class QueueIO[T <: Data](gen: T, entries: Int, hasFlush: Boolean) extends Bundle {
  val enq = Flipped(Decoupled(gen))
  val deq = Decoupled(gen)
  val count = Output(UInt(log2Ceil(entries + 1).W))
  val flush = if (hasFlush) Some(Input(Bool())) else None
}

class dut[T <: Data](gen: T, val entries: Int, val hasFlush: Boolean = false) extends Module {
  val io = IO(new QueueIO(gen, entries, hasFlush))

  // Task 1: Memory for Storage
  val ram = Mem(entries, gen)

  // Task 2: Pointer Management
  val enq_ptr = RegInit(0.U(log2Ceil(entries).W))
  val deq_ptr = RegInit(0.U(log2Ceil(entries).W))
  val ptr_match = enq_ptr === deq_ptr

  // Task 3: Full/Empty Logic
  val maybe_full = RegInit(false.B)
  val full = ptr_match && maybe_full
  val empty = ptr_match && !maybe_full

  // Task 4: Data Enqueue Logic
  val do_enq = io.enq.valid && !full
  when(do_enq) {
    ram.write(enq_ptr, io.enq.bits)
    enq_ptr := enq_ptr + 1.U
    when(enq_ptr + 1.U === deq_ptr) {
      maybe_full := true.B
    }
  }

  // Task 5: Data Dequeue Logic
  val do_deq = io.deq.ready && !empty
  io.deq.bits := ram.read(deq_ptr)
  when(do_deq) {
    deq_ptr := deq_ptr + 1.U
    when(deq_ptr + 1.U === enq_ptr) {
      maybe_full := false.B
    }
  }

  // Task 6: Flush Mechanism
  if (hasFlush) {
    when(io.flush.get) {
      enq_ptr := 0.U
      deq_ptr := 0.U
      maybe_full := false.B
    }
  }

  // Task 7: Count Calculation Logic
  val ptr_diff = enq_ptr - deq_ptr
  io.count := Mux(enq_ptr >= deq_ptr, ptr_diff, entries.U + ptr_diff)

  // Task 8: Module Interface and Signals
  io.enq.ready := !full
  io.deq.valid := !empty

  // Task 9: Handle Corner Cases
  // Already handled by the logic above
}

