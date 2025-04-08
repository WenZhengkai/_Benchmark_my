import chisel3._
import chisel3.util._

class dut[T <: Data](
  gen: T,
  entries: Int,
  hasFlush: Boolean = false
) extends Module {

  require(entries > 0, "Number of entries must be greater than 0")

  // Define IO
  val io = IO(new Bundle {
    // Enqueue interface
    val enq = new DecoupledIO(gen) // .bits (T), .valid (Bool), .ready (Bool)
    // Dequeue interface
    val deq = Flipped(new DecoupledIO(gen)) // .bits (T), .valid (Bool), .ready (Bool)
    // Optional flush signal
    val flush = if (hasFlush) Some(Input(Bool())) else None
    // Current count of entries in the queue
    val count = Output(UInt(log2Ceil(entries + 1).W))
  })

  // Memory storage (Task 1)
  val ram = Mem(entries, gen)

  // Pointer management (Task 2)
  val enq_ptr = RegInit(0.U(log2Ceil(entries).W))
  val deq_ptr = RegInit(0.U(log2Ceil(entries).W))
  val maybe_full = RegInit(false.B)

  // Pointer equality check (used for full/empty logic)
  val ptr_match = enq_ptr === deq_ptr

  // Full/Empty logic (Task 3)
  val full = ptr_match && maybe_full
  val empty = ptr_match && !maybe_full

  // Connect ready/valid signals
  io.enq.ready := !full
  io.deq.valid := !empty

  // Enqueue logic (Task 4)
  val do_enq = io.enq.valid && io.enq.ready
  when(do_enq) {
    ram.write(enq_ptr, io.enq.bits)
    enq_ptr := Mux(enq_ptr === (entries - 1).U, 0.U, enq_ptr + 1.U)
  }

  // Update maybe_full for enqueue
  when(do_enq && !io.deq.ready) {
    maybe_full := true.B
  }

  // Dequeue logic (Task 5)
  val do_deq = io.deq.ready && io.deq.valid
  when(do_deq) {
    deq_ptr := Mux(deq_ptr === (entries - 1).U, 0.U, deq_ptr + 1.U)
  }

  // Update maybe_full for dequeue
  when(do_deq && !io.enq.valid) {
    maybe_full := false.B
  }

  // Optional flush mechanism (Task 6)
  if (hasFlush) {
    when(io.flush.getOrElse(false.B)) {
      enq_ptr := 0.U
      deq_ptr := 0.U
      maybe_full := false.B
    }
  }

  // Data output for dequeue
  io.deq.bits := ram.read(deq_ptr)

  // Count calculation (Task 7)
  val diff = Mux(enq_ptr >= deq_ptr, enq_ptr - deq_ptr, (entries.U + enq_ptr) - deq_ptr)
  io.count := Mux(full, entries.U, diff)
}

// Test instantiating the module
