import chisel3._
import chisel3.util._

class dut[T <: Data](
    gen: T,
    entries: Int,
    hasFlush: Boolean = false
) extends Module {
  require(entries > 0, "Number of entries must be greater than 0")
  require(isPow2(entries), "Number of entries must be a power of 2")

  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(gen)) // Input for enqueue
    val deq = Decoupled(gen)         // Output for dequeue
    val count = Output(UInt(log2Ceil(entries + 1).W))
    val flush = if (hasFlush) Some(Input(Bool())) else None
  })

  // Task 1: Implement the memory storage (RAM)
  val ram = Mem(entries, gen)

  // Task 2: Pointer management
  val enq_ptr = RegInit(0.U(log2Ceil(entries).W))
  val deq_ptr = RegInit(0.U(log2Ceil(entries).W))
  val maybe_full = RegInit(false.B)

  val ptr_match = enq_ptr === deq_ptr

  // Task 3: Full/empty logic
  val full = ptr_match && maybe_full
  val empty = ptr_match && !maybe_full

  io.enq.ready := !full
  io.deq.valid := !empty

  // Task 4: Enqueue logic
  val do_enq = io.enq.valid && io.enq.ready
  when(do_enq) {
    ram.write(enq_ptr, io.enq.bits)
    enq_ptr := enq_ptr + 1.U
    when(enq_ptr === (entries - 1).U) {
      enq_ptr := 0.U
    }
  }

  // Task 5: Dequeue logic
  val do_deq = io.deq.ready && io.deq.valid
  when(do_deq) {
    deq_ptr := deq_ptr + 1.U
    when(deq_ptr === (entries - 1).U) {
      deq_ptr := 0.U
    }
  }

  // Update the `maybe_full` flag
  when(do_enq && !do_deq) {
    maybe_full := true.B
  }.elsewhen(!do_enq && do_deq) {
    maybe_full := false.B
  }

  // Task 6: Flush mechanism
  if (hasFlush) {
    when(io.flush.getOrElse(false.B)) {
      enq_ptr := 0.U
      deq_ptr := 0.U
      maybe_full := false.B
    }
  }

  // Task 7: Count calculation
  io.count := {
    val diff = enq_ptr - deq_ptr
    Mux(ptr_match, Mux(maybe_full, entries.U, 0.U), Mux(enq_ptr > deq_ptr, diff, entries.U - diff))
  }

  // Connect the data output from the memory (dequeue operation)
  io.deq.bits := ram.read(deq_ptr)
}
