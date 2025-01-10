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

  // Internal memory for queue
  val ram = Mem(entries, gen)

  // Pointers for enqueue and dequeue
  val enq_ptr = RegInit(0.U(log2Ceil(entries).W))
  val deq_ptr = RegInit(0.U(log2Ceil(entries).W))
  val maybe_full = RegInit(false.B)

  // Pointer matching and full/empty calculation
  val ptr_match = enq_ptr === deq_ptr
  val full = ptr_match && maybe_full
  val empty = ptr_match && !maybe_full

  // Enqueue and dequeue logic
  val do_enq = io.enq.valid && io.enq.ready
  val do_deq = io.deq.valid && io.deq.ready

  when (do_enq && !do_deq) {
    ram(enq_ptr) := io.enq.bits
    enq_ptr := enq_ptr + 1.U
  }.elsewhen (!do_enq && do_deq) {
    deq_ptr := deq_ptr + 1.U
  }

  when (do_enq =/= do_deq) {
    maybe_full := do_enq
  }

  // Data output for dequeue
  io.deq.bits := ram(deq_ptr)
  io.deq.valid := !empty
  io.enq.ready := !full

  // Handle flush
  if (hasFlush) {
    when (io.flush.get) {
      enq_ptr := 0.U
      deq_ptr := 0.U
      maybe_full := false.B
    }
  }

  // Count calculation for number of elements
  io.count := Mux(ptr_match && !maybe_full, 0.U, Mux(deq_ptr <= enq_ptr, enq_ptr - deq_ptr, entries.U - deq_ptr + enq_ptr))
}

