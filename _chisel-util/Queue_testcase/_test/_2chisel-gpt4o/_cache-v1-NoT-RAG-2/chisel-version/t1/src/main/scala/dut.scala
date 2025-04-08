import chisel3._
import chisel3.util._

class dut[T <: Data](
  gen: T,
  entries: Int,
  hasFlush: Boolean = false
) extends Module {
  require(entries > 0, "Queue must have at least one entry")

  // Interface definition
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(gen)) // Enqueue interface
    val deq = Decoupled(gen)          // Dequeue interface
    val count = Output(UInt(log2Ceil(entries + 1).W))
    val flush = if (hasFlush) Some(Input(Bool())) else None
  })

  // Task 1: Memory Storage (`ram`)
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

  // Update maybe_full on enqueue
  when(do_enq && !(io.deq.ready && io.deq.valid)) {
    maybe_full := true.B
  }

  // Task 5: Dequeue Logic
  val do_deq = io.deq.ready && io.deq.valid
  io.deq.bits := ram(deq_ptr)

  when(do_deq) {
    deq_ptr := Mux(deq_ptr === (entries - 1).U, 0.U, deq_ptr + 1.U)
  }

  // Update maybe_full on dequeue
  when(do_deq && !(io.enq.valid && io.enq.ready)) {
    maybe_full := false.B
  }

  // Task 6: Flush Mechanism (Conditional)
  if (hasFlush) {
    when(io.flush.get) { // Only handle flush when enabled
      enq_ptr := 0.U
      deq_ptr := 0.U
      maybe_full := false.B
    }
  }

  // Task 7: Count Calculation
  if (isPow2(entries)) {
    // If entries is a power of 2, directly subtract pointers
    io.count := Mux(maybe_full, entries.U, 0.U) + enq_ptr - deq_ptr
  } else {
    // If entries is not a power of 2, account for wrap-around
    io.count := Mux(ptr_match,
      Mux(maybe_full, entries.U, 0.U),
      Mux(enq_ptr > deq_ptr,
        enq_ptr - deq_ptr,
        entries.U - deq_ptr + enq_ptr
      )
    )
  }
}
