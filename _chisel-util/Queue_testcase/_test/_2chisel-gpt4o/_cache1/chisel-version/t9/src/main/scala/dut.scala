import chisel3._
import chisel3.util._

class dut[T <: Data](gen: T, entries: Int, hasFlush: Boolean = false) extends Module {
  require(entries > 0, "The `entries` parameter must be a positive integer.")

  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(gen))   // Input for enqueue operation.
    val deq = Decoupled(gen)           // Output for dequeue operation.
    val count = Output(UInt(log2Ceil(entries + 1).W)) // Current number of elements in the queue.

    // Optional flush signal.
    val flush = if (hasFlush) Some(Input(Bool())) else None
  })

  // Memory for storing queue elements
  val ram = Mem(entries, gen)

  // Pointers for enqueueing and dequeueing
  val enq_ptr = RegInit(0.U(log2Ceil(entries).W))
  val deq_ptr = RegInit(0.U(log2Ceil(entries).W))

  // Maybe full flag
  val maybe_full = RegInit(false.B)

  // Pointer matching logic
  val ptr_match = enq_ptr === deq_ptr

  // Full and empty signals
  val full = ptr_match && maybe_full
  val empty = ptr_match && !maybe_full

  // Enqueue and dequeue conditions
  val do_enq = io.enq.valid && io.enq.ready
  val do_deq = io.deq.valid && io.deq.ready

  // Ready/valid signals for enqueue and dequeue interfaces
  io.enq.ready := !full
  io.deq.valid := !empty

  // Connect the output data
  io.deq.bits := ram(deq_ptr)

  // Write data to memory when enqueueing
  when(do_enq) {
    ram(enq_ptr) := io.enq.bits
    enq_ptr := enq_ptr + 1.U
  }

  // Update dequeue pointer when dequeuing
  when(do_deq) {
    deq_ptr := deq_ptr + 1.U
  }

  // Update maybe_full flag
  when(do_enq =/= do_deq) {
    maybe_full := do_enq
  }

  // Implement flush logic if enabled
  if (hasFlush) {
    when(io.flush.getOrElse(false.B)) {
      enq_ptr := 0.U
      deq_ptr := 0.U
      maybe_full := false.B
    }
  }

  // Compute the current count of elements in the queue
  io.count := Mux(
    enq_ptr >= deq_ptr,
    enq_ptr - deq_ptr,
    entries.U + enq_ptr - deq_ptr
  )
}

