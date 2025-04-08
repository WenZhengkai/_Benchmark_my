import chisel3._
import chisel3.util._

class dut[T <: Data](gen: T, entries: Int, hasFlush: Boolean = false) extends Module {
  require(entries > 0, "Entries must be a positive integer")
  
  val addrWidth = log2Ceil(entries) // Address width based on the number of entries

  /** I/O Interface */
  val io = IO(new Bundle {
    // Enqueue interface
    val enq = Flipped(Decoupled(gen)) // Valid + Ready enqueue interface
    // Dequeue interface
    val deq = Decoupled(gen)         // Valid + Ready dequeue interface
    // Count of elements in the queue
    val count = Output(UInt(addrWidth.W))
    // Optional flush signal (only active if hasFlush is true)
    val flush = if (hasFlush) Some(Input(Bool())) else None
  })

  /** Task 1: Memory Storage (ram) */
  val ram = Mem(entries, gen)

  /** Task 2: Pointer Management */
  // Enqueue and Dequeue pointers
  val enq_ptr = RegInit(0.U(addrWidth.W))
  val deq_ptr = RegInit(0.U(addrWidth.W))
  // Tracking whether the queue is maybe full
  val maybe_full = RegInit(false.B)
  // Pointer match logic
  val ptr_match = enq_ptr === deq_ptr

  /** Task 3: Full/Empty Logic */
  val full = ptr_match && maybe_full
  val empty = ptr_match && !maybe_full

  io.enq.ready := !full // Queue can accept new data when not full
  io.deq.valid := !empty // Queue can supply data when not empty

  /** Task 4: Enqueue Logic */
  val do_enq = io.enq.valid && io.enq.ready

  when(do_enq) {
    ram(enq_ptr) := io.enq.bits // Write data to memory
    enq_ptr := Mux(enq_ptr === (entries - 1).U, 0.U, enq_ptr + 1.U) // Increment pointer (wrap-around)
  }

  /** Task 5: Dequeue Logic */
  val do_deq = io.deq.ready && io.deq.valid

  when(do_deq) {
    deq_ptr := Mux(deq_ptr === (entries - 1).U, 0.U, deq_ptr + 1.U) // Increment pointer (wrap-around)
  }

  /** Task 5b: maybe_full Logic */
  when(do_enq =/= do_deq) {
    maybe_full := do_enq
  }

  /** Task 6: Flush Mechanism (Conditional) */
  if (hasFlush) {
    when(io.flush.get) {
      enq_ptr := 0.U
      deq_ptr := 0.U
      maybe_full := false.B
    }
  }

  /** Task 7: Count Calculation */
  val diff = enq_ptr - deq_ptr

  io.count := Mux(ptr_match,
    Mux(maybe_full, entries.U, 0.U), // Full capacity if pointers match and maybe_full is true
    Mux(enq_ptr > deq_ptr, diff, entries.U - deq_ptr + enq_ptr)) // Handle wrap-around

  /** Output data for Dequeue (Task 5 continued) */
  io.deq.bits := ram(deq_ptr) // Read data from memory
}
