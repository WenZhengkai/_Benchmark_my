import chisel3._
import chisel3.util._

class dut[T <: Data](gen: T, entries: Int, hasFlush: Boolean = false) extends Module {
  require(entries > 0, "Queue must have a positive number of entries")
  
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(gen))
    val deq = Decoupled(gen)
    val count = Output(UInt(log2Ceil(entries + 1).W))
    val flush = if (hasFlush) Some(Input(Bool())) else None
  })

  // Internal storage (RAM)
  val ram = Mem(entries, gen)

  // Enqueue and Dequeue pointers
  val enq_ptr = RegInit(0.U(log2Ceil(entries).W))
  val deq_ptr = RegInit(0.U(log2Ceil(entries).W))
  val maybe_full = RegInit(false.B)

  // Pointer match and status flags
  val ptr_match = (enq_ptr === deq_ptr)
  val full = ptr_match && maybe_full
  val empty = ptr_match && !maybe_full

  // Enqueue and dequeue signals
  val do_enq = io.enq.valid && io.enq.ready
  val do_deq = io.deq.valid && io.deq.ready

  // Enqueue logic
  when(do_enq) {
    ram(enq_ptr) := io.enq.bits // Write input data into RAM
    enq_ptr := Mux(enq_ptr === (entries - 1).U, 0.U, enq_ptr + 1.U) // Wrap-around increment
  }

  // Dequeue logic
  when(do_deq) {
    deq_ptr := Mux(deq_ptr === (entries - 1).U, 0.U, deq_ptr + 1.U) // Wrap-around increment
  }

  // Full/empty state management
  when(do_enq =/= do_deq) {
    maybe_full := do_enq
  }

  // Optional Flush logic
  if (hasFlush) {
    when(io.flush.get) {
      enq_ptr := 0.U
      deq_ptr := 0.U
      maybe_full := false.B
    }
  }

  // Count calculation (number of occupied slots in the queue)
  val ptr_diff = enq_ptr - deq_ptr
  io.count := Mux(ptr_match,
    Mux(maybe_full, entries.U, 0.U), // If pointers match, check full/empty status.
    Mux(enq_ptr > deq_ptr, ptr_diff, entries.U + ptr_diff) // Handle wrap-around case.
  )

  // IO connection
  io.enq.ready := !full // Enqueue is ready when queue is not full
  io.deq.valid := !empty // Dequeue is valid when queue is not empty
  io.deq.bits := ram(deq_ptr) // Queue output comes from the dequeue pointer
}
