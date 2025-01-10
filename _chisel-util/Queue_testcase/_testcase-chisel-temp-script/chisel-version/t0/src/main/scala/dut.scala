import chisel3._
import chisel3.util._

class dut[T <: Data](gen: T, val entries: Int, val hasFlush: Boolean = false) extends Module {
  require(entries > 0, "Queue must have a positive number of entries")

  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(gen))
    val deq = Decoupled(gen)
    val count = Output(UInt(log2Ceil(entries + 1).W))
    val flush = if (hasFlush) Some(Input(Bool())) else None
  })

  // Memory for storage
  val ram = Mem(entries, gen)

  // Pointer management
  val enq_ptr = Counter(entries)
  val deq_ptr = Counter(entries)
  val maybe_full = RegInit(false.B)

  // Full/Empty logic
  val ptr_match = enq_ptr.value === deq_ptr.value
  val empty = ptr_match && !maybe_full
  val full = ptr_match && maybe_full

  // Default signals
  io.enq.ready := !full
  io.deq.valid := !empty

  // Update maybe_full
  when(io.enq.fire() =/= io.deq.fire()) {
    maybe_full := io.enq.fire()
  }

  // Enqueue logic
  when(io.enq.fire()) {
    ram(enq_ptr.value) := io.enq.bits
    enq_ptr.inc()
  }

  // Dequeue logic
  when(io.deq.fire()) {
    io.deq.bits := ram(deq_ptr.value)
    deq_ptr.inc()
  }

  // Count calculation
  io.count := Mux(ptr_match,
                  Mux(maybe_full, entries.U, 0.U),
                  Mux(deq_ptr.value > enq_ptr.value,
                    entries.U + enq_ptr.value - deq_ptr.value,
                    enq_ptr.value - deq_ptr.value))

  // Flush mechanism
  if (hasFlush) {
    when(io.flush.get) {
      enq_ptr.value := 0.U
      deq_ptr.value := 0.U
      maybe_full := false.B
    }
  }
}
