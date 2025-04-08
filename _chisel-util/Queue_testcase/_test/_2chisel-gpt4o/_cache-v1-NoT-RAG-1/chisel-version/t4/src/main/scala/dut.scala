import chisel3._
import chisel3.util._

class dut[T <: Data](gen: T, entries: Int, hasFlush: Boolean = false) extends Module {
  require(entries > 0, "Queue entries must be a positive number")

  // Log2 utility for pointer width
  private val ptrWidth = log2Ceil(entries)

  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(gen)) // Enqueue interface
    val deq = Decoupled(gen)         // Dequeue interface
    val count = Output(UInt(ptrWidth.W)) // Number of elements in the queue

    // Conditional flush signal based on hasFlush
    val flush = if (hasFlush) Some(Input(Bool())) else None
  })

  // Task 1: Implement Memory Storage (`ram`)
  val ram = Mem(entries, gen)

  // Task 2: Pointer Management
  val enq_ptr = RegInit(0.U(ptrWidth.W))
  val deq_ptr = RegInit(0.U(ptrWidth.W))
  val maybe_full = RegInit(false.B)

  val ptr_match = enq_ptr === deq_ptr

  // Task 3: Full/Empty Logic
  val full = ptr_match && maybe_full
  val empty = ptr_match && !maybe_full

  io.enq.ready := !full
  io.deq.valid := !empty

  // Task 4: Enqueue Logic
  val do_enq = io.enq.valid && io.enq.ready
  when(do_enq) {
    ram(enq_ptr) := io.enq.bits
    enq_ptr := Mux(enq_ptr === (entries - 1).U, 0.U, enq_ptr + 1.U)
    when(!io.deq.fire()) { maybe_full := true.B }
  }

  // Task 5: Dequeue Logic
  val do_deq = io.deq.ready && io.deq.valid
  when(do_deq) {
    deq_ptr := Mux(deq_ptr === (entries - 1).U, 0.U, deq_ptr + 1.U)
    when(!io.enq.fire()) { maybe_full := false.B }
  }

  io.deq.bits := ram(deq_ptr)

  // Task 6: Flush Mechanism (Conditional)
  if (hasFlush) {
    when(io.flush.get) {
      enq_ptr := 0.U
      deq_ptr := 0.U
      maybe_full := false.B
    }
  }

  // Task 7: Count Calculation
  val count = Wire(UInt(ptrWidth.W))
  when(ptr_match) {
    count := Mux(maybe_full, entries.U, 0.U)
  }.otherwise {
    when(enq_ptr > deq_ptr) {
      count := enq_ptr - deq_ptr
    }.otherwise {
      count := entries.U - deq_ptr + enq_ptr
    }
  }
  io.count := count
}
