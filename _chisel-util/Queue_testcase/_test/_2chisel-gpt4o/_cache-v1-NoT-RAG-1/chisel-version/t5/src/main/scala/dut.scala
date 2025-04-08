import chisel3._
import chisel3.util._

class dut[T <: Data](gen: T, entries: Int, hasFlush: Boolean = false) extends Module {
  require(entries > 0, "Queue entries must be a positive integer.")
  
  val isPow2Entries = isPow2(entries) // Check if entries is a power of two
  
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(gen)) // enq.bits and enq.valid
    val deq = Decoupled(gen)         // deq.bits and deq.valid
    val count = Output(UInt(log2Ceil(entries + 1).W))
    val flush = if (hasFlush) Some(Input(Bool())) else None
  })

  // Task 1: Memory Storage (`ram`)
  val ram = Mem(entries, gen)

  // Task 2: Pointer Management
  val enq_ptr = RegInit(0.U(log2Ceil(entries).W))
  val deq_ptr = RegInit(0.U(log2Ceil(entries).W))
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
    ram.write(enq_ptr, io.enq.bits)
    enq_ptr := WrapInc(enq_ptr)
    when(!io.deq.ready || !io.deq.valid) { // Enqueue without simultaneous dequeue
      maybe_full := true.B
    }
  }

  // Task 5: Dequeue Logic
  val do_deq = io.deq.ready && io.deq.valid
  when(do_deq) {
    deq_ptr := WrapInc(deq_ptr)
    when(!io.enq.valid || !io.enq.ready) { // Dequeue without simultaneous enqueue
      maybe_full := false.B
    }
  }

  io.deq.bits := ram.read(deq_ptr)

  // Task 6: Flush Mechanism (Conditionally included)
  if (hasFlush) {
    when(io.flush.get) {
      enq_ptr := 0.U
      deq_ptr := 0.U
      maybe_full := false.B
    }
  }

  // Task 7: Count Calculation
  val count = Wire(UInt(log2Ceil(entries + 1).W))
  when(ptr_match) {
    count := Mux(maybe_full, entries.U, 0.U)
  }.elsewhen(enq_ptr > deq_ptr) {
    count := enq_ptr - deq_ptr
  }.otherwise {
    count := entries.U - deq_ptr + enq_ptr
  }
  io.count := count

  // Helper function for pointer wrap-around
  def WrapInc(ptr: UInt): UInt = {
    if (isPow2Entries) {
      ptr + 1.U
    } else {
      Mux(ptr + 1.U >= entries.U, 0.U, ptr + 1.U)
    }
  }
}
