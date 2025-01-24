import chisel3._
import chisel3.util._

class dut[T <: Data](gen: T, entries: Int, hasFlush: Boolean) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(gen)) // Enqueue interface
    val deq = Decoupled(gen)          // Dequeue interface
    val count = Output(UInt(log2Ceil(entries + 1).W))
    val flush = if (hasFlush) Some(Input(Bool())) else None
  })

  // Task 1: Implement ram (Memory for Storage)
  val ram = Mem(entries, gen)

  // Task 2: Implement Pointer Management
  val enq_ptr = RegInit(0.U(log2Ceil(entries).W))
  val deq_ptr = RegInit(0.U(log2Ceil(entries).W))
  val ptr_match = enq_ptr === deq_ptr

  // Task 3: Implement Full/Empty Logic
  val maybe_full = RegInit(false.B)
  val full = ptr_match && maybe_full
  val empty = ptr_match && !maybe_full

  // Task 4: Implement Data Enqueue Logic
  val do_enq = io.enq.valid && !full
  when(do_enq) {
    ram(enq_ptr) := io.enq.bits
    enq_ptr := enq_ptr + 1.U
    when(enq_ptr === (entries - 1).U) { enq_ptr := 0.U }
  }

  // Task 5: Implement Data Dequeue Logic
  val do_deq = io.deq.ready && !empty
  io.deq.bits := 0.U.asTypeOf(gen) // Default value

  when(do_deq) {
    io.deq.bits := ram(deq_ptr)
    deq_ptr := deq_ptr + 1.U
    when(deq_ptr === (entries - 1).U) { deq_ptr := 0.U }
  }

  // Update maybe_full flag
  when(do_enq =/= do_deq) {
    maybe_full := do_enq
  }

  // Task 6: Implement Flush Mechanism (Optional Feature)
  if (hasFlush) {
    when(io.flush.get) {
      enq_ptr := 0.U
      deq_ptr := 0.U
      maybe_full := false.B
    }
  }

  // Task 7: Implement Count Calculation Logic
  val ptr_diff = enq_ptr - deq_ptr
  io.count := Mux(enq_ptr >= deq_ptr, ptr_diff, (entries.U - deq_ptr) + enq_ptr)

  // Task 8: Implement Module Interface and Signals
  io.enq.ready := !full
  io.deq.valid := !empty

  // Task 9: Integrate and Handle Corner Cases
  // Handled by maintaining the logic integrity above.
}

