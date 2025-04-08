import chisel3._
import chisel3.util._

class dut[T <: Data](gen: T, entries: Int, val hasFlush: Boolean = false) extends Module {
  require(entries > 0, "Queue must have a positive number of entries")
  
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(gen)) // Input interface for enqueue
    val deq = Decoupled(gen)         // Output interface for dequeue
    val count = Output(UInt(log2Ceil(entries + 1).W)) // Current number of elements

    val flush = if (hasFlush) Some(Input(Bool())) else None // Optional flush signal
  })

  // Task 1: Memory storage
  val ram = Mem(entries, gen)

  // Task 2: Pointer management
  val enq_ptr = RegInit(0.U(log2Ceil(entries).W))
  val deq_ptr = RegInit(0.U(log2Ceil(entries).W))
  val maybe_full = RegInit(false.B)
  val ptr_match = enq_ptr === deq_ptr

  // Task 3: Full/Empty logic
  val full = ptr_match && maybe_full
  val empty = ptr_match && !maybe_full
  io.enq.ready := !full
  io.deq.valid := !empty

  // Task 4: Enqueue logic
  val do_enq = io.enq.valid && io.enq.ready
  when(do_enq) {
    ram.write(enq_ptr, io.enq.bits)            // Write data to memory
    enq_ptr := Mux(enq_ptr === (entries - 1).U, 0.U, enq_ptr + 1.U) // Increment pointer
  }

  // Task 5: Dequeue logic
  val do_deq = io.deq.ready && io.deq.valid
  when(do_deq) {
    deq_ptr := Mux(deq_ptr === (entries - 1).U, 0.U, deq_ptr + 1.U) // Increment pointer
  }

  // Update maybe_full
  when(do_enq =/= do_deq) {
    maybe_full := do_enq
  }

  // Task 6: Flush mechanism
  if (hasFlush) {
    when(io.flush.get) {
      enq_ptr := 0.U
      deq_ptr := 0.U
      maybe_full := false.B
    }
  }

  // Task 7: Count calculation
  val is_pow2 = isPow2(entries)
  val count = WireDefault(0.U(log2Ceil(entries + 1).W))
  
  if (is_pow2) {
    count := Mux(enq_ptr >= deq_ptr, enq_ptr - deq_ptr, entries.U + enq_ptr - deq_ptr)
  } else {
    count := Mux(ptr_match, Mux(maybe_full, entries.U, 0.U),
      Mux(enq_ptr > deq_ptr, enq_ptr - deq_ptr, entries.U - deq_ptr + enq_ptr))
  }

  io.count := count

  // Output dequeued data
  io.deq.bits := ram.read(deq_ptr)
}
