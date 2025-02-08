import chisel3._
import chisel3.util._

class QueueIO[T <: Data](private val gen: T, val entries: Int, val hasFlush: Boolean = false) extends Bundle {
  val enq = Flipped(Decoupled(gen))
  val deq = Decoupled(gen)
  val flush = if (hasFlush) Some(Input(Bool())) else None
}

class dut[T <: Data](gen: T, entries: Int, hasFlush: Boolean = false) extends Module {
  require(entries > 0, "Queue must have a positive number of entries.")

  val io = IO(new QueueIO(gen, entries, hasFlush))
  
  // Memory for storage
  val ram = Mem(entries, gen)
  
  // Pointers
  val enq_ptr = RegInit(0.U(log2Ceil(entries).W))
  val deq_ptr = RegInit(0.U(log2Ceil(entries).W))
  
  // Pointer Match
  val ptr_match = enq_ptr === deq_ptr
  
  // Maybe full flag
  val maybe_full = RegInit(false.B)
  
  // Full/Empty signals
  val full = ptr_match && maybe_full
  val empty = ptr_match && !maybe_full
  
  // Enqueue
  val do_enq = io.enq.fire()
  when(do_enq) {
    ram(enq_ptr) := io.enq.bits
    enq_ptr := enq_ptr + 1.U
    when(enq_ptr === (entries - 1).U) {
      enq_ptr := 0.U
    }
  }
  
  // Dequeue
  val do_deq = io.deq.fire()
  when(do_deq) {
    deq_ptr := deq_ptr + 1.U
    when(deq_ptr === (entries - 1).U) {
      deq_ptr := 0.U
    }
  }
  
  // Maybe full logic
  when(do_enq =/= do_deq) {
    maybe_full := do_enq
  }

  // Flush Logic
  if (hasFlush) {
    when(io.flush.get) {
      enq_ptr := 0.U
      deq_ptr := 0.U
      maybe_full := false.B
    }
  }
  
  // Data path connections
  io.enq.ready := !full
  io.deq.valid := !empty
  io.deq.bits := ram(deq_ptr)
  
  // Calculate number of elements
  def calculateCount: UInt = {
    val difference = enq_ptr - deq_ptr
    Mux(ptr_match,
      Mux(maybe_full, entries.U, 0.U),
      Mux(enq_ptr < deq_ptr, difference + entries.U, difference)
    )
  }
  
  val count = calculateCount
}

