import chisel3._
import chisel3.util._

class QueueIO[T <: Data](gen: T, entries: Int, hasFlush: Boolean = false) extends Bundle {
  val enq = Decoupled(gen)  // Input port for enqueueing data
  val deq = Flipped(Decoupled(gen))  // Output port for dequeueing data
  val flush = if (hasFlush) Some(Input(Bool())) else None  // Optional flush input
  val count = Output(UInt(log2Ceil(entries + 1).W)) // Output for the current number of elements
}

class dut[T <: Data](gen: T, val entries: Int, val hasFlush: Boolean = false) extends Module {
  require(entries > 0, "The number of entries must be a positive integer.")

  val io = IO(new QueueIO(gen, entries, hasFlush))

  // Memory for storage
  val ram = Mem(entries, gen)

  // Pointer Management
  val enq_ptr = RegInit(0.U(log2Ceil(entries).W))
  val deq_ptr = RegInit(0.U(log2Ceil(entries).W))
  val maybe_full = RegInit(false.B)

  val ptr_match = enq_ptr === deq_ptr
  val is_full = ptr_match && maybe_full
  val is_empty = ptr_match && !maybe_full

  // Enqueue logic
  when(io.enq.fire()) {
    ram(enq_ptr) := io.enq.bits
    enq_ptr := enq_ptr + 1.U
    when(enq_ptr === (entries - 1).U) { enq_ptr := 0.U }
  }

  // Dequeue logic
  when(io.deq.fire()) {
    deq_ptr := deq_ptr + 1.U
    when(deq_ptr === (entries - 1).U) { deq_ptr := 0.U }
  }

  // Update maybe_full
  when(io.enq.fire() =/= io.deq.fire()) {
    maybe_full := io.enq.fire()
  }

  // Flush logic
  if (hasFlush) {
    when(io.flush.getOrElse(false.B)) {
      enq_ptr := 0.U
      deq_ptr := 0.U
      maybe_full := false.B
    }
  }

  // Count logic
  val ptr_diff = enq_ptr - deq_ptr
  io.count := Mux(ptr_match,
                  Mux(maybe_full, entries.U, 0.U),
                  Mux(deq_ptr > enq_ptr, entries.U + ptr_diff, ptr_diff))

  // Connect IO
  io.enq.ready := !is_full
  io.deq.valid := !is_empty
  io.deq.bits := ram(deq_ptr)
}
