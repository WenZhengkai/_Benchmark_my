import chisel3._
import chisel3.util._

class dut[T <: Data](
    gen: T,
    entries: Int,
    hasFlush: Boolean = false
) extends Module {
  require(entries > 0, "The number of entries must be a positive integer.")

  // Interface definition
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(gen)) // Input: Enqueue side
    val deq = Decoupled(gen)         // Output: Dequeue side
    val count = Output(UInt(log2Ceil(entries + 1).W)) // Number of elements in the queue
    val flush = if (hasFlush) Some(Input(Bool())) else None // Optional flush signal
  })

  // Task 1: Implement Memory Storage (`ram`)
  val ram = Mem(entries, gen)

  // Task 2: Pointer Management
  val enq_ptr = RegInit(0.U(log2Ceil(entries).W))
  val deq_ptr = RegInit(0.U(log2Ceil(entries).W))
  val maybe_full = RegInit(false.B)
  val ptr_match = enq_ptr === deq_ptr

  // Task 3: Full/Empty Logic
  val full = ptr_match && maybe_full
  val empty = ptr_match && !maybe_full

  io.enq.ready := !full
  io.deq.valid := !empty

  // Task 4: Enqueue Logic
  val do_enq = io.enq.valid && io.enq.ready
  when(do_enq) {
    ram(enq_ptr) := io.enq.bits
    enq_ptr := Mux(enq_ptr === (entries - 1).U, 0.U, enq_ptr + 1.U)
  }

  // Update `maybe_full` based on enqueue and dequeue conditions
  when(do_enq && !io.deq.ready) {
    maybe_full := true.B
  }.elsewhen(!do_enq && io.deq.ready) {
    maybe_full := false.B
  }

  // Task 5: Dequeue Logic
  val do_deq = io.deq.ready && io.deq.valid
  io.deq.bits := ram(deq_ptr)

  when(do_deq) {
    deq_ptr := Mux(deq_ptr === (entries - 1).U, 0.U, deq_ptr + 1.U)
  }

  // Task 6: Flush Mechanism (Conditional)
  if (hasFlush) {
    when(io.flush.get) {
      enq_ptr := 0.U
      deq_ptr := 0.U
      maybe_full := false.B
    }
  }

  // Task 7: Count Calculation
  val wrap_around_count = Mux(deq_ptr <= enq_ptr, enq_ptr - deq_ptr, entries.U - deq_ptr + enq_ptr)

  io.count := Mux(ptr_match, Mux(maybe_full, entries.U, 0.U), wrap_around_count)
}
