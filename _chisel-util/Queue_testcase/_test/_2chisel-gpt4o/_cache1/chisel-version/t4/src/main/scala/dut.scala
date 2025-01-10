import chisel3._
import chisel3.util._

class dut[T <: Data](gen: T, entries: Int, hasFlush: Boolean = false) extends Module {
  require(entries > 0, "Queue capacity (entries) must be greater than 0")

  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(gen))
    val deq = Decoupled(gen)
    val count = Output(UInt(log2Ceil(entries + 1).W))
    val flush = if (hasFlush) Some(Input(Bool())) else None
  })

  // Internal memory for storage
  val ram = Mem(entries, gen)

  // Pointers for enqueue and dequeue
  val enq_ptr = RegInit(0.U(log2Ceil(entries).W))
  val deq_ptr = RegInit(0.U(log2Ceil(entries).W))

  // Maybe full flag to differentiate between full and empty conditions
  val maybe_full = RegInit(false.B)

  // Helper signals
  val ptr_match = enq_ptr === deq_ptr
  val full = ptr_match && maybe_full
  val empty = ptr_match && !maybe_full

  // Default enqueue and dequeue enable signals
  val do_enq = io.enq.valid && io.enq.ready
  val do_deq = io.deq.valid && io.deq.ready

  // Count calculation
  val ptr_diff = enq_ptr - deq_ptr
  io.count := Mux(ptr_match,
    Mux(maybe_full, entries.U, 0.U),
    Mux(enq_ptr > deq_ptr, ptr_diff, entries.U + ptr_diff)
  )

  // Enqueue logic
  io.enq.ready := !full
  when(do_enq) {
    ram.write(enq_ptr, io.enq.bits)
    enq_ptr := enq_ptr + 1.U
  }

  // Dequeue logic
  io.deq.valid := !empty
  io.deq.bits := ram.read(deq_ptr)
  when(do_deq) {
    deq_ptr := deq_ptr + 1.U
  }

  // Handle full/empty transition
  when(do_enq =/= do_deq) {
    maybe_full := do_enq
  }

  // Handle optional flush signal
  if (hasFlush) {
    when(io.flush.getOrElse(false.B)) {
      enq_ptr := 0.U
      deq_ptr := 0.U
      maybe_full := false.B
    }
  }
}
