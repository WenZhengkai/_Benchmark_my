import chisel3._
import chisel3.util._

class dut[T <: Data](gen: T, entries: Int, hasFlush: Boolean = false) extends Module {
  require(entries > 0, "Queue length must be greater than 0")

  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(gen))
    val deq = Decoupled(gen)
    val count = Output(UInt(log2Ceil(entries + 1).W))
    val flush = if (hasFlush) Some(Input(Bool())) else None
  })

  // Memory for storage
  val ram = Mem(entries, gen)

  // Pointers
  val enq_ptr = RegInit(0.U(log2Ceil(entries).W))
  val deq_ptr = RegInit(0.U(log2Ceil(entries).W))
  val maybe_full = RegInit(false.B)

  // Pointer matching logic
  val ptr_match = enq_ptr === deq_ptr
  val empty = ptr_match && !maybe_full
  val full = ptr_match && maybe_full

  // Enqueue and Dequeue operations
  io.enq.ready := !full
  io.deq.valid := !empty

  when(io.enq.valid && io.enq.ready) {
    ram(enq_ptr) := io.enq.bits
    enq_ptr := enq_ptr + 1.U
    when(enq_ptr + 1.U === deq_ptr) {
      maybe_full := true.B
    }
  }

  when(io.deq.valid && io.deq.ready) {
    deq_ptr := deq_ptr + 1.U
    when(enq_ptr === deq_ptr + 1.U) {
      maybe_full := false.B
    }
  }

  when(io.enq.valid && io.enq.ready && io.deq.valid && io.deq.ready) {
    maybe_full := maybe_full // Adjust backpressure if enqueue and dequeue happen simultaneously
  }

  // Dequeue data
  io.deq.bits := ram(deq_ptr)

  // Count calculation
  io.count := Mux(ptr_match,
    Mux(maybe_full, entries.U, 0.U),
    Mux(enq_ptr > deq_ptr, enq_ptr - deq_ptr, entries.U + enq_ptr - deq_ptr))

  // Flush logic
  if (hasFlush) {
    when(io.flush.get) {
      enq_ptr := 0.U
      deq_ptr := 0.U
      maybe_full := false.B
    }
  }
}
