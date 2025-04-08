import chisel3._
import chisel3.util._

/** dut Module
 *
 * This module implements a simple parameterized FIFO queue with options for size,
 * data type, and flush capabilities.
 */
class dut[T <: Data](
  gen: T,
  val entries: Int,
  val hasFlush: Boolean = false
) extends Module {
  // Ensure the entries parameter is positive.
  require(entries > 0, "Number of entries in the queue must be > 0")

  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(gen)) // Input interface for enqueue
    val deq = Decoupled(gen)          // Output interface for dequeue
    val count = Output(UInt(log2Ceil(entries + 1).W)) // Queue element count
    val flush = if (hasFlush) Some(Input(Bool())) else None // Optional flush signal
  })

  // -------- Task 1: Memory Storage --------
  val ram = Mem(entries, gen) // Parameterized memory block

  // -------- Task 2: Pointer Management --------
  val enq_ptr = RegInit(0.U(log2Ceil(entries).W)) // Enqueue pointer
  val deq_ptr = RegInit(0.U(log2Ceil(entries).W)) // Dequeue pointer
  val maybe_full = RegInit(false.B) // Indicates whether the queue is full or partially full

  val ptr_match = enq_ptr === deq_ptr // Check for pointer equality

  // -------- Task 3: Full/Empty Logic --------
  val full = ptr_match && maybe_full
  val empty = ptr_match && !maybe_full

  io.enq.ready := !full
  io.deq.valid := !empty

  // -------- Task 4: Enqueue Logic --------
  val do_enq = io.enq.valid && io.enq.ready
  when(do_enq) {
    ram.write(enq_ptr, io.enq.bits) // Write to memory
    enq_ptr := Mux(enq_ptr === (entries - 1).U, 0.U, enq_ptr + 1.U) // Wrap pointer

    // Update maybe_full if enqueue happens without simultaneous dequeue
    when(!io.deq.fire()) {
      maybe_full := true.B
    }
  }

  // -------- Task 5: Dequeue Logic --------
  val do_deq = io.deq.ready && io.deq.valid
  when(do_deq) {
    deq_ptr := Mux(deq_ptr === (entries - 1).U, 0.U, deq_ptr + 1.U) // Wrap pointer

    // Update maybe_full if dequeue happens without simultaneous enqueue
    when(!io.enq.fire()) {
      maybe_full := false.B
    }
  }

  // Assign output bits from memory when valid
  io.deq.bits := ram.read(deq_ptr, !empty)

  // -------- Task 6: Flush Mechanism (Optional) --------
  if (hasFlush) {
    when(io.flush.get) { // Check if flush signal is asserted
      enq_ptr := 0.U
      deq_ptr := 0.U
      maybe_full := false.B // Clear maybe_full
    }
  }

  // -------- Task 7: Count Calculation --------
  if (isPow2(entries)) {
    io.count := Mux(maybe_full, entries.U, enq_ptr - deq_ptr)
  } else {
    io.count := Mux(ptr_match,
      Mux(maybe_full, entries.U, 0.U),
      Mux(enq_ptr > deq_ptr,
        enq_ptr - deq_ptr,
        entries.U - deq_ptr + enq_ptr
      )
    )
  }
}
