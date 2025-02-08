import chisel3._
import chisel3.util._

class dut[T <: Data](gen: T, entries: Int, hasFlush: Boolean = false) extends Module {
  require(entries > 0, "Queue size must be positive")

  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(gen))
    val deq = Decoupled(gen)
    val count = Output(UInt(log2Ceil(entries + 1).W))
    val flush = if (hasFlush) Some(Input(Bool())) else None
  })

  // Task 1: Implement Memory for Storage
  val ram = Mem(entries, gen)

  // Task 2: Implement Pointer Management
  val enq_ptr = RegInit(0.U(log2Ceil(entries).W))
  val deq_ptr = RegInit(0.U(log2Ceil(entries).W))
  val maybe_full = RegInit(false.B)

  private def ptrMatch = enq_ptr === deq_ptr

  // Task 3: Implement Full/Empty Logic
  private def empty = ptrMatch && !maybe_full
  private def full = ptrMatch && maybe_full

  // Task 4: Implement Data Enqueue Logic
  when(io.enq.valid && io.enq.ready) {
    ram(enq_ptr) := io.enq.bits
    enq_ptr := enq_ptr + 1.U
    when(enq_ptr === (entries - 1).U) {
      enq_ptr := 0.U
    }
    when(ptrMatch) {
      maybe_full := true.B
    }
  }

  // Task 5: Implement Data Dequeue Logic
  io.deq.bits := ram(deq_ptr)
  io.deq.valid := !empty
  when(io.deq.ready && io.deq.valid) {
    deq_ptr := deq_ptr + 1.U
    when(deq_ptr === (entries - 1).U) {
      deq_ptr := 0.U
    }
    when(ptrMatch) {
      maybe_full := false.B
    }
  }

  // Task 6: Implement Flush Mechanism
  if (hasFlush && io.flush.isDefined) {
    when(io.flush.get) {
      enq_ptr := 0.U
      deq_ptr := 0.U
      maybe_full := false.B
    }
  }

  // Task 7: Calculate and Output Count
  val ptr_diff = enq_ptr - deq_ptr
  io.count := Mux(maybe_full, entries.U, ptr_diff)

  // Ready signals
  io.enq.ready := !full
}


