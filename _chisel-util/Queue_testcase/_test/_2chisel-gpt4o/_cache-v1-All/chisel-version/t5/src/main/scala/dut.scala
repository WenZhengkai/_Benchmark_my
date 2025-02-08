import chisel3._
import chisel3.util._

class dut[T <: Data](gen: T, entries: Int, hasFlush: Boolean = false) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(gen)) // Input ready/valid interface for enqueue
    val deq = Decoupled(gen)          // Output ready/valid interface for dequeue
    val flush = if (hasFlush) Some(Input(Bool())) else None // Optional flush input
    val count = Output(UInt(log2Ceil(entries + 1).W)) // Number of elements in the queue
  })

  // Task 1: Implement Memory for Storage
  val ram = Mem(entries, gen)

  // Task 2: Implement Pointer Management
  val enq_ptr = RegInit(0.U(log2Ceil(entries).W))
  val deq_ptr = RegInit(0.U(log2Ceil(entries).W))
  val maybe_full = RegInit(false.B)

  val ptr_match = enq_ptr === deq_ptr

  // Task 3: Implement Full/Empty Logic
  val full = ptr_match && maybe_full
  val empty = ptr_match && !maybe_full

  io.enq.ready := !full
  io.deq.valid := !empty

  // Task 4: Implement Data Enqueue Logic
  when(io.enq.fire()) {
    ram(enq_ptr) := io.enq.bits
    enq_ptr := Mux(enq_ptr === (entries - 1).U, 0.U, enq_ptr + 1.U)
  }

  // Task 5: Implement Data Dequeue Logic
  io.deq.bits := ram(deq_ptr)
  when(io.deq.fire()) {
    deq_ptr := Mux(deq_ptr === (entries - 1).U, 0.U, deq_ptr + 1.U)
  }

  // Update maybe_full logic
  when(io.enq.fire() =/= io.deq.fire()) {
    maybe_full := io.enq.fire()
  }

  // Task 6: Implement Flush Mechanism
  if (hasFlush) {
    when(io.flush.get) {
      enq_ptr := 0.U
      deq_ptr := 0.U
      maybe_full := false.B
    }
  }

  // Task 7: Calculate and Output Count
  val ptr_diff = enq_ptr - deq_ptr
  io.count := Mux(maybe_full, entries.U, 0.U) + ptr_diff

}


