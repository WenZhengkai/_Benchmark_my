import chisel3._
import chisel3.util._

class dut[T <: Data](gen: T, val entries: Int, val hasFlush: Boolean = false) extends Module {
  require(entries > 0, "Number of entries must be a positive integer.")
  
  val io = IO(new Bundle {
    val enq    = Flipped(Decoupled(gen))
    val deq    = Decoupled(gen)
    val count  = Output(UInt(log2Ceil(entries + 1).W))
    val flush  = if (hasFlush) Some(Input(Bool())) else None
  })

  // Task 1: Implement Memory for Storage
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
  when(io.enq.fire()) {
    ram(enq_ptr) := io.enq.bits
    enq_ptr := enq_ptr + 1.U
    when(enq_ptr === (entries - 1).U) {
      enq_ptr := 0.U
    }
    when(io.deq.ready === false.B) {
      maybe_full := true.B
    }
  }

  // Task 5: Implement Data Dequeue Logic
  io.deq.bits := 0.U.asTypeOf(gen) // Default value
  when(io.deq.fire()) {
    io.deq.bits := ram(deq_ptr)
    deq_ptr := deq_ptr + 1.U
    when(deq_ptr === (entries - 1).U) {
      deq_ptr := 0.U
    }
    maybe_full := false.B
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
  io.count := Mux(maybe_full && ptr_match, entries.U, ptr_diff)
  
  // Decouple logic
  io.enq.ready := !full
  io.deq.valid := !empty
}

// Example usage:
// val queue = Module(new dut(UInt(8.W), 4, hasFlush = true))
