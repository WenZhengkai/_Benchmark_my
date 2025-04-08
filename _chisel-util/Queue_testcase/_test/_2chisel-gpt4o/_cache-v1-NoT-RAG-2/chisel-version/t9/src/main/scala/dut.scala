import chisel3._
import chisel3.util._

class dut[T <: Data](gen: T, entries: Int, hasFlush: Boolean = false) extends Module {
  require(entries > 0, "Number of entries must be a positive integer")

  val io = IO(new Bundle {
    // Enqueue Interface
    val enq = Flipped(Decoupled(gen))  // Input: enq.bits (data), enq.valid (handshake), enq.ready (handshake)
  
    // Dequeue Interface
    val deq = Decoupled(gen)           // Output: deq.bits (data), deq.valid (handshake), deq.ready (handshake)
  
    // Count of current elements in the queue
    val count = Output(UInt(log2Ceil(entries + 1).W))
  
    // Optional flush signal
    val flush = if (hasFlush) Some(Input(Bool())) else None
  })

  // Task 1: Implement Memory Storage (ram)
  val ram = Mem(entries, gen)

  // Task 2: Pointer Management
  val enq_ptr = RegInit(0.U(log2Ceil(entries).W)) // Enqueue pointer
  val deq_ptr = RegInit(0.U(log2Ceil(entries).W)) // Dequeue pointer
  val maybe_full = RegInit(false.B)               // Tracks whether the queue might be full

  // Pointer equality
  val ptr_match = enq_ptr === deq_ptr

  // Task 3: Full/Empty Logic
  val full = ptr_match && maybe_full
  val empty = ptr_match && !maybe_full

  io.enq.ready := !full
  io.deq.valid := !empty

  // Task 4: Enqueue Logic
  val do_enq = io.enq.valid && io.enq.ready
  when(do_enq) {
    ram(enq_ptr) := io.enq.bits                // Write data to the memory
    enq_ptr := Mux(enq_ptr === (entries - 1).U, 0.U, enq_ptr + 1.U) // Increment pointer and wrap around
  }

  // Update maybe_full during enqueue
  when(do_enq && !(io.deq.valid && io.deq.ready)) {
    maybe_full := true.B
  }

  // Task 5: Dequeue Logic
  val do_deq = io.deq.ready && io.deq.valid
  io.deq.bits := ram(deq_ptr)                // Read data from the memory
  when(do_deq) {
    deq_ptr := Mux(deq_ptr === (entries - 1).U, 0.U, deq_ptr + 1.U) // Increment pointer and wrap around
  }

  // Update maybe_full during dequeue
  when(do_deq && !(io.enq.valid && io.enq.ready)) {
    maybe_full := false.B
  }

  // Task 6: Flush Mechanism (Conditional)
  if (hasFlush) {
    when(io.flush.get) {
      enq_ptr := 0.U                        // Reset enqueue pointer
      deq_ptr := 0.U                        // Reset dequeue pointer
      maybe_full := false.B                 // Clear full/empty status
    }
  }

  // Task 7: Count Calculation
  val is_pow2 = isPow2(entries)
  val ptr_diff = enq_ptr - deq_ptr

  io.count := MuxCase(0.U, Seq(
    (empty, 0.U),
    (!empty && is_pow2.B, Mux(maybe_full, entries.U, ptr_diff)),
    (!empty && !is_pow2.B, Mux(
      enq_ptr >= deq_ptr, 
      enq_ptr - deq_ptr, 
      entries.U - deq_ptr + enq_ptr
    ))
  ))
}

